include("gen_routines.jl")
using .base_routines

include("parameters.jl")
using .paras
using FFTW
using Plots
using LaTeXStrings
using NPZ
using Distributed
using DelimitedFiles

ENV["GKSwstype"] = "100"

function compute(i)
    #Populate N^3 lattice with Higgs field with random phases
    phi_arr = random_gen(p_arr_0,N)

    #Compute derivatives with central differences
    dphi_arr = pbc_cen_diff(phi_arr,dp_arr_0,N)

    #Compute B and A from 
    # A_{\mu\nu}
    # =-i\frac{2\sin\theta_w}{g\eta^2}(\partial_\mu \Phi^\dagger \partial_\nu \Phi - \partial_\nu \Phi^\dagger \partial_\mu \Phi)
    
    B_arr = (2*sw/gw).*B_cal_arr(dphi_arr,B_arr_0,N)

    A_arr = (2*sw/gw).*A_cal_arr(dphi_arr,phi_arr,A_arr_0,N)

    #Vertical array for exporting fortran readable data
    #Shape is N^3*6
    #Columns correspond to (x,y,z,B_x,B_y,B_z)
    A_arr_ver = hcat(vec(B_arr[:,:,:,1]),vec(B_arr[:,:,:,2]),vec(B_arr[:,:,:,3]),
    vec(A_arr[:,:,:,1]),
    vec(A_arr[:,:,:,2]),
    vec(A_arr[:,:,:,3]))
    
    #Writing files
    open(string("data/","A_",i,".dat"),"w") do io
        writedlm(io, A_arr_ver)
    end

    curl_A = curl_A_arr(A_arr, curl_A_0,N)

    #Compute spectrum from direct definition of B
    B_spec_raw,B_spec = B_spectrum(B_arr,N,nbins)
    npzwrite(string("data/","spectrum_1_",i,".npz"),B_spec)
    npzwrite(string("data/","raw_spectrum_1_",i,".npz"),B_spec_raw)

    #Calculate B from curl A and compute the corresponding spectra
    B_arr[:,:,:,4] = curl_A[:,:,:,1]
    B_arr[:,:,:,5] = curl_A[:,:,:,2]
    B_arr[:,:,:,6] = curl_A[:,:,:,3]
    
    B_spec_raw,B_spec,B_fft = B_spectrum(B_arr,N,nbins)
    npzwrite(string("data/","spectrum_2_",i,".npz"),B_spec)
    npzwrite(string("data/","raw_spectrum_2_",i,".npz"),B_spec_raw)
    npzwrite(string("data/","B_fft_",i,".npz"),B_fft)
    return
end

#execute function compute in parallel 
Threads.@threads for i in range(1,N_rels,step=1)
    @time compute(i)
end

stacked_fft = zeros((N_rels,N,N,N))

@time Threads.@threads for i in range(1,N_rels,step=1)
    B_fft = npzread(string("data/","B_fft_",i,".npz"))
    stacked_fft[i,:,:,:]=B_fft
    rm(string("data/","B_fft_",i,".npz"))
end

npzwrite(string("data/","B_fft_stacked_.npz"),stacked_fft)