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
!       gfortran -c test_sacio_readsac.f90
!       gfortran test_sacio_readsac.o sacio.o -o test_sacio_readsac
!
program test_sacio_readsac
use sacio
implicit none
integer :: i, flag
character(len=80) :: filename
real,allocatable,dimension(:) :: data
type(sachead) :: head

filename="testin.sac"

write(*,*) "sacio_readsac begin"
!
!   sacio_readsac
!
!   Description: Read SAC binary data
!   Input:
!       character(len=80) :: filename   filename to be read
!   Output:
!       type(sachead)     :: head       SAC header to be filled
!       real, dimension(:):: data       SAC data to be filled
!       integer           :: flag       Error code
!   Error code:
!       0:  Succeed
!       1:  Unable to open file
!       2:  Error in reading SAC header
!       3:  No enough memory to allocate
!       4:  Error in reading SAC data
!       6:  File not in SAC format
!
call sacio_readsac(filename, head, data, flag)

write(*,*)'npts=', head%npts, "delta=", head%delta

do i=1, head%npts
    write(*, *) i, data(i)
end do
write(*,*)'sacio_readsac done'
end program
