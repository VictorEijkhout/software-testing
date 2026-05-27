// Source - https://stackoverflow.com/q/79947369
// Posted by H. Weirauch
// Retrieved 2026-05-27, License - CC BY-SA 4.0

#include <stdio.h>
#include <hdf5.h>

int main(int argc, char ** argv) {
        char *filename = "example.h5";

        MPI_Init(&argc, &argv);
        MPI_Barrier(MPI_COMM_WORLD);

        hid_t plist_id = H5Pcreate(H5P_FILE_ACCESS);
        MPI_Barrier(MPI_COMM_WORLD);

        H5Pset_fapl_mpio(plist_id, MPI_COMM_WORLD, MPI_INFO_NULL);
        MPI_Barrier(MPI_COMM_WORLD);

        hid_t file_id = H5Fcreate(filename, H5F_ACC_TRUNC, H5P_DEFAULT, plist_id);
        MPI_Barrier(MPI_COMM_WORLD);

        H5Pclose(plist_id);
        MPI_Barrier(MPI_COMM_WORLD);

        H5Fclose(file_id);
        MPI_Barrier(MPI_COMM_WORLD);

        MPI_Finalize();
        return 0;
}
