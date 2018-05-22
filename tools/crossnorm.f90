program crossnorm
use sacio
use module_crossnorm
implicit none
character(len=2) :: q
character(len=1024) :: arg
character(len=:) ,allocatable :: file, out
integer :: i, flag, delay
real,allocatable,dimension(:) :: x, y, z, result
type(sachead) :: headx, heady, headz

do i=1,4
    call get_command_argument(i, arg)
    q = arg(1:2)
    file = arg(3:len(arg))
    select case (arg(1:2))
    case ('-X')
        call sacio_readsac(file, headx, x, flag)
    case ('-Y')
        call sacio_readsac(file, heady, y, flag)
    case ('-Z')
        call sacio_readsac(file, headz, z, flag)
    case ('-D')
        read(delay,"(i2)") file
    case ('-O')
        out = file
    case default
        flag = 1
    end select
end do

if (headx%delta /= heady%delta) then
    flag = 1
    write(*,*) "sacio_Fortran: delta is not equal in -X file and -Y file"
end if
if (heady%delta /= headz%delta) then
    flag = 1
    write(*,*) "sacio_Fortran: delta is not equal in -Y file and -Z file"
end if
if (headx%npts < heady%npts) then
    flag = 1
    write(*,*) "sacio_Fortran: npts in -X file is smaller than -Y file"
end if

write(*,*) headz%npts
if (flag == 0) then
    call sub_crossnorm_cut(z, headz, heady%npts, delay, flag)
end if
write(*,*) headz%npts
if (flag == 0) then
    call sub_crossnorm(x, y, z, result, flag)
end if

if (flag == 0) then
    call sacio_writesac(out, headz, result, flag)
end if

end program crossnorm
