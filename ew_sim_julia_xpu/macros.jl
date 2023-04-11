module compute_macros

import ParallelStencil: INDICES
ix, iy, iz = INDICES[1], INDICES[2], INDICES[3]
ix, iy, iz = :($ix+1), :($iy+1), :($iz+1)
#Wasted arguments. pbbly should clean it up
#Does not include derivative terms

export @D_1ϕ_1
macro D_1ϕ_1(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( (0.5*0.65*(($W_1_1[$ix,$iy,$iz]).*($ϕ_4[$ix,$iy,$iz]).-
    ($W_2_1[$ix,$iy,$iz]).*($ϕ_3[$ix,$iy,$iz]).+
    ($W_3_1[$ix,$iy,$iz]).*($ϕ_2[$ix,$iy,$iz])).+
    0.5*0.34521*(($Y_1[$ix,$iy,$iz]).*($ϕ_2[$ix,$iy,$iz]))) ))
end

export @D_1ϕ_2
macro D_1ϕ_2(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( 0.5*0.65*(($W_1_1[$ix,$iy,$iz])*($ϕ_3[$ix,$iy,$iz])+
    ($W_2_1[$ix,$iy,$iz])*($ϕ_4[$ix,$iy,$iz])+
    ($W_3_1[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz]))-
    0.5*0.34521*(($Y_1[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz])) ))
end

export @D_1ϕ_3
macro D_1ϕ_3(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( 0.5*0.65*(($W_1_1[$ix,$iy,$iz])*($ϕ_2[$ix,$iy,$iz])+
    ($W_2_1[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz])-
    ($W_3_1[$ix,$iy,$iz])*($ϕ_4[$ix,$iy,$iz]))+
    0.5*0.34521*(($Y_1[$ix,$iy,$iz])*($ϕ_4[$ix,$iy,$iz])) ))
end

export @D_1ϕ_4
macro D_1ϕ_4(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( 0.5*0.65*(($W_1_1[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz])-
    ($W_2_1[$ix,$iy,$iz])*($ϕ_2[$ix,$iy,$iz])-
    ($W_3_1[$ix,$iy,$iz])*($ϕ_3[$ix,$iy,$iz]))-
    0.5*0.34521*(($Y_1[$ix,$iy,$iz])*($ϕ_3[$ix,$iy,$iz])) ))
end

export @D_2ϕ_1
macro D_2ϕ_1(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( 0.5*0.65*(($W_1_2[$ix,$iy,$iz])*($ϕ_4[$ix,$iy,$iz])-
    ($W_2_2[$ix,$iy,$iz])*($ϕ_3[$ix,$iy,$iz])+
    ($W_3_2[$ix,$iy,$iz])*($ϕ_2[$ix,$iy,$iz]))+
    0.5*0.34521*(($Y_2[$ix,$iy,$iz])*($ϕ_2[$ix,$iy,$iz])) ))
end

export @D_2ϕ_2
macro D_2ϕ_2(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( 0.5*0.65*(($W_1_2[$ix,$iy,$iz])*($ϕ_3[$ix,$iy,$iz])+
    ($W_2_2[$ix,$iy,$iz])*($ϕ_4[$ix,$iy,$iz])+
    ($W_3_2[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz]))-
    0.5*0.34521*(($Y_2[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz])) ))
end

export @D_2ϕ_3
macro D_2ϕ_3(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( 0.5*0.65*(($W_1_2[$ix,$iy,$iz])*($ϕ_2[$ix,$iy,$iz])+
    ($W_2_2[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz])-
    ($W_3_2[$ix,$iy,$iz])*($ϕ_4[$ix,$iy,$iz]))+
    0.5*0.34521*(($Y_2[$ix,$iy,$iz])*($ϕ_4[$ix,$iy,$iz])) ))
end

export @D_2ϕ_4
macro D_2ϕ_4(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( 0.5*0.65*(($W_1_2[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz])-
    ($W_2_2[$ix,$iy,$iz])*($ϕ_2[$ix,$iy,$iz])-
    ($W_3_2[$ix,$iy,$iz])*($ϕ_3[$ix,$iy,$iz]))-
    0.5*0.34521*(($Y_2[$ix,$iy,$iz])*($ϕ_3[$ix,$iy,$iz])) ))
end

