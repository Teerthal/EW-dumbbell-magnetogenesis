include("gen_routines.jl")
using .base_routines

include("parameters.jl")
using .paras
using FFTW
using Plots
using LaTeXStrings
using NPZ
using Distributed
# using PyCall
# scriptdir = @__DIR__
# pushfirst!(PyVector(pyimport("sys")."path"), scriptdir)
# pylat = pyimport("Lattice")
ENV["GKSwstype"] = "100"
# println(N)
function compute(i)
    phi_arr = random_gen(p_arr_0,N)

    # println(size(phi_arr))

    dphi_arr = pbc_cen_diff(phi_arr,dp_arr_0,N)
    # println(size(dphi_arr))
    B_arr = B_cal_arr(dphi_arr,B_arr_0,N)

    # B_arr_ver = hcat(vec(B_arr[:,:,:,1]),vec(B_arr[:,:,:,2]),vec(B_arr[:,:,:,3]),
    # vec(B_arr[:,:,:,4]),vec(B_arr[:,:,:,5]),vec(B_arr[:,:,:,6]))

    A_arr = A_cal_arr(dphi_arr,phi_arr,A_arr_0,N)
    curl_A = curl_A_arr(A_arr, curl_A_0,N)
    B_spec_raw,B_spec = B_spectrum(B_arr,N,nbins)
    npzwrite(string("data/","spectrum_1_",i,".npz"),B_spec)
    npzwrite(string("data/","raw_spectrum_1_",i,".npz"),B_spec_raw)
    # E_M1 = pylat.spec_convolve(B_arr)
    spec1 = B_spec[:,2]
    # println(size(B_spec))
    # println(Kc_bin_nums(N));exit()
    # println(size(E_M1))
    # spec1 = B_spec[1:floor(Int,size(B_spec,1)/2),2]+reverse(B_spec[(size(B_spec,1)/2+1):N,2])
    # for s in eachrow(B_spec) println(s) end
    # for s in eachrow(E_M1) println(s) end
    # exit()
    B_arr[:,:,:,4] = curl_A[:,:,:,1]
    B_arr[:,:,:,5] = curl_A[:,:,:,2]
    B_arr[:,:,:,6] = curl_A[:,:,:,3]
    # println(size(spec1))

    
    # pythonplot()
    
    B_spec_raw,B_spec = B_spectrum(B_arr,N,nbins)
    npzwrite(string("data/","spectrum_2_",i,".npz"),B_spec)
    npzwrite(string("data/","raw_spectrum_2_",i,".npz"),B_spec_raw)
    # E_M2 = pylat.spec_convolve(B_arr)
    # println(size(E_M2))
    spec2 = B_spec[:,2]
    # println(size(spec2))
    # spec2 = B_spec[1:floor(Int,N/2),2]+reverse(B_spec[floor(Int,N/2)+1:N,2])

    # plot(B_spec[:,1].+1,spec1./(((B_spec[:,1].+1).*(B_spec[:,1].+1)).*N^6),label=L"$B_k$",linestyle=:dot,marker=:circle,markersize=0.5)
    # plot!(B_spec[:,1].+1,spec2./(((B_spec[:,1].+1).*(B_spec[:,1].+1)).*N^6),label=L"$\nabla\times A$",linestyle=:dot,marker=:circle,markersize=0.5)
    # p=plot!(yscale=:log10,minorgrid=true,dpi=600)
    # savefig(p,string("data/plots/","spectra_",i))
    # # display(p)


    # plot(B_spec[:,1].+1,spec1./(((B_spec[:,1].+1).*(B_spec[:,1].+1)).*N^6),label=L"$B_k$",linestyle=:dot)
    # plot!(B_spec[:,1].+1,spec2./(((B_spec[:,1].+1).*(B_spec[:,1].+1)).*N^6),label=L"$\nabla\times A$",linestyle=:dot)
    # p=plot!(yscale=:log10,minorgrid=true,dpi=600)
    # savefig(p,string("data/plots/","spectra_solid",i))
    # # display(p)
    return
