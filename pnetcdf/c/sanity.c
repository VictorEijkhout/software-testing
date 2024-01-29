#include <stdio.h>
#include <stdlib.h>
#include <netcdf.h>

int main() {
    // Define the dimensions
    int ncid, varid, dimids[2];
    size_t dimlen[2] = {3, 4}; // Two dimensions: 3 rows and 4 columns
    int data[3][4] = {{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10, 11, 12}};

    // Create a new NetCDF file for writing
    if (nc_create("example.nc", NC_CLOBBER, &ncid) != NC_NOERR) {
        fprintf(stderr, "Error creating NetCDF file.\n");
        return 1;
    }
    // Close the NetCDF file
    if (nc_close(ncid) != NC_NOERR) {
        fprintf(stderr, "Error closing the NetCDF file.\n");
        return 1;
    }

    printf("NetCDF file 'example.nc' created and data written successfully.\n");

    return 0;
}
