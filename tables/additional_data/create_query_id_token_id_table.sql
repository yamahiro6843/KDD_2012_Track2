-- テーブル生成
create table query_id_token_id(
  id integer primary key autoincrement,
  query_id integer,
  token_id integer
);

-- データのインポート
.import queryid_tokensid_split.txt query_id_token_id

-- インデックスの作成
create index query_id_token_id_query_id_index on query_id_token_id(query_id);
create index query_id_token_id_token_id_index on query_id_token_id(token_id);
