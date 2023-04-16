# EW dumbbell magnetogenesis
Temporary project files

!Most results from these code are not fully tested and poorly documented with occasional use of horrible syntax
!Detailed code documentation under construction

Document.pdf (documentation is work in progress) -> document describes the algorithms being developed to simulate collapsing monopole-antimonopole pairs

Folder A_gen:

Scripts to populate a cubic lattice with a Higgs field distribution by randomly picking t'Hoft angles. Modules include routines to compute magnetic field directly and the gauge potential directly and the curl, magnetic field spectrum according to the prescription in Yiyang et al. Experimental plotting scripts to plot enseble averaged and binned spectra are included along with sample plots from 120 runs run of (128+6)^3 lattices. +6 is required for the ghost zones in the pencil-code.
A sample pencil code build is also included that illustrates how to read the data.
A simple standalone fortran code to demonstrate how to read the data.
Uses central differences for derivatives.

Plot of the magnetic field power spectrum(E_M) from the test ensemble of 120 realizations of (128+6)^3 boxes.
![enemb_spectra](https://user-images.githubusercontent.com/95438989/232335931-eba68d3b-1929-4332-b7a9-2a02d5028cbe.png)


Folder topological_collapsing_scheme:

Julia and Python hybrid scripts that emulate collapsing monopole-antimonopole pairs along strings
Central code features for one algorithm are working, but some of the algorithms are a work in progress conceptually and/or not implemented in the code.

Folder ew_sim_julia_xpu
Julia scripts for scalable muliple GPU/CPU (xPU) code for running Higgs bubble simulation for studying generation of magnetic fields at electoweak phase transition.
Current code only computes the evolution of magnetic field. Implementation of computing integrated volume energies and spectra are ongoing.
It is completely funcitonal at this stage on single GPU or multiple CPUs
Tested to run several thousand time steps on a 256^3 lattice on the order of minutes on a single GPU.
Includes the vtkgenscript.py which is a parallelized python script that converts time slices of 3D field arrays into .vtk files that can be used in paraview for viz.
Includes animation of contour slices(clockwise from top right: |\Phi|,\Phi_1,\Phi_2,\Phi_3) on a 256^3 box for 2000 time steps with dx=0.2 and dt = dx/32 in Higgs vev units.

Uses central differences for derivatives
