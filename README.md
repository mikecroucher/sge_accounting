# sge accounting
Seeing what I can see with Leeds HPC accounting logs.

## Where are the logs?

* ARC2 - `/services/sge_prod/default/common`
* ARC3 - 

## Taking a sample of the accounting log

The accounting log is huge so lets sample 1 percent of it to play around with. Code taken from https://unix.stackexchange.com/questions/108581/how-to-randomly-sample-a-subset-of-a-file 

```
cat accounting | awk 'BEGIN {srand()} !/^$/ { if (rand() <= .01) print $0}' > ~/accounting_1percent_sample.txt
```
