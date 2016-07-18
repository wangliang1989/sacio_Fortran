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
!       gfortran -c test_sacio_readhead.f90
!       gfortran test_sacio_readhead.o sacio.o -o test_sacio_readhead
!

program test_sacio_readhead
use sacio
implicit none
integer :: flag
character(len=80) :: filename
type(sachead) :: head

filename="testin.sac"

write(*,*) "sacio_readhead begin:"
!
!   sacio_readhead
!
!   Description: Read SAC binary header
!   Input:
!       character(len=*) :: filename   filename to be read
!   Output:
!       type(sachead)    :: head       SAC header to be filled
!       integer          :: flag       Error code
!
!   Error code:
!       0:  Succeed
!       1:  Unable to open file
!       2:  Error in reading SAC header
!       6:  File not in SAC format
!
call sacio_readhead(filename, head, flag)

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

write(*,*) 'sacio_readhead done'
end program
