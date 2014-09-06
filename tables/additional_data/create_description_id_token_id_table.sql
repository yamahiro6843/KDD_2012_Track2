-- テーブル生成
create table description_id_token_id(
  id integer primary key autoincrement,
  description_id integer,
  token_id integer
);

-- データのインポート
.import descriptionid_tokensid_split.txt description_id_token_id

-- インデックスの作成
create index description_id_token_id_description_id_index on description_id_token_id(description_id);
create index description_id_token_id_token_id_index on description_id_token_id(token_id);
