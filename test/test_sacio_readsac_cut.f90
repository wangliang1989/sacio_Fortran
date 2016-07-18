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
!       gfortran -c test_sacio_readhead_cut.f90
!       gfortran test_sacio_readhead_cut.o sacio.o -o test_sacio_readhead_cut
!
program test_sacio_readhead_cut
use sacio
implicit none
integer :: i,tmark, flag
character(len=80) :: filename
real, allocatable, dimension(:) :: data
type(sachead) :: head
real :: t0, t1

filename='testin.sac'
tmark=-5
t0=1
t1=5
write(*,*) "sacio_readsac_cut begin"
!
!   sacio_readsac_cut
!   Description: Read SAC binary file with cut option
!
!   Input:
!       character(len=80) :: filename   filename to be read
!       integer           :: tmark      time marker in SAC header
!                                       -5 means the SAC Header of b
!                                       -3 means the SAC Header of o
!                                       -2 means the SAC Header of a
!                                       0 to 9 means the SAC Header of t0 to t9
!       real              :: t0         begin time is tmark + t0
!       real              :: t1         begin time is tmark + t1
!   Output:
!       type(sachead)     :: head       SAC header to be written
!       real, dimension(:):: data       SAC data to be written
!       integer           :: flag       Error code
!   Error code:
!       0:  Succeed
!       1:  Unable to open file
!       2:  Error in reading SAC header
!       3:  No enough memory to allocate
!       4:  Error in reading SAC data
!       6:  File not in SAC format
!       7:  Illegal time marker
!       8:  Time tmark undefined
!       9:  Cut window outside of time range
call sacio_readsac_cut(filename, head, data, tmark, t0, t1, flag)

write(*,*) head%npts, head%b, head%e
do i=1, head%npts
    write(*,*) i, data(i)
end do
write(*,*) 'sacio_readsac_cut done'
end program