export @D_3ϕ_1
macro D_3ϕ_1(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( 0.5*0.65*(($W_1_3[$ix,$iy,$iz])*($ϕ_4[$ix,$iy,$iz])-
    ($W_2_3[$ix,$iy,$iz])*($ϕ_3[$ix,$iy,$iz])+
    ($W_3_3[$ix,$iy,$iz])*($ϕ_2[$ix,$iy,$iz]))+
    0.5*0.34521*(($Y_3[$ix,$iy,$iz])*($ϕ_2[$ix,$iy,$iz])) ))
end

export @D_3ϕ_2
macro D_3ϕ_2(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( 0.5*0.65*(($W_1_3[$ix,$iy,$iz])*($ϕ_3[$ix,$iy,$iz])+
    ($W_2_3[$ix,$iy,$iz])*($ϕ_4[$ix,$iy,$iz])+
    ($W_3_3[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz]))-
    0.5*0.34521*(($Y_3[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz])) ))
end

export @D_3ϕ_3
macro D_3ϕ_3(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( 0.5*0.65*(($W_1_3[$ix,$iy,$iz])*($ϕ_2[$ix,$iy,$iz])+
    ($W_2_3[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz])-
    ($W_3_3[$ix,$iy,$iz])*($ϕ_4[$ix,$iy,$iz]))+
    0.5*0.34521*(($Y_3[$ix,$iy,$iz])*($ϕ_4[$ix,$iy,$iz])) ))
end

export @D_3ϕ_4
macro D_3ϕ_4(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( 0.5*0.65*(($W_1_3[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz])-
    ($W_2_3[$ix,$iy,$iz])*($ϕ_2[$ix,$iy,$iz])-
    ($W_3_3[$ix,$iy,$iz])*($ϕ_3[$ix,$iy,$iz]))-
    0.5*0.34521*(($Y_3[$ix,$iy,$iz])*($ϕ_3[$ix,$iy,$iz])) ))
end

export @D_4ϕ_1
macro D_4ϕ_1(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( 0.5*0.65*(($W_1_4[$ix,$iy,$iz])*($ϕ_4[$ix,$iy,$iz])-
    ($W_2_4[$ix,$iy,$iz])*($ϕ_3[$ix,$iy,$iz])+
    ($W_3_4[$ix,$iy,$iz])*($ϕ_2[$ix,$iy,$iz]))+
    0.5*0.34521*(($Y_4[$ix,$iy,$iz])*($ϕ_2[$ix,$iy,$iz])) ))
end

export @D_4ϕ_2
macro D_4ϕ_2(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( 0.5*0.65*(($W_1_4[$ix,$iy,$iz])*($ϕ_3[$ix,$iy,$iz])+
    ($W_2_4[$ix,$iy,$iz])*($ϕ_4[$ix,$iy,$iz])+
    ($W_3_4[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz]))-
    0.5*0.34521*(($Y_4[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz])) ))
end

export @D_4ϕ_3
macro D_4ϕ_3(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( 0.5*0.65*(($W_1_4[$ix,$iy,$iz])*($ϕ_2[$ix,$iy,$iz])+
    ($W_2_4[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz])-
    ($W_3_4[$ix,$iy,$iz])*($ϕ_4[$ix,$iy,$iz]))+
    0.5*0.34521*(($Y_4[$ix,$iy,$iz])*($ϕ_4[$ix,$iy,$iz])) ))
end

export @D_4ϕ_4
macro D_4ϕ_4(ϕ_1::Symbol,ϕ_2::Symbol,ϕ_3::Symbol,ϕ_4::Symbol,
    W_1_1::Symbol,W_1_2::Symbol,W_1_3::Symbol,W_1_4::Symbol,
    W_2_1::Symbol,W_2_2::Symbol,W_2_3::Symbol,W_2_4::Symbol,
    W_3_1::Symbol,W_3_2::Symbol,W_3_3::Symbol,W_3_4::Symbol,
    Y_1::Symbol,Y_2::Symbol,Y_3::Symbol,Y_4::Symbol)
    esc(:( 0.5*0.65*(($W_1_4[$ix,$iy,$iz])*($ϕ_1[$ix,$iy,$iz])-
    ($W_2_4[$ix,$iy,$iz])*($ϕ_2[$ix,$iy,$iz])-
    ($W_3_4[$ix,$iy,$iz])*($ϕ_3[$ix,$iy,$iz]))-
    0.5*0.34521*(($Y_4[$ix,$iy,$iz])*($ϕ_3[$ix,$iy,$iz])) ))
end


end