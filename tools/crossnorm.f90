program crossnorm
use sacio
use module_crossnorm
implicit none
character(len=80) :: filex, filey, filez

call get_command_argument(1, filex)
call get_command_argument(2, filey)
call get_command_argument(3, filez)
call sub_crossnorm(filex, filey, filez)

end program crossnorm
