module module_crossnorm
use sacio
public :: sub_crossnorm
public :: sub_crossnorm_cut
public :: isum

contains

subroutine sub_crossnorm(x, y, z, result, flag)
    implicit none
    real, allocatable, dimension(:), intent(in) :: x, y, z
    real, allocatable, dimension(:), intent(out) :: result
    integer, intent(inout) :: flag
    integer :: i, npts, nx, ny,j
    real:: m2, y2,cor

    nx = size(x)
    ny = size(y)
    npts = nx - ny + 1
    if (npts /= size(z)) then
        flag = 1
        write(*,*)"sacio_fortran: npts wrong", npts, size(z)
    end if
    y2 = isum (y, 1, ny)
    allocate(result(1:npts))
    result = 0
    ! -fopenmp
    !$OMP PARALLEL DO
    do i=1, npts
        m2 = sqrt (isum(x, i, i + ny - 1) * y2)
        if (m2 > 0) then
            result(i) = z(i) / m2
        end if
        cor = 0
        do j=1,ny
            cor = x(i+j-1)*y(j) + cor
        end do
        !write(*,*) i, z(i), m2, result(i), cor, x(i)*y(1),cor/m2
    end do
    !$OMP END PARALLEL DO
end subroutine sub_crossnorm

subroutine sub_crossnorm_cut(z, headz, npts_y, flag)
    implicit none
    real, allocatable, dimension(:), intent(inout) :: z
    type(sachead), intent(inout) :: headz
    integer, intent(in) :: npts_y
    integer, intent(inout) :: flag
    real, allocatable, dimension(:) :: result

    flag = 0
    allocate(result(1:(headz%npts - 2 * npts_y + 2)))
    result = z(npts_y - 1 : headz%npts - npts_y)
    deallocate(z)
    z = result
    deallocate(result)

    headz%b = headz%b + headz%delta * npts_y
    headz%e = headz%e - headz%delta * npts_y
    headz%npts = headz%npts - 2 * npts_y
end subroutine sub_crossnorm_cut

real function isum (x, a, b)
    implicit none
    integer, intent(in) :: a
    integer, intent(in) :: b
    real, intent(in), allocatable, dimension(:) :: x
    integer :: i
    isum = 0
    do i=a, b
        isum = isum + x(i) * x(i)
    end do
end function isum

end module module_crossnorm
