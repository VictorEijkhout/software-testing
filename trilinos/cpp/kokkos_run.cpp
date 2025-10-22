#include <iostream>
#include <cmath>
#include <Kokkos_Core.hpp>

template <class ExecSpace>
void team_kernel_example(int N) {
  using TeamPolicy = Kokkos::TeamPolicy<ExecSpace>;
  using Member     = typename TeamPolicy::member_type;

  Kokkos::View<double*, ExecSpace> data("data", N);
  Kokkos::parallel_for("fill_seq", N, KOKKOS_LAMBDA(const int i){
    data(i) = 1.0 + i;
  });

  // Sum with a simple team policy
  double sum = 0.0;
  Kokkos::parallel_reduce(
      "team_sum", TeamPolicy(ExecSpace(), /*leagueSize*/1, /*teamSize*/Kokkos::AUTO),
      KOKKOS_LAMBDA(const Member& team, double& lsum) {
        Kokkos::parallel_reduce(
            Kokkos::TeamThreadRange(team, N),
            [&](const int i, double& inner){ inner += data(i); },
            lsum);
      },
      sum);

  // quick sanity: sum_{i=0}^{N-1} (1+i) = N + (N-1)N/2
  const double expected = N + 0.5*(N-1)*N;
  if (std::abs(sum - expected) > 1e-9) {
    printf("[team_kernel_example] MISMATCH: got %g expected %g\n", sum, expected);
  } else {
    printf("[team_kernel_example] OK  (sum=%g)\n", sum);
  }
}

int main(int argc, char* argv[]) {
  Kokkos::ScopeGuard guard(argc, argv); // RAII init/finalize

  std::cout << "==== Kokkos / Trilinos smoke test ====\n";
  Kokkos::print_configuration(std::cout);

  using Exec = Kokkos::DefaultExecutionSpace;
  std::cout << "DefaultExecutionSpace: " << Exec::name() << "\n";

  // --- 1) Basic Views + parallel_for / parallel_reduce (dot product) ---
  const int N = 1<<20; // 1M
  Kokkos::View<double*, Exec> x("x", N), y("y", N);

  Kokkos::parallel_for("init_xy", N, KOKKOS_LAMBDA(const int i){
    x(i) = 1.0;         // all ones
    y(i) = 2.0 + 0.5*i; // simple ramp
  });

  double dot = 0.0;
  Kokkos::parallel_reduce("dot", N,
    KOKKOS_LAMBDA(const int i, double& lsum){
      lsum += x(i) * y(i);
    }, dot);

  // Reference result: sum_i (1 * (2 + 0.5*i)) = 2N + 0.5*sum_i i
  const double ref_dot = 2.0*N + 0.5*( (N-1LL)*N/2.0 );
  std::cout << "dot(x,y) = " << dot << " (ref " << ref_dot << ")\n";
  if (std::abs(dot - ref_dot) < 1e-6*std::abs(ref_dot)) {
    std::cout << "[dot] OK\n";
  } else {
    std::cout << "[dot] MISMATCH!\n";
  }

  // --- 2) MDRangePolicy over 2D (tiny stencil-ish op) ---
  const int Nx = 512, Ny = 256;
  Kokkos::View<double**, Exec> A("A", Nx, Ny);

  Kokkos::MDRangePolicy<Kokkos::Rank<2>, Exec> box({0,0}, {Nx,Ny});
  Kokkos::parallel_for("fill_A", box, KOKKOS_LAMBDA(const int i, const int j){
    A(i,j) = 3.0*i - 2.0*j;
  });

  // simple check: sum over A should be 3*sum_i i * Ny - 2*sum_j j * Nx
  double sumA = 0.0;
  Kokkos::parallel_reduce("sum_A", box,
    KOKKOS_LAMBDA(const int i, const int j, double& lsum){
      lsum += A(i,j);
    }, sumA);

  const double si = (Nx-1LL)*Nx*0.5; // sum i=0..Nx-1
  const double sj = (Ny-1LL)*Ny*0.5;
  const double ref_sumA = 3.0*si*Ny - 2.0*sj*Nx;
  std::cout << "sum(A) = " << sumA << " (ref " << ref_sumA << ")\n";
  std::cout << ((std::abs(sumA - ref_sumA) < 1e-9*std::abs(ref_sumA)) ? "[A] OK\n"
                                                                      : "[A] MISMATCH!\n");


  /*
   * Is this for a different version of kokkos?
   */
  
  // // --- 3) DualView host/device modify/sync dance ---
  // Kokkos::DualView<double*> z("z", N);
  // // modify on host
  // z.modify_host();
  // auto hz = z.h_view;
  // for (int i=0; i<N; ++i) hz(i) = i*1.0;
  // z.sync_device();

  // // scale on device
  // Kokkos::parallel_for("scale_z", N, KOKKOS_LAMBDA(const int i){
  //   z.d_view(i) *= 2.0;
  // });
  // z.modify_device();
  // z.sync_host();

  // // quick check on host
  // bool ok = true;
  // for (int i=0; i<10; ++i) {
  //   const double expected = 2.0*i;
  //   if (std::abs(hz(i) - expected) > 1e-12) { ok = false; break; }
  // }
  // std::cout << "[DualView] " << (ok ? "OK" : "MISMATCH!") << "\n";

  // --- 4) Team policy example on default execution space ---
  team_kernel_example<Exec>(10000);

  std::cout << "==== Done ====\n";
  return 0;
}
