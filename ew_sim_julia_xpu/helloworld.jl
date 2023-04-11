# using MPI, CUDA
# MPI.Init()
# comm = MPI.COMM_WORLD
# me   = MPI.Comm_rank(comm)
# # select device
# comm_l = MPI.Comm_split_type(comm, MPI.MPI_COMM_TYPE_SHARED, me)
# me_l   = MPI.Comm_rank(comm_l)
# GPU_ID = CUDA.device!(me_l)
# sleep(0.5me)
# println("Hello world, I am $(me) of $(MPI.Comm_size(comm)) using $(GPU_ID)")
# MPI.Barrier(comm)

using ImplicitGlobalGrid

init_global_grid(10,10,10)

select_device