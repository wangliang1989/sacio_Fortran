program crossnorm
use sacio
use module_crossnorm
implicit none
character(len=1024) :: arg
character(len=:) ,allocatable :: file
integer :: i, flag
real,allocatable,dimension(:) :: x
type(sachead) :: head
real :: sum, mean


call get_command_argument(1, arg)
file = arg
call sacio_readsac(file, head, x, flag)
sum = 0
do i=1, size(x)
    sum = sum + x(i)
end do
mean = sum / size(x)
if (head%depmax > 0) then
    mean = mean / head%depmax
end if
write(*,*) mean

end program crossnorm
