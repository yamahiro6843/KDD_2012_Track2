# KDD_2012_Track2

## About
現在、[KDD Cup 2012, Track 2](http://www.kddcup2012.org/c/kddcup2012-track2)のデータセットを使い、インターネット広告のCTR予測に関する研究を行っています。    
このリポジトリには、研究のために書いたコードを随時置いていく予定です。

## Organization
* `tables`: 元データからDBを構成するスクリプト
* `modeling`: DBのデータから予測モデルを構築するスクリプト

## Set up DB
`sqlite3 tables/track2.sqlite3`

## Create tables
### Requirement
[Data Files](http://www.kddcup2012.org/c/kddcup2012-track2/data)から`track2`, `test`, `KDD_Track2_solution.csv`をダウンロードし、以下のように配置する。

* `tables/training.txt`
* `tables/test.txt`
* `tables/KDD_Track2_solution.csv`
* `tables/additional_data/descriptionid_tokensid.txt`
* `tables/additional_data/purchasedkeywordid_tokensid.txt`
* `tables/additional_data/queryid_tokensid.txt`
* `tables/additional_data/titleid_tokensid.txt`
* `tables/additional_data/userid_profile.txt`

### TRAINING DATA FILE
1. `./tables/add_id_to_training.sh`
2. `sqlite3 tables/track2.sqlite3`
3. `.read tables/create_training_table.sql`

### ADDITIONAL DATA FILES
#### データセットをもとにテーブルを作成
1. `./tables/split_tokens.sh`
2. `sqlite3 tables/track2.sqlite3`
3. `.read tables/additional_data/create_*.sql`

#### 予測のために新たにテーブルを作成・カラムを追加
1. `python3 tables/additional_data/add_columns_to_*.py`
2. `python3 tables/additional_data/build_*_id_imp_ctr.*`

### TESTING DATASET
1. `./tables/join_solution.sh`
2. `sqlite3 tables/track2.sqlite3`
3. `.read tables/create_testing_table.sql`

実行後、`tables/track2.sqlite3``は`55.07GB`になる。       
不要なインデックスを削除することでこれより小さくすることもできる。

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
