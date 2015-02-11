/* { dg-do compile } */
/* { dg-require-effective-target arm_arch_v8a_ok } */
/* { dg-options "-O2" } */
/* { dg-add-options arm_arch_v8a } */

#include "../aarch64/atomic-op-consume.x"

/* PR59448 consume not implemented yet.  */
/* { dg-final { scan-assembler-times "ldrex\tr\[0-9\]+, \\\[r\[0-9\]+\\\]" 6 { xfail *-*-* } } } */
/* { dg-final { scan-assembler-times "strex\t...?, r\[0-9\]+, \\\[r\[0-9\]+\\\]" 6 } } */
/* { dg-final { scan-assembler-not "dmb" } } */
