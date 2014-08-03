#!/bin/sh

names=("keyword" "title" "description")

temp_output="token_ids.tmp"
final_output="token_ids.txt"
query=""

for name in ${names[@]}; do
  query+="SELECT token_id FROM ${name}_id_token_id GROUP BY token_id;"
done

# 広告のkeyword, title, descriptionに使われているトークンIDを取得
echo "fetch token_ids from track2.sqlite3 ..."
sqlite3 ../track2.sqlite3 <<EOS
.header off
.output ${temp_output}
${query}
EOS

# Rubyスクリプトでtoken_idをユニークにする
echo "ruby script start ..."
irb <<EOS
  input = File.join("`pwd`", "${temp_output}")
  output = File.join("`pwd`", "${final_output}")
  token_ids = []

  IO.foreach(input) { |id| token_ids << id.chop.to_i }
  File.open(output, "wb") { |f| f.write token_ids.uniq.sort.join("\n") }

  exit
EOS

# 一時ファイルを削除
rm "${temp_output}"


