/* { dg-do compile } */
/* { dg-options "-march=rv64gcv_zvfhmin -mabi=lp64d -O3 -mrvv-max-lmul=m8" } */

#include "../vls-vlmax/merge-2.c"

/* { dg-final { scan-assembler-times {\tvmerge.vvm} 11 } } */
