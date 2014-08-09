# KDD_2012_Track2

## About
現在、[KDD Cup 2012, Track 2](http://www.kddcup2012.org/c/kddcup2012-track2)のデータセットを使い、インターネット広告のCTR予測に関する研究を行っています。    
このリポジトリには、研究のために書いたコードを随時置いていく予定です。

## Set up DB
`sqlite3 track2.sqlite3`

## Create tables

### TRAINING DATA FILE
1. `./add_id_to_training.sh`
2. `sqlite3 track2.sqlite3`
3. `.read create_training_table.sql`

### ADDITIONAL DATA FILES
#### データセットをもとにテーブルを作成
1. `./split_tokens.sh`
2. `sqlite3 track2.sqlite3`
3. `.read additional_data/*.sql`

#### 予測のために新たにテーブルを作成・カラムを追加
1. `python3 additional_data/add_columns_to_training.py`
2. `python3 additional_data/build_token_id_imp_ctr.py`

### TESTING DATASET
1. `./join_solution.sh`
2. `sqlite3 track2.sqlite3`
3. `.read create_testing_table.sql`

計`54.64GB`  
不要なインデックスを削除することでこれより小さくすることもできる

## Modeling
1. `prediction.py`   
何らかの機械学習の手法により、広告、クエリー、ユーザーが与えられたときのCTRを予測する（予定）

2. `x_means.py`   
x-means法により広告をクラスタリングする

## References
1. 公式サイト       
[KDD Cup 2012, Track 2](http://www.kddcup2012.org/c/kddcup2012-track2)

2. Track2のタスク・データ構造の説明など    
[Hive/Hivemallを利用した広告クリックスルー率(CTR)の推定](http://qiita.com/myui/items/f726ca3dcc48410abe45)

3. 優勝チーム（National Taiwan University）の論文   
[A Two-Stage Ensemble of Diverse Models for Advertisement Ranking in KDD Cup 2012](https://kaggle2.blob.core.windows.net/competitions/kddcup2012/2748/media/NTU.pdf)

## Author
* [yasaichi](https://github.com/yasaichi)
