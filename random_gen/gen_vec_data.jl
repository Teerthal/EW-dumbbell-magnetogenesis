include("gen_routines.jl")
using .base_routines

include("parameters.jl")
using .paras
using FFTW
phi_arr = random_gen(p_arr_0,N)

# println(size(phi_arr))

dphi_arr = pbc_cen_diff(phi_arr,dp_arr_0,N)

A_arr = A_cal_arr(dphi_arr,phi_arr,A_arr_0,N).*(2*sw*vev/gw)

coord_stack = zeros(Float64,(N,N,N,3))
for i in range(1,N,step=1)
    for j in range(1,N,step=1)
        for k in range(1,N,step=1)
            coord_stack[i,j,k,:]=[i,j,k]
        end
    end
end
A_arr_ver = hcat(vec(coord_stack[:,:,:,1]),vec(coord_stack[:,:,:,2]),vec(coord_stack[:,:,:,3]),
vec(A_arr[:,:,:,1]),
vec(A_arr[:,:,:,2]),
vec(A_arr[:,:,:,3]))
# exit()
using DelimitedFiles

open("dump.txt","w") do io
    writedlm(io, A_arr_ver)
end
exit()