module module_crossnorm
use sacio
public :: sub_crossnorm
public :: isum

contains

subroutine sub_crossnorm(filex, filey, filez)

    implicit none
    character(len=80), intent(in) :: filex, filey, filez
    integer :: i, flagx, flagy, flagz, npts, nx, ny
    real,allocatable,dimension(:) :: datax, datay, dataz, x, y, x2, y2, z
    type(sachead) :: headx, heady, headz

    call sacio_readsac(filex, headx, datax, flagx)
    call sacio_readsac(filey, heady, datay, flagy)
    call sacio_readsac(filez, headz, dataz, flagz)
    nx = headx%npts
    ny = heady%npts
    npts = headx%npts + heady%npts - 1
    allocate(z(1:npts))
    allocate(x(1:npts))
    allocate(y(1:npts))
    x = datax * datax
    y = datay * datay
    z = dataz
    allocate(x2(1:npts))
    allocate(y2(1:npts))
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
        if ((abs(x2(i)) > 1e-10) .and. (abs(y2(i)) > 1e-10)) then
            z(i) = z(i) / sqrt (x2(i) * y2(i))
        end if
    end do
    !$OMP END PARALLEL DO
    call sacio_writesac(filez, headz, z, flagz)
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
