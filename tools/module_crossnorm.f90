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
    real:: x2, y2

    flag = 0
    nx = size(x)
    ny = size(y)
    npts = nx - ny + 1
    y2 = isum (y, 1, ny)
    allocate(result(1 : npts))
    result = 0
    ! -fopenmp
    !$OMP PARALLEL DO
    do i=1, npts
        x2 = isum(x, i, i + ny - 1)
        if (x2 > 0) then
            result(i) = z(i) / sqrt (x2 * y2)
        end if
        !write(*,*) i, m2, result(i), cor, x(i)*y(1),cor/m2
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
