!  Routine to import Initial condition data for the vector
!  potential from the ew code.
!
!  04-apr-23/teerthal
!
!** AUTOMATIC CPARAM.INC GENERATION ****************************
! Declare (for generation of cparam.inc) the number of f array
! variables and auxiliary variables added by this module
!
! CPARAM logical, parameter :: linitial_condition = .true.
!
!***************************************************************
module InitialCondition
!
  use Cparam
  use Cdata
  use General, only: keep_compiler_quiet
  use Messages
!
  implicit none
!
  include '../initial_condition.h'
!
  character (len=100) :: EWFile	!Specify filepath to the data file
				!in start.in
!
  namelist /initial_condition_pars/ &
      EWFile
!
  contains
!***********************************************************************
    subroutine register_initial_condition()
!
!  Configure pre-initialised (i.e. before parameter read) variables
!  which should be know to be able to evaluate
!
!  07-oct-09/wlad: coded
!
!  Identify CVS/SVN version information.
!
      if (lroot) call svn_id( &
           "$Id: iucaa_logo.f90 19193 2012-06-30 12:55:46Z wdobler $")
!
    endsubroutine register_initial_condition
!***********************************************************************
    subroutine initial_condition_uu(f)
!
!  Initialize the velocity field.
!
!  07-may-09/wlad: coded
!
      real, dimension (mx,my,mz,mfarray), intent(inout) :: f
!
      call keep_compiler_quiet(f)
!
    endsubroutine initial_condition_uu
!***********************************************************************
    subroutine initial_condition_lnrho(f)
!
!  Initialize logarithmic density. init_lnrho 
!  will take care of converting it to linear 
!  density if you use ldensity_nolog
!
!  07-may-09/wlad: coded
!
      real, dimension (mx,my,mz,mfarray), intent(inout) :: f
!
      call keep_compiler_quiet(f)
!
    endsubroutine initial_condition_lnrho
!***********************************************************************
    subroutine initial_condition_aa(f)
!  Load the vector potential from a data file
      use Poisson
      use Sub
      
      real, dimension (mx,my,mz,mfarray) :: f
      real, allocatable :: bb64(:,:)    ! for double precision
      integer :: I
      ALLOCATE(bb64(mx*my*mz,6))
      OPEN(0, FILE=EWFile,STATUS="OLD", ACTION="READ")
      do I=1,mx*my*mz
        read(0,*) bb64(I,:)
        f(INT(bb64(I,1)),INT(bb64(I,2)),INT(bb64(I,3)),iax) = bb64(I,4)
        f(INT(bb64(I,1)),INT(bb64(I,2)),INT(bb64(I,3)),iay) = bb64(I,5)
        f(INT(bb64(I,1)),INT(bb64(I,2)),INT(bb64(I,3)),iaz) = bb64(I,6)
      enddo
!
    endsubroutine initial_condition_aa
!***********************************************************************    
    subroutine read_initial_condition_pars(iostat)
!
      use File_io, only: parallel_unit
!
      integer, intent(out) :: iostat
!
      read(parallel_unit, NML=initial_condition_pars, IOSTAT=iostat)
!
    endsubroutine read_initial_condition_pars
!***********************************************************************
    subroutine write_initial_condition_pars(unit)
!
      integer, intent(in) :: unit
!
      write(unit, NML=initial_condition_pars)
!
    endsubroutine write_initial_condition_pars
!***********************************************************************
!********************************************************************
!************        DO NOT DELETE THE FOLLOWING       **************
!********************************************************************
!**  This is an automatically generated include file that creates  **
!**  copies dummy routines from noinitial_condition.f90 for any    **
!**  InitialCondition routines not implemented in this file        **
!**                                                                **
    include '../initial_condition_dummies.inc'
!********************************************************************
  endmodule InitialCondition
