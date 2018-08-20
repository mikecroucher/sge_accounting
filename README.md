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

## Looking about with AWK

Some work I did with David Jones ages ago used AWK. I base this section from that

Let's see the maximum number of cores ever requested by each user on the system

```
gawk -F: '$35>=slots[$4] {slots[$4]=$35};END{for(n in slots){print n, slots[n]}}' accounting | sort -nk2
```

How many unique usernames?

```
cut ./accounting_1percent_sample.txt -f 4 -d ':' | sort | uniq | wc
```

How many have only ever run 1 core jobs?

```
gawk -F: '$35>=slots[$4] {slots[$4]=$35};END{for(n in slots){if(slots[n]==1){print n, slots[n]}}}' ./accounting | wc
```

How many have never run a job more than 40 cores?  This is the number of cores that will probably be on a node on ARC4

```
gawk -F: '$35>=slots[$4] {slots[$4]=$35};END{for(n in slots){if(slots[n]<40){print n, slots[n]}}}' ./accounting | wc
```
