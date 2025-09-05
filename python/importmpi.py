from mpi4py import MPI
comm = MPI.COMM_WORLD
procid = comm.Get_rank()
print( f"MPI rank {procid}" )
