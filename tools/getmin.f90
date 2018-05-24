program getmin
use sacio
implicit none
character(len=1024) :: arg
character(len=:) ,allocatable :: file
integer :: i, j, flag
real,allocatable,dimension(:) :: x
type(sachead) :: head
real :: min

call get_command_argument(1, arg)
file = arg
call sacio_readsac(file, head, x, flag)
min = 0
j = 0
do i=1, size(x)
    if (min > x(i)) then
        min = x(i)
        j = i
    end if
end do
write(*,*) j, min

end program getmin
