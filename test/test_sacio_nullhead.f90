!Copyright  2015  Liang Wang & Dongdong Tian
!
!Licensed under the Apache License, Version 2.0 (the "License");
!you may not use this file except in compliance with the License.
!You may obtain a copy of the License at
!
!    http://www.apache.org/licenses/LICENSE-2.0
!
!Unless required by applicable law or agreed to in writing, software
!distributed under the License is distributed on an "AS IS" BASIS,
!WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
!See the License for the specific language governing permissions and
!limitations under the License.!
!
!   Author：
!       Liang Wang         E-mail: wangliang0222@foxmail.com
!       Dongdong Tian      E-mail: seisman.info@gmail.com
!
!   Compile:
!       gfortran -c sacio.f90
!       gfortran -c test_sacio_nullhead.f90
!       gfortran test_sacio_nullhead.o sacio.o -o test_sacio_nullhead
!
program test_sacio_nullhead
use sacio
implicit none
type(sachead) :: head

write(*,*) 'sacio_nullhead begin'
!
!   sacio_nullhead
!
!   Description: Change a SAC header to undefined
!   Input & Output:
!       type(sachead)     :: head       SAC header to be undefined
!
call sacio_nullhead(head)

write(*,*) 'nvhdr=', head%nvhdr
write(*,*) 'npts=', head%npts
write(*,*) 'evdp=', head%evdp
write(*,*) 'stla=', head%stla
write(*,*) 'stlo=', head%stlo
write(*,*) 'delta=', head%delta
write(*,*) 'b=', head%b
write(*,*) 'o=', head%o
write(*,*) 'a=', head%a
write(*,*) 'kstnm=', head%kstnm

write(*,*) 'sacio_nullhead done'
end program
