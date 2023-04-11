include("gen_routines.jl")
using .base_routines

include("parameters.jl")
using .paras
using FFTW
using Plots
using LaTeXStrings
using NPZ

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
    stacked_2_raw[i,:,:]=B_spec_raw_2
    
    # plot(B_spec[:,1].+1,B_spec[:,2]./(((B_spec[:,1].+1).*(B_spec[:,1].+1)).*N^6),label=L"$B_k$",linestyle=:dot,marker=:circle,markersize=0.5)
    # plot!(B_spec[:,1].+1,B_spec2[:,2]./(((B_spec[:,1].+1).*(B_spec[:,1].+1)).*N^6),label=L"$\nabla\times A$",linestyle=:dot,marker=:circle,markersize=0.5)
    # p=plot!(yscale=:log10,minorgrid=true,dpi=600)
    # # savefig(p,string("data/plots/","spectra_",i))
    # png(string("data/plots/","spectra_",i))
    # # display(p)

end

using Statistics
# println(size(mean(stacked_1[:,:,2];dims=1)))
# println(size(mean(stacked_2[:,:,2];dims=1)))
# println(any(isnan,std(stacked_1[:,:,2]./N^6;dims=1)[1,:]))
# plot(stacked_1[1,:,1],(mean(stacked_1[:,:,2];dims=1)[1,:])./N^6,label=L"$B_k$",ribbon=(std(stacked_1[:,:,2]./N^6;dims=1)[1,:]),linestyle=:dot,marker=:circle,markersize=0.5)
# plot!(stacked_1[1,:,1],(mean(stacked_2[:,:,2];dims=1)[1,:])./N^6,label=L"$\nabla\times A$",ribbon=(std(stacked_2[:,:,2]./N^6;dims=1)[1,:]),linestyle=:dot,marker=:circle,markersize=0.5)

k = stacked_1[1,:,1]
B_spec_avg = (mean(stacked_1[:,:,2];dims=1)[1,:])#./N^6
B_spec_avg_2 = (mean(stacked_2[:,:,2];dims=1)[1,:])#./N^6
B_spec_std = (std(stacked_1[:,:,2];dims=1)[1,:])#./N^6
B_spec_std_2 = (std(stacked_2[:,:,2];dims=1)[1,:])#./N^6

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

plot(k.+1,B_spec_avg,label=L"$B_k$",ribbon=B_spec_std,linestyle=:dot,marker=:circle,markersize=0.5)
plot!(k.+1,B_spec_avg_2,label=L"$\nabla\times A$",ribbon=B_spec_std_2,linestyle=:dot,marker=:circle,markersize=0.5)
# p=plot!(yscale=:log10,xscale=:log10,minorgrid=true,dpi=600,ylabel=L"$E_M/k^3$")
p=plot!(minorgrid=true,dpi=600,ylabel=L"$E_M/k^3$")
# p=plot!(minorgrid=true,dpi=600)
# savefig(p,string("data/plots/","avg_spectra_2"))
png(string("data/plots/","avg_spectra_3"))


k = stacked_1_raw[1,:,1]
B_spec_avg_raw = (mean(stacked_1_raw[:,:,2];dims=1)[1,:])./N^6
B_spec_avg_2_raw = (mean(stacked_2_raw[:,:,2];dims=1)[1,:])./N^6
B_spec_std_raw = (std(stacked_1_raw[:,:,2];dims=1)[1,:])./N^6
B_spec_std_2_raw = (std(stacked_2_raw[:,:,2];dims=1)[1,:])./N^6
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

# l=@layout [a{0.75h},b{0.25h}]
println(B_spec_avg_raw[10])
println(B_spec_std_raw[10])
# plot(k.+1,(B_spec_avg_2_raw),label=L"$mean$")#,linestyle=:dot,marker=:circle,markersize=0.5)
p1=plot(k.+1,B_spec_avg_2_raw,label=L"$B_k$",yerror=B_spec_std_raw)
# p1=plot(k.+1,B_spec_avg_2_raw,label=L"$B_k$",yerror=B_spec_std_raw,markerstrokewidth=0.1,lw=0.5,ms=0)#,linestyle=:dot,marker=:circle,markersize=0.5)
# p1=plot!(k.+1,(B_spec_std_2_raw),label=L"$std$")#,linestyle=:dot,marker=:circle,markersize=0.5)
# plot!(k.+1,B_spec_avg_2_raw,label=L"$\nabla\times A$",linestyle=:dot,marker=:circle,markersize=0.5)
# plot!(k.+1,B_spec_avg_2_raw,label=L"$\nabla\times A$",ribbon=B_spec_std_2_raw,linestyle=:dot,marker=:circle,markersize=0.5)

p1=plot!(yscale=:symlog,xscale=:symlog,minorgrid=true,ylabel=L"$\overline{E_M}$",dpi=600)

# p=plot!(minorgrid=true,dpi=600,ylabel=L"$E_M/k^3$")
# p=plot!(minorgrid=true,dpi=600)
# savefig(p,string("data/plots/","avg_spectra_2"))
png(string("data/plots/","avg_spectra_3_raw"))

plot(k.+1,(B_spec_std_2_raw./B_spec_avg_2_raw))
p2=plot!(yscale=:log10,xscale=:log10,minorgrid=true,ylabel=L"$\sigma({E_M})/\overline{E_M}$")

p=plot(p1,p2, layout = grid(2, 1, heights=[0.75 ,0.25]),dpi=600)
png(string("data/plots/","avg_spectra_3_raw_error"))
