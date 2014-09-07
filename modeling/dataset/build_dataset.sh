#!/bin/sh

# コマンドライン引数を処理
if [ $# -eq 0 ]; then
  type="original"
  num=2000
  table="testing"
elif [ $# -eq 1 ]; then
  type=$1
  num=2000
  table="testing"
elif [ $# -eq 2 ]; then
  type=$1
  num=$2
  table="testing"
elif [ $# -eq 3 ]; then
  type=$1
  num=$2
  table=$3
else
  echo "usage: ./build_dataset.sh [original|extended] n [training|testing] "
  exit 1
fi

# 特徴量を生成するプログラムを実行
program_names=(`ls ~/Dropbox/master_thesis/modeling/gradient_boosting/f_*.py`)
for name in ${program_names[@]}; do
  python3 ${name} ${num} ${table}
done

# 生成されたファイル名を取得
file_names=(`ls ../features/f_all_${table}_*.csv`)

# 各ファイルの結合
sort ${file_names[0]} > temp_1.csv

for i in $(seq 1 $(expr ${#file_names[@]} - 1)); do
  sort ${file_names[i]} > ${file_names[i]}.tmp

  input1="temp_${i}.csv"
  input2=${file_names[i]}.tmp
  output="temp_$(($i+1)).csv"

  echo "join -t \",\" ${input1} ${input2} > ${output}"
  join -t "," ${input1} ${input2} > ${output}

  rm ${input1}
  rm ${input2}
done

# 目的変数を生成するプログラムを実行
python3 ~/Dropbox/master_thesis/modeling/gradient_boosting/build_response.py ${type} ${num} ${table}
sort all_${table}_response.csv > all_${table}_response.tmp

# 結合してトレーニング/テストデータとして書き出し
if [ ${table} = "training" ]; then
  prefix="training_"
fi
join -t "," all_${table}_response.tmp ${output} > ${prefix}testing.csv

# データセットにヘッダーを追加
column_names=`tail -n 1 ${prefix}testing.csv`
gsed -i -e "1i ${column_names}" ${prefix}testing.csv
gsed -i -e '$d' ${prefix}testing.csv

# 不要なファイルを削除
rm ${output}
rm all_${table}_response.*


