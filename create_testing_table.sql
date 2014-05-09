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

-- データのインポート
.import test_full.txt testing

-- インデックスの作成
create index testing_clicks on testing(clicks);
create index testing_impressions on testing(impressions);
create index testing_display_url on testing(display_url);
create index testing_ad_id on testing(ad_id);
create index testing_advertiser_id on testing(advertiser_id);
create index testing_depth on testing(depth);
create index testing_position on testing(position);
create index testing_query_id on testing(query_id);
create index testing_keyword_id on testing(keyword_id);
create index testing_title_id on testing(title_id);
create index testing_description_id on testing(description_id);
create index testing_user_id on testing(user_id);
