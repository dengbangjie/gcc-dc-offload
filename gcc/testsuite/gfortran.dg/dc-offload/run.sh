#!/bin/bash
export DG_DIR="$(pwd)/gcc/testsuite/gfortran.dg/dc-offload"
export BUILD_DIR="$(pwd)/build"
export PATH=/home/dbj/gcc-dev/gcc-dc-offload/build/gcc:${PATH}



gdb -cd ${DG_DIR}  --args ${BUILD_DIR}/gcc/gfortran   -O0 -fdo-concurrent=serial -fdump-passes -c dc_1.f90



rm ./dc_1.f90.*

../../../../build/gcc/gfortran -O0 -fdo-concurrent=serial -fdump-passes -c dc_1.f90 > dc_1.passes.log 2>dc_1.passes.err
../../../../build/gcc/gfortran -O0 -fdo-concurrent=serial  -fdump-tree-all -c dc_1.f90 > dc_1.tree.log 2>dc_1.tree.err