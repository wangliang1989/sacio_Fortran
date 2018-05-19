module module_crossnorm
use sacio
public :: sub_crossnorm
public :: isum

contains

subroutine sub_crossnorm(x, y, z, result, flag)

    implicit none
    real, allocatable, dimension(:), intent(in) :: x, y, z
    real, allocatable, dimension(:), intent(out) :: result
    integer, intent(inout) :: flag
    integer :: i, npts, nx, ny
    real,allocatable,dimension(:) :: x2, y2
    real::m2

    nx = size(x)
    ny = size(y)
    npts = nx + ny - 1
    if (npts /= size(z)) then
        flag = 1
    end if
    allocate(x2(1:npts))
    allocate(y2(1:npts))
    allocate(result(1:npts))
    result = 0
    !$OMP PARALLEL DO
    do i=1, npts
        if ((i >= 1) .and. (i <= ny)) then
            x2(i) = isum(x,1,i)
            y2(i) = isum(y,ny-i+1,ny)
        else if ((i > ny) .and. (i <= nx)) then
            x2(i) = isum(x,i-ny+1,i)
            y2(i) = isum(y,1,ny)
        else if ((i > nx) .and. (i <= nx + ny - 1)) then
            x2(i) = isum(x,i-ny+1,nx)
            y2(i) = isum(y,1,nx+ny-i)
        end if
        m2 = sqrt (x2(i) * y2(i))
        if (m2 > 0) then
            result(i) = z(i) / m2
        end if
        write (*,*) z(i), m2, result(i), x2(i), y2(i), i, nx, ny
    end do
    !$OMP END PARALLEL DO
end subroutine sub_crossnorm

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
