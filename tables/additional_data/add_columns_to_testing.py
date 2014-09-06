import sqlite3
import os
import pandas as pd

# バージョン確認
print(sqlite3.sqlite_version)

# DBに接続
base_path = os.path.join(os.path.abspath(os.path.dirname(__file__)) , "..")
con = sqlite3.connect(os.path.join(base_path, "track2.sqlite3"))
con.row_factory = sqlite3.Row

# age, genderカラムを追加
column_names = pd.read_sql("PRAGMA TABLE_INFO(testing)", con)["name"].values
if "gender" not in column_names:
    con.execute("ALTER TABLE testing ADD COLUMN gender integer")
if "age" not in column_names:
    con.execute("ALTER TABLE testing ADD COLUMN age integer")

# データをセット
for row in con.execute("SELECT * FROM users"):
    query = "UPDATE testing SET gender = %d, age = %d WHERE user_id = %d;" % (row["gender"], row["age"], row["id"])
    print(query)
    con.execute(query)

# インデックスを作成
print("create index ...")
con.execute("CREATE INDEX testing_age ON testing(age)")

