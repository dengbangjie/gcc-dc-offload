# TODO List

## DO Concurrent 

1. transform do concurrent to lower: 

gcc/fortran/trans-stmt.cc

``` : c
tree gfc_trans_do_concurrent (gfc_code * code)
```

call 
```:c
gfc_trans_forall_1
```

