module module_cross
use sacio
public :: sub_cross

contains

subroutine sub_cross(x_in, y_in, result, head, flag)

    implicit none
    real, allocatable, dimension(:), intent(in) :: x_in, y_in
    real, allocatable, dimension(:), intent(out) :: result
    type(sachead), intent(inout) :: head
    real,allocatable,dimension(:) :: x, y
    integer, intent(inout) :: flag
    integer :: i, npts, nx, ny, start_x, start_y, long, end_x, end_y

    nx = size(x_in)
    ny = size(y_in)
    npts = nx + ny - 1
    allocate(result(1:npts))
    result = 0
    !$OMP PARALLEL DO
    do i=1, npts
        if (i <= ny) then
            start_x = 1
            start_y = ny - i
            long = i
        else if (i > ny) then
            start_x = i - ny + 1
            start_y = 1
            long = ny - (i - nx)
        end if
        end_x = start_x + long - 1
        end_y = start_y + long - 1
        allocate (x(1 : end_x))
        allocate (y(1 : end_y))
        x = x_in(start_x : end_x)
        y = y_in(start_y : end_y)
        result(i) = cor (x, y)
        deallocate(x)
        deallocate(y)
    end do
    !$OMP END PARALLEL DO
    head%b = 0 - (head%npts - 1) * head%delta 
    head%npts = npts
    flag = 0
end subroutine sub_cross

real function cor (x, y)
    implicit none
    real, intent(in), allocatable, dimension(:) :: x, y
    integer :: i, n
    cor = 0
    n = size(x)
    do i=1, n
        cor = cor + x(i) * y(i)
    end do
end function cor

end module module_cross