end

Threads.@threads for i in range(1,N_rels,step=1)
    # println(i," ",Threads.threadid())
    @time compute(i)
    # stacked_1[i,:,:]=npzread(string("data/","spectrum_1_",i,".npz"))
    # stacked_2[i,:,:]=npzread(string("data/","spectrum_2_",i,".npz"))
end
gr()
ENV["GKSwstype"]="nul"

binsize = size(range(1,Kc_bin_nums(N),step=floor.(Int,Kc_bin_nums(N)/nbins)),1)
# stacked_1 = zeros((N_rels,Kc_bin_nums(N),2))
# stacked_2 = zeros((N_rels,Kc_bin_nums(N),2))
# println(binsize)
stacked_1 = zeros((N_rels,binsize-1,2))
stacked_2 = zeros((N_rels,binsize-1,2))
stacked_1_raw= zeros((N_rels,Kc_bin_nums(N),2))
stacked_2_raw = zeros((N_rels,Kc_bin_nums(N),2))

@time for i in range(1,N_rels,step=1)
    # @time compute(i)
    B_spec = npzread(string("data/","spectrum_1_",i,".npz"))
    B_spec2 = npzread(string("data/","spectrum_2_",i,".npz"))
    B_spec_raw = npzread(string("data/","raw_spectrum_1_",i,".npz"))
    B_spec_raw_2 = npzread(string("data/","raw_spectrum_2_",i,".npz"))
    stacked_1[i,:,:]=B_spec
    stacked_2[i,:,:]=B_spec2
    stacked_1_raw[i,:,:]=B_spec_raw
    stacked_2_raw[i,:,:]=B_spec2_raw

    plot(B_spec[:,1].+1,B_spec[:,2]./(((B_spec[:,1].+1).*(B_spec[:,1].+1)).*N^6),label=L"$B_k$",linestyle=:dot,marker=:circle,markersize=0.5)
    plot!(B_spec[:,1].+1,B_spec2[:,2]./(((B_spec[:,1].+1).*(B_spec[:,1].+1)).*N^6),label=L"$\nabla\times A$",linestyle=:dot,marker=:circle,markersize=0.5)
    p=plot!(yscale=:log10,minorgrid=true,dpi=600)
    # savefig(p,string("data/plots/","spectra_",i))
    png(string("data/plots/","spectra_",i))
    # display(p)

end

using Statistics
# println(size(mean(stacked_1[:,:,2];dims=1)))
# println(size(mean(stacked_2[:,:,2];dims=1)))
# println(any(isnan,std(stacked_1[:,:,2]./N^6;dims=1)[1,:]))
# plot(stacked_1[1,:,1],(mean(stacked_1[:,:,2];dims=1)[1,:])./N^6,label=L"$B_k$",ribbon=(std(stacked_1[:,:,2]./N^6;dims=1)[1,:]),linestyle=:dot,marker=:circle,markersize=0.5)
# plot!(stacked_1[1,:,1],(mean(stacked_2[:,:,2];dims=1)[1,:])./N^6,label=L"$\nabla\times A$",ribbon=(std(stacked_2[:,:,2]./N^6;dims=1)[1,:]),linestyle=:dot,marker=:circle,markersize=0.5)

k = stacked_1[1,:,1]
B_spec_avg = (mean(stacked_1[:,:,2];dims=1)[1,:])./N^6
B_spec_avg_2 = (mean(stacked_2[:,:,2];dims=1)[1,:])./N^6
plot(k,B_spec_avg,label=L"$B_k$",linestyle=:dot,marker=:circle,markersize=0.5)
plot!(k,B_spec_avg_2,label=L"$\nabla\times A$",linestyle=:dot,marker=:circle,markersize=0.5)

