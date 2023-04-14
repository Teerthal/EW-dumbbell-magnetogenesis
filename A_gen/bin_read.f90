!Sample fortran script that demonstrates reading the
!vector potential data
PROGRAM read_A
  IMPLICIT NONE

  ! INTEGER(KIND=8),ALLOCATABLE :: matrix(:,:,:,:)
  REAL(KIND=8),ALLOCATABLE :: matrix(:,:)
  INTEGER :: Nx, Ny, Nz
  character(len=100) :: filepath
  INTEGER :: i
  filepath = "path/to/data"
            !Insert absolute path to data here!
  Nx = 134
  Ny = 134
  Nz = 134
  
  
  ! ALLOCATE(matrix(Nx, Ny, Nz,6))
  ALLOCATE(matrix(Nx*Ny*Nz,6))
  
  
  ! OPEN(33, FILE=filepath,&
      ! FORM="FORMATTED", STATUS="UNKNOWN", ACTION="READ", ACCESS='STREAM')
  OPEN(33, FILE=filepath,STATUS="OLD", ACTION="READ")
  ! READ(33,*) matrix
  
  ! print*, matrix
  ! write(*,*) matrix(:,1,1,1)
  do I=1,Nx*Ny*Nz,1
    read(33,*) matrix(I,:)
    ! write(*,*) matrix(I,:)
  enddo
  print*, matrix(1,:)
  print*, matrix(1,1)
  print*, matrix(1,6)
  CLOSE(33)
  DEALLOCATE(matrix)
  
END PROGRAM read_saved_python
