#!/bin/bash
num_threads_exporting=2342232
num_threads_listing=8327
line21="         <stringProp name=\"ThreadGroup\.num_threads\">${num_threads_exporting}<\/stringProp>"
# linw82=         <stringProp name=\"ThreadGroup\.num_threads\">${num_threads_exporting}<\/stringProp>
# sed -i '21s/.*/${line21}/' workload.jmx
# sed -i '82s/.*/${line82}/' workload.jmx

awk -v where=21 -v what="         <stringProp name=\"ThreadGroup\.num_threads\">${num_threads_exporting}<\/stringProp>" 'FNR==where {print what; next} 1' workload.jmx > temp.jmx && mv temp.jmx workload.jmx
# awk -i -v where=21 -v what=$line82 'FNR==where {print what; next} 1' workload.jmx
awk -v where=82 -v what="         <stringProp name=\"ThreadGroup\.num_threads\">${num_threads_listing}<\/stringProp>" 'FNR==where {print what; next} 1' workload.jmx > temp.jmx && mv temp.jmx workload.jmx