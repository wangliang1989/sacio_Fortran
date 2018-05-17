program cross
use sacio
use module_cross
implicit none
character(len=2) :: q
character(len=1024) :: arg
character(len=:) ,allocatable :: file, out
integer :: i, flag
real,allocatable,dimension(:) :: x, y, result
type(sachead) :: head

do i=1,3
    call get_command_argument(i, arg)
    q = arg(1:2)
    file = arg(3:len(arg))
    select case (q)
    case ('-X')
        call sacio_readsac(file, head, x, flag)
    case ('-Y')
        call sacio_readsac(file, head, y, flag)
    case ('-O')
        out = file
    case default
        flag = 10
    end select
end do

if (flag == 0) then
    call sub_cross(x, y, result, head, flag)
end if

if (flag == 0) then
    call sacio_writesac(out, head, result, flag)
end if

end program cross
