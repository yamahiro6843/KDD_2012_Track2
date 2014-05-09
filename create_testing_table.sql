-- テーブル生成
create table testing(
  id integer primary key autoincrement,
  clicks integer,
  impressions integer,
  display_url text,
  ad_id integer,
  advertiser_id integer,
  depth integer,
  position integer,
  query_id integer,
  keyword_id integer,
  title_id integer,
  description_id integer,
  user_id integer,
  indicator text
);

-- インデックスの作成
create index testingindex on testing(
  display_url,
  ad_id,
  advertiser_id,
  depth,
  position,
  query_id,
  keyword_id,
  title_id,
  description_id,
  user_id
);

-- データのインポート
.import test_full.txt testing

