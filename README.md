# EW dumbbell magnetogenesis
Temporary project files

!Most results from these code are not fully tested and poorly documented with occasional use of horrible syntax

Document.pdf (documentation is work in progress) -> document describes the algorithms being developed to simulate collapsing monopole-antimonopole pairs

Folder random_gen:

Scripts to populate a cubic lattice with a Higgs field distribution by randomly picking t'Hoft angles. Modules include routines to compute magnetic field directly and the gauge potential directly and the curl, magnetic field spectrum according to the prescription in Yiyang et al. Experimental plotting scripts to plot enseble averaged and binned spectra are included along with sample plots from 120 runs run of (128+6)^3 lattices. +6 is required for the ghost zones in the pencil-code.

Folder topological_collapsing_scheme:

Julia and Python hybrid scripts that emulate collapsing monopole-antimonopole pairs along strings
Central code features for one algorithm are working, but some of the algorithms are a work in progress conceptually and/or not implemented in the code.

