import os
import sqlite3
import csv
from collections import OrderedDict

# バージョン確認
print(sqlite3.sqlite_version)

# DBに接続
base_path = os.path.join(os.path.abspath(os.path.dirname(__file__)) , "..")
con = sqlite3.connect(os.path.join(base_path, "track2.sqlite3"), isolation_level = None)
con.row_factory = sqlite3.Row

# 一行ずつ読み込んで処理
result = {}
query = "SELECT * FROM training WHERE age IS NOT NULL AND gender IS NOT NULL AND gender != 0"
for row in con.execute(query):
    print(row["id"])
    token_ids = set()

    for column_name in ["title_id", "description_id"]:
        sub_query = "SELECT * FROM  %(column_name)s_token_id WHERE %(column_name)s = %(id)s" % { "column_name": column_name, "id": row[column_name] }
        token_ids.update(row["token_id"] for row in con.execute(sub_query))

    for token_id in token_ids:
        if result.get(token_id) is None:
            result[token_id] = { "clicks": row["clicks"], "impressions": row["impressions"] }
        else:
            result[token_id]["clicks"] += row["clicks"]
            result[token_id]["impressions"] += row["impressions"]

# 結果をcsvとして書き込み
with open("token_id_imp_ctr.csv", "w", newline = "") as file:
    writer = csv.writer(file)
    writer.writerow(["token_id", "clicks", "impressions", "ctr"])  

    for token_id, values in result.items():
        row = [token_id, values["clicks"], values["impressions"], values["clicks"] / values["impressions"]]
        writer.writerow(row)  

    result = None

# csvの内容をDBに移行
query = "CREATE TABLE token_id_imp_ctr ("
columns = OrderedDict((
    ("id", "integer primary key autoincrement"), 
    ("token_id", "integer"),
    ("clicks", "integer"),
    ("impressions", "integer"),
    ("ctr", "real")
))
query += ", ".join(key + " " + value for key, value in columns.items()) + ");"
if(len(list(con.execute("PRAGMA TABLE_INFO(token_id_imp_ctr)"))) == 0):
    con.execute(query)

with open("token_id_imp_ctr.csv", newline="", encoding="utf-8") as file:
    for i, line in enumerate(csv.reader(file)):
        if(i == 0):
            continue
        else:
            query = "INSERT INTO token_id_imp_ctr VALUES (NULL, " + ", ".join(["?"] * (len(columns) - 1)) + ")"
            con.execute(query, line)

# 終了
con.close()

