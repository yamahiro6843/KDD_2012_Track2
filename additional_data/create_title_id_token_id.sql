-- テーブル生成
create table title_id_token_id(
  title_id integer,
  token_id integer
);

-- データのインポート
.import titleid_tokensid_split.txt title_id_token_id

-- インデックスの作成
create index title_id_token_id_title_id_index on title_id_token_id(title_id);
create index title_id_token_id_token_id_index on title_id_token_id(token_id);
