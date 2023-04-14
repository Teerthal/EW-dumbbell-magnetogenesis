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

using Statistics
#Read full spectrum stack
stacked_fft=npzread(string("data/","B_fft_stacked_.npz"))
#Compute mean of the 3D fourier transform across all realizations
B_fft_ensemble_average = mean(stacked_fft;dims=1)[1,:,:,:]
#Convert to 1D spectrum by averaging over all b(\vec{k}) for all |\vec{k}|=k'
#where k'\in{0,(\sqrt{3}/2)N}
B_k_ensem_avg = convolve_1d(B_fft_ensemble_average,N)

#Starting from 2 means we drop k=0 to avoid issues with log plots
#Alternative could be to translate but k^2 appears in E_M
start = 2

k=B_k_ensem_avg[start:end,1]
EM_avg = B_k_ensem_avg[start:end,2]

#Finding index in k list where cut needs to be performed
cut = findall(k.==K_c_mag(10,0,0,N))

#defining variables to perform fit
fit_x = k[start:cut[1]]
fit_y = ((((k).^2)./((2*pi)^3*N^2)).*EM_avg)[start:cut[1]]

#Number of bins to get evenly spaced power spectrum
#since k is not evenly spaced
#Could do it on the uneven data but then fit would be weighted more
#towards larger k where k is denser

#Warning: The bin cannot be too large since for a given cut 
#there might be no data in certain k bins 

bin_num=20

binned_spec = zeros((bin_num,2))
binned_k = range(fit_x[1],fit_x[end],length=bin_num+1)
for b in range(1,bin_num,step=1)
    idxs = findall((fit_x .>= binned_k[b]) .& (fit_x .< binned_k[b+1]))
    k_b = mean(fit_x[idxs])
    EM_k = mean(fit_y[idxs])
    binned_spec[b,1]=k_b
    binned_spec[b,2]=EM_k
end

using CurveFit

#Plot ensemble average spectra
plot((k),((((k).^2)./((2*pi)^3*N^2)).*EM_avg),label="",linecolor=:blue,linealpha=0)

#Finding power law fit to binned data
fitcoeffs=curve_fit(PowerFit, binned_spec[:,1], binned_spec[:,2])

k_x = zeros((N-1))

#Plot few non convolved spectra from the 3D fft
#along certain directions
for k in range(start,N,step=N÷10)
    for j in range(start,N,step=N÷10)
        for i in range(start,N,step=1)
            k_x[i-1]=K_c_mag(i,j,k,N)
        end
    	plot!((k_x),((((k_x).^2)./((2*pi)^3*N^2)).*B_fft_ensemble_average[start:end,j,k]),lw=0.1,linecolor=:black,label="",alpha=0.75)
    end
end

#RePlotting enseble average spectra due to oversaturation issues 
plot!((k),((((k).^2)./((2*pi)^3*N^2)).*EM_avg),label=L"$E_M$",linecolor=:blue)

#Plot binned data
scatter!(binned_spec[:,1],binned_spec[:,2],marker=:circle,markersize=2,label="Bins",msw=1,markerstrokecolor=:green,markercolor=:white,markeralpha=0.75)

#Plotting k^3 and k^4
plot!(k,(fitcoeffs(1).*k.^3),linestyle=:dash,lw=0.7,label=L"k^3",linecolor=:purple)
plot!(k,(fitcoeffs(1).*k.^4),linestyle=:dash,lw=0.7,label=L"k^4",linecolor=:teal)

#Plotting fit to binned data
plot!(binned_spec[:,1],fitcoeffs.(binned_spec[:,1]),linestyle=:dot,linecolor=:red,legend=:topleft,label="Bin Fit")

#Setting limits, scale
plot!(xscale=:log10,yscale=:log10,minorgrid=true,dpi=600,xlims=(1,60))
#Saving figure
png(string("data/plots/","enemb_spectra"))

