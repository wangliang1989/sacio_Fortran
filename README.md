# sacio_Fortran

This project provides a Fortran 90 module named `sacio` for reading and writting evenly-spaced SAC binary format files.

SAC I/O subroutines in the module:

1. `sacio_readhead`: Read SAC binary header only
2. `sacio_readsac`: Read SAC binary file
3. `sacio_writesac`: Write SAC binary file
4. `sacio_readsac_cut`: Read SAC binary file with cut option
5. `sacio_nullhead`: Change a SAC header to undefined
6. `sacio_newhead`: Create a ready-to-use SAC header for evenly-spaced SAC data

To contact me: wangliang0222@foxmail.com

## How To Get

### Method 1

Click "Download ZIP" button at the right side of the webpage.

### Method 2

Use git:

~~~bash
$ git clone https://github.com/PeterPanwl/sacio_Fortran.git
~~~

## FileList

1. `sacio.f90`: source code of `sacio` module (THIS IS WHAT YOU REALLY NEED!)
2. examples: `test_sacio_*.f90` show the usage of subroutines provided by `sacio` module
3. `Makefile`: makefile showing how to compile and link
4. `README.md`: this file
5. `.log.md`: the log file
6. example data: `testin.sac`: SAC file in binary format

## How to use

1. **Read examples for more details.**

2. Compile & Link

   ~~~bash
   $ gfortran -c sacio.f90
   $ gfortran -c your_program.f90
   $ gfortran your_program.o sacio.o -o your_program
   ~~~

## Revision History

- 2015-09-11: v1.0

## License

Copyright  2015  Liang Wang & Dongdong Tian

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.!
