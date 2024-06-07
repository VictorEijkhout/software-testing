#include <silo.h>
#include <stdio.h>

int main(int argc, char *argv[]){
  DBfile *dbfile = NULL;
  /* Open the Silo file */
  dbfile = DBCreate("basic.silo", DB_CLOBBER,
		    DB_LOCAL, "Comment about the data", DB_HDF5);
  if(dbfile == NULL) {
    fprintf(stderr, "Could not create Silo file!\n"); return -1; }
  /* Add other Silo calls here.  */
  /* Create some points to save. */
#define NPTS 100
  int i, ndims = 2;
  float x[NPTS], y[NPTS];
  float *coords[] = {(float*)x, (float*)y};
  for(i = 0; i < NPTS; ++i){
    float t = ((float)i) / ((float)(NPTS-1));
    float angle = 3.14159 * 10. * t;
    x[i] = t * cos(angle);
    y[i] = t * sin(angle);
  }
  /* Write a point mesh. */
  DBPutPointmesh(dbfile, "pointmesh", ndims, coords, NPTS,DB_FLOAT, NULL);
  
  /* Close the Silo file. */
  DBClose(dbfile);
  return 0;
}
