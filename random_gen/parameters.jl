module paras

export N, p_arr_0,dp_arr_0,B_arr_0,divB_arr_0
export flux_arr_0,dvcharges_arr_0
export A_arr_0,curl_A_0
# N = 32+6
N = 128+6
# N = 16
export N_rels
N_rels = 120

export gw,vev,sw
gw=0.65
lambda=1.0
vev=1.0
sw = sqrt(0.22)
export nbins
nbins=250

p_arr_0 = zeros(ComplexF64,(N,N,N,2))
dp_arr_0 = zeros(ComplexF64,(N,N,N,2,3))
B_arr_0 = zeros(Float64,(N,N,N,6))
A_arr_0 = zeros(ComplexF64,(N,N,N,3))
curl_A_0 = zeros(Float64,(N,N,N,3))
divB_arr_0 = zeros(Float64,(N,N,N))
flux_arr_0 = zeros(Float64,(N-1,N-1,N-1))
dvcharges_arr_0 = zeros(Float64,(N-1,N-1,N-1))
end