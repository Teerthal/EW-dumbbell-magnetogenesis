include("gen_routines.jl")
using .base_routines

include("parameters.jl")
using .paras
using FFTW

# using PyCall
# scriptdir = @__DIR__
# pushfirst!(PyVector(pyimport("sys")."path"), scriptdir)
# pylat = pyimport("Lattice")

# println(N)

phi_arr = random_gen(p_arr_0,N)

# println(size(phi_arr))

dphi_arr = pbc_cen_diff(phi_arr,dp_arr_0,N)
# println(size(dphi_arr))
B_arr = B_cal_arr(dphi_arr,B_arr_0,N)
# B_arr_ver = hcat(vec(B_arr[:,:,:,1]),vec(B_arr[:,:,:,2]),vec(B_arr[:,:,:,3]),
# vec(B_arr[:,:,:,4]),vec(B_arr[:,:,:,5]),vec(B_arr[:,:,:,6]))
# println(B_arr_ver[1,:])

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
curl_A = curl_A_arr(A_arr, curl_A_0,N)
B_spec = B_spectrum(B_arr,N)
# E_M1 = pylat.spec_convolve(B_arr)
spec1 = B_spec[:,2]
# println(size(B_spec))
# println(size(E_M1))
# spec1 = B_spec[1:floor(Int,size(B_spec,1)/2),2]+reverse(B_spec[(size(B_spec,1)/2+1):N,2])
# for s in eachrow(B_spec) println(s) end
# for s in eachrow(E_M1) println(s) end
# exit()
B_arr[:,:,:,4] = curl_A[:,:,:,1]
B_arr[:,:,:,5] = curl_A[:,:,:,2]
B_arr[:,:,:,6] = curl_A[:,:,:,3]
# println(size(spec1))

using Plots
# pythonplot()
using LaTeXStrings
B_spec = B_spectrum(B_arr,N)
# E_M2 = pylat.spec_convolve(B_arr)
# println(size(E_M2))
spec2 = B_spec[:,2]
# println(size(spec2))
# spec2 = B_spec[1:floor(Int,N/2),2]+reverse(B_spec[floor(Int,N/2)+1:N,2])

plot(B_spec[:,1].+1,spec1./(((B_spec[:,1].+1).*(B_spec[:,1].+1)).*N^6),label=L"$B_k$",linestyle=:dot,marker=:circle,markersize=0.5)
plot!(B_spec[:,1].+1,spec2./(((B_spec[:,1].+1).*(B_spec[:,1].+1)).*N^6),label=L"$\nabla\times A$",linestyle=:dot,marker=:circle,markersize=0.5)
p=plot!(yscale=:log10,minorgrid=true,dpi=600)
savefig(p,"spectra")
display(p)


plot(B_spec[:,1].+1,spec1./(((B_spec[:,1].+1).*(B_spec[:,1].+1)).*N^6),label=L"$B_k$",linestyle=:dot)
plot!(B_spec[:,1].+1,spec2./(((B_spec[:,1].+1).*(B_spec[:,1].+1)).*N^6),label=L"$\nabla\times A$",linestyle=:dot)
p=plot!(yscale=:log10,minorgrid=true,dpi=600)
savefig(p,"spectra_solid")
display(p)

using CairoMakie
makie_fn(x,y,z)=Point3f(B_arr[x,y,z,4],B_arr[x,y,z,5],B_arr[x,y,z,6])
# p=streamplot(vec(B_arr[:,:,:,3]),vec(B_arr[:,:,:,4]),vec(B_arr[:,:,:,5]),vec(B_arr[:,:,:,1]),vec(B_arr[:,:,:,2]),vec(B_arr[:,:,:,3]))
p=arrows(vec(B_arr[:,:,:,1]),vec(B_arr[:,:,:,2]),vec(B_arr[:,:,:,3]),
vec(B_arr[:,:,:,4])/vec(.√(B_arr[:,:,:,4].*B_arr[:,:,:,4]+B_arr[:,:,:,5].*B_arr[:,:,:,5]+B_arr[:,:,:,6].*B_arr[:,:,:,6])),
vec(B_arr[:,:,:,5])/vec(.√(B_arr[:,:,:,4].*B_arr[:,:,:,4]+B_arr[:,:,:,5].*B_arr[:,:,:,5]+B_arr[:,:,:,6].*B_arr[:,:,:,6])),
vec(B_arr[:,:,:,6])/vec(.√(B_arr[:,:,:,4].*B_arr[:,:,:,4]+B_arr[:,:,:,5].*B_arr[:,:,:,5]+B_arr[:,:,:,6].*B_arr[:,:,:,6])))
display(p)

div_B = B_div(B_arr,divB_arr_0,N)
println(size(div_B))

plt=histogram(vec(div_B))#,yscale=:log10)
display(plt)

fluxes = charges(B_arr,flux_arr_0,N)
plt=histogram(vec(fluxes))
display(plt)

dvcharges = div_charges(div_B,dvcharges_arr_0,N)
plt=histogram((vec(dvcharges)),yscale=:log10)
display(plt)

