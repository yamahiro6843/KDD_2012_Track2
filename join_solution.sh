#!/bin/sh

echo 'sed -i.bak -e "1d" KDD_Track2_solution.csv'
sed -i.bak -e "1d" KDD_Track2_solution.csv

echo "paste KDD_Track2_solution.csv test.txt"
paste KDD_Track2_solution.csv test.txt > test_full_not_formatted.txt

echo "formatting..."
awk -F "[,\t]" -v OFS="|" '{ print NR,$1,$2,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$3 }' test_full_not_formatted.txt > test_full.txt

echo "finished..."
rm test_full_not_formatted.txt
mv KDD_Track2_solution.csv.bak KDD_Track2_solution.csv
