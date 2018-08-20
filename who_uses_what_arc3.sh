#!/bin/bash
#$ -l h_vmem=16G
#$ -l h_rt=2:00:00

accounting_file=/services/sge_prod/default/common/accounting

#How many unique users?
echo 'number of uniuqe users'
cut $accounting_file -f 4 -d ':' | sort | uniq | wc

echo 'number who have only ever submitted single core jobs'
gawk -F: '$35>=slots[$4] {slots[$4]=$35};END{for(n in slots){if(slots[n]==1){print n, slots[n]}}}' $accounting_file | wc

echo 'number who have never asked for more than 40 cores?'
gawk -F: '$35>=slots[$4] {slots[$4]=$35};END{for(n in slots){if(slots[n]<=40){print n, slots[n]}}}' $accounting_file | wc

echo 'number who have never asked for more than 48 cores?'
gawk -F: '$35>=slots[$4] {slots[$4]=$35};END{for(n in slots){if(slots[n]<=48){print n, slots[n]}}}' $accounting_file | wc

echo 'number who have never asked for more than 72 cores?'
gawk -F: '$35>=slots[$4] {slots[$4]=$35};END{for(n in slots){if(slots[n]<=72){print n, slots[n]}}}' $accounting_file | wc

echo 'number who have never asked for more than 96 cores?'
gawk -F: '$35>=slots[$4] {slots[$4]=$35};END{for(n in slots){if(slots[n]<=96){print n, slots[n]}}}' $accounting_file | wc
