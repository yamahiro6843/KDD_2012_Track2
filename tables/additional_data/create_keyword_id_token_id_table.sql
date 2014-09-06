-- テーブル生成
create table keyword_id_token_id(
  id integer primary key autoincrement,
  keyword_id integer,
  token_id integer
);

-- データのインポート
.import purchasedkeywordid_tokensid_split.txt keyword_id_token_id

-- インデックスの作成
create index keyword_id_token_id_keyword_id_index on keyword_id_token_id(keyword_id);
create index keyword_id_token_id_token_id_index on keyword_id_token_id(token_id);
