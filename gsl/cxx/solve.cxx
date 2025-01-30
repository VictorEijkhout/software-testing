/*
 * https://chatgpt.com/share/679b9cfd-ea88-8013-9093-b2ff5b0b7d18
 */
#include <iostream>
#include <gsl/gsl_matrix.h>
#include <gsl/gsl_vector.h>
#include <gsl/gsl_permutation.h>
#include <gsl/gsl_linalg.h>

int main() {
    // Define a 2x2 matrix A
    gsl_matrix* A = gsl_matrix_alloc(2, 2);
    gsl_matrix_set(A, 0, 0, 3.0);
    gsl_matrix_set(A, 0, 1, 2.0);
    gsl_matrix_set(A, 1, 0, 1.0);
    gsl_matrix_set(A, 1, 1, 4.0);

    // Define the right-hand side vector b
    gsl_vector* b = gsl_vector_alloc(2);
    gsl_vector_set(b, 0, 5.0);
    gsl_vector_set(b, 1, 6.0);

    // Allocate solution vector x
    gsl_vector* x = gsl_vector_alloc(2);

    // Allocate a permutation for the pivoting
    gsl_permutation* p = gsl_permutation_alloc(2);
    int signum;

    // Perform LU decomposition
    gsl_linalg_LU_decomp(A, p, &signum);

    // Solve the system Ax = b
    gsl_linalg_LU_solve(A, p, b, x);

    // Print the solution
    std::cout << "Solution x:\n";
    for (size_t i = 0; i < 2; i++) {
        std::cout << gsl_vector_get(x, i) << std::endl;
    }

    // Free allocated memory
    gsl_matrix_free(A);
    gsl_vector_free(b);
    gsl_vector_free(x);
    gsl_permutation_free(p);

    return 0;
}
