# KDD_2012_Track2

## About
現在、修士研究として広告のCTR予測を行っており、[KDD Cup 2012 Track 2](http://www.kddcup2012.org/c/kddcup2012-track2)のデータセットを使っています。   
このリポジトリには、研究のために書いたコードを随時置いていく予定です。

## How to use

### 訓練データの整形・インポート
1. `./add_id_to_training.sh`
2. `sqlite3 track2.sqlite3`
3. `.read create_training_table.sql`

### テストデータの整形・インポート
1. `./join_solution.sh`
2. `sqlite3 track2.sqlite3`
3. `.read create_testing_table.sql`

