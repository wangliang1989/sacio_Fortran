program crossnorm
use sacio
use module_crossnorm
implicit none
character(len=2) :: q
character(len=1024) :: arg
character(len=:) ,allocatable :: file, out
integer :: i, flag
real,allocatable,dimension(:) :: x, y, z, result
type(sachead) :: head

do i=1,4
    call get_command_argument(i, arg)
    q = arg(1:2)
    file = arg(3:len(arg))
    select case (arg(1:2))
    case ('-X')
        call sacio_readsac(file, head, x, flag)
    case ('-Y')
        call sacio_readsac(file, head, y, flag)
    case ('-Z')
        call sacio_readsac(file, head, z, flag)
    case ('-O')
        out = file
    case default
        flag = 1
    end select
end do

if (flag == 0) then
    call sub_crossnorm(x, y, z, result, flag)
end if

if (flag == 0) then
    call sacio_writesac(out, head, result, flag)
end if

end program crossnorm
