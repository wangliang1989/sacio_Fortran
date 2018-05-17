module module_crossnorm
use sacio
public :: sub_crossnorm
public :: isum

contains

subroutine sub_crossnorm(x_in, y_in, z, result, flag)

    implicit none
    real, allocatable, dimension(:), intent(in) :: x_in, y_in, z
    real, allocatable, dimension(:), intent(out) :: result
    integer, intent(inout) :: flag
    integer :: i, npts, nx, ny
    real,allocatable,dimension(:) :: x, y, x2, y2
    real::m2

    nx = size(x_in)
    ny = size(y_in)
    npts = nx + ny - 1
    if (npts /= size(z)) then
        flag = 1
        result = 0
    end if
    x = x_in * x_in
    y = y_in * y_in
    allocate(x2(1:npts))
    allocate(y2(1:npts))
    allocate(result(1:npts))
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
        m2 = 0
        if ((abs(x2(i)) > 0) .and. (abs(y2(i)) > 0)) then
            m2 = sqrt (x2(i) * y2(i))
            result(i) = z(i) / m2
        end if
        !if (result(i) >= 1) then
            write (*,*) z(i), m2, result(i), x2(i), y2(i), i, nx, ny
        !end if
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
        isum = isum + x(i)
    end do
end function isum

end module module_crossnorm
