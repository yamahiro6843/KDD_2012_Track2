import sqlite3
import pandas as pd

# バージョン確認
print(sqlite3.sqlite_version)

# DBに接続
con = sqlite3.connect("/Users/yasaichi/KDD_2012_Track2/track2.sqlite3")
con.row_factory = sqlite3.Row

# age, genderカラムを追加
column_names = pd.read_sql("PRAGMA TABLE_INFO(training)", con)["name"].values
if "gender" not in column_names:
    con.execute("ALTER TABLE training ADD COLUMN gender integer")
if "age" not in column_names:
    con.execute("ALTER TABLE training ADD COLUMN age integer")

# データをセット
for row in con.execute("SELECT * FROM users"):
    query = "UPDATE training SET gender = %d, age = %d WHERE user_id = %d;" % (row["gender"], row["age"], row["id"])
    print(query)
    con.execute(query)

# インデックスを作成
print("create index ...")
con.execute("CREATE INDEX training_age ON training(age)")

