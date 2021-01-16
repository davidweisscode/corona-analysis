#!/bin/bash

# Query the parsed RKI dataset and aggregate for each day
printf "[START] Query RKI data\n"

echo "date,male,female,a0_4,a5_14,a15_34,a35_59,a60_79,a80" > data.csv

# Iterate over all files per day (.json.bz2)
for file in ../2020-rki-archive/data/2_parsed/data_2020*.json.bz2
do
    echo "[QUERY] $file"
    # 08215 --> Karlsruhe region id (urban and rural) according to https://de.wikipedia.org/wiki/Liste_der_Landkreise_in_Deutschland
    # NeuerFall --> new case
    day=$(bzip2 -dkcq $file | jq -r '.[] | select (.IdLandkreis == "08215" and .NeuerFall == 1) | [.Geschlecht, .Altersgruppe] | @tsv')
    date=$(echo $file | grep -Eo '[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}')
    male=$(echo "$day" | grep M | wc -l)
    female=$(echo "$day" | grep W | wc -l)
    # 0-4, 5-14, 15-34, 35-59, 60-79, 80+ --> age groups
    a0_4=$(echo "$day" | grep A00-A04 | wc -l)
    a5_14=$(echo "$day" | grep A05-A14 | wc -l)
    a15_34=$(echo "$day" | grep A15-A34 | wc -l)
    a35_59=$(echo "$day" | grep A35-A59 | wc -l)
    a60_79=$(echo "$day" | grep A60-A79 | wc -l)
    a80=$(echo "$day" | grep A80+ | wc -l)

    echo $date,$male,$female,$a0_4,$a5_14,$a15_34,$a35_59,$a60_79,$a80 >> data.csv
done

printf "[END] Query RKI data\n"
