#!/bin/sh

declare -a names=(
  "descriptionid_tokensid"
  "purchasedkeywordid_tokensid"
  "queryid_tokensid"
  "titleid_tokensid"
)

for name in ${names[@]}; do
  input="additional_data/${name}.txt"
  output="additional_data/${name}_split.txt"

  echo "formatting ${name} ..."
  awk -v OFS="|" 'BEGIN { id = 1 } { split($2,tokens,"|"); for(i=1; i<= length(tokens); i++){ print id,$1,tokens[i]; id++ } }' ${input} > ${output}
done
