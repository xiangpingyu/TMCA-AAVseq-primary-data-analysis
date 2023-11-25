#!/bin/bash

## [2] Rearrange {b*}  
python Rearrange1_sorted_qcom.py && python Rearrange2_rearrange_qnew.py &&  python Rearrange31_qnew_reordered_q.py &&  python Rearrange32_qnew_reordered_s.py

### "Delimiters: Space" uqnew.csv and urnew.csv，and then run

python Rearrange4_qs_merged_u.py
