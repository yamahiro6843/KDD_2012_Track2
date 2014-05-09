#!/bin/sh

echo "formatting..."
more training.txt | awk -F "[,\t]" -v OFS="|" '{ $13=""; print NR,substr($0,0,length($0)-1) }' > training_with_id.txt

echo "finished..."
