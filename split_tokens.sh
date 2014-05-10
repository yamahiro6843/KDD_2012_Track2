#!/bin/sh

declare -a names=(
  "purchasedkeywordid_tokensid"
  "descriptionid_tokensid"
  "purchasedkeywordid_tokensid"
  "queryid_tokensid"
  "titleid_tokensid"
)

for name in ${names[@]}; do
  input="additional_data/${name}.txt"
  output="additional_data/${name}_split.txt"

  echo "formatting ${name} ..."
  awk -v OFS="|" '{ split($2,tokens,"|"); for(i=1; i<= length(tokens); i++){ print $1,tokens[i] } }' ${input} > ${output}
done