p=plot!(yscale=:log10,minorgrid=true,dpi=600)
# p=plot!(minorgrid=true,dpi=600)
# savefig(p,string("data/plots/","avg_spectra"))
png(string("data/plots/","avg_spectra"))

plot(k.+1,B_spec_avg./((k.+1).*(k.+1)),label=L"$B_k$",linestyle=:dot,marker=:circle,markersize=0.5)
plot!(k.+1,B_spec_avg_2./((k.+1).*(k.+1)),label=L"$\nabla\times A$",linestyle=:dot,marker=:circle,markersize=0.5)

p=plot!(yscale=:log10,minorgrid=true,dpi=600)
# p=plot!(minorgrid=true,dpi=600)
# savefig(p,string("data/plots/","avg_spectra_2"))
png(string("data/plots/","avg_spectra_2"))

plot(k,B_spec_avg,label=L"$B_k$")
plot!(k,B_spec_avg_2,label=L"$\nabla\times A$")

p=plot!(yscale=:log10,minorgrid=true,dpi=600)
# p=plot!(minorgrid=true,dpi=600)
# savefig(p,string("data/plots/","avg_spectra"))
png(string("data/plots/","avg_spectra_uncluttered"))

plot(k.+1,B_spec_avg./((k.+1).*(k.+1)))
plot!(k.+1,B_spec_avg_2./((k.+1).*(k.+1)))

p=plot!(yscale=:log10,minorgrid=true,dpi=600)
# p=plot!(minorgrid=true,dpi=600)
# savefig(p,string("data/plots/","avg_spectra_2"))
png(string("data/plots/","avg_spectra_2_uncluttered"))

k = stacked_1_raw[1,:,1]
B_spec_avg_raw = (mean(stacked_1_raw[:,:,2];dims=1)[1,:])./N^6
B_spec_avg_2_raw = (mean(stacked_2_raw[:,:,2];dims=1)[1,:])./N^6
plot(k,B_spec_avg_raw,label=L"$B_k$",linestyle=:dot,marker=:circle,markersize=0.5)
plot!(k,B_spec_avg_2_raw,label=L"$\nabla\times A$",linestyle=:dot,marker=:circle,markersize=0.5)

p=plot!(yscale=:log10,minorgrid=true,dpi=600)
# p=plot!(minorgrid=true,dpi=600)
# savefig(p,string("data/plots/","avg_spectra"))
png(string("data/plots/","avg_spectra_raw"))

plot(k.+1,B_spec_avg_raw./((k.+1).*(k.+1)),label=L"$B_k$",linestyle=:dot,marker=:circle,markersize=0.5)
plot!(k.+1,B_spec_avg_2_raw./((k.+1).*(k.+1)),label=L"$\nabla\times A$",linestyle=:dot,marker=:circle,markersize=0.5)

p=plot!(yscale=:log10,minorgrid=true,dpi=600)
# p=plot!(minorgrid=true,dpi=600)
# savefig(p,string("data/plots/","avg_spectra_2"))
png(string("data/plots/","avg_spectra_2_raw"))

plot(k,B_spec_avg_raw,label=L"$B_k$")
plot!(k,B_spec_avg_2_raw,label=L"$\nabla\times A$")

p=plot!(yscale=:log10,minorgrid=true,dpi=600)
# p=plot!(minorgrid=true,dpi=600)
# savefig(p,string("data/plots/","avg_spectra"))
png(string("data/plots/","avg_spectra_uncluttered_raw"))

plot(k.+1,B_spec_avg_raw./((k.+1).*(k.+1)))
plot!(k.+1,B_spec_avg_2_raw./((k.+1).*(k.+1)))

p=plot!(yscale=:log10,minorgrid=true,dpi=600)
# p=plot!(minorgrid=true,dpi=600)
# savefig(p,string("data/plots/","avg_spectra_2"))
png(string("data/plots/","avg_spectra_2_uncluttered_raw"))