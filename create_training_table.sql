-- テーブル生成
create table training(
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
  user_id integer
);

-- データのインポート
.import training_with_id.txt training

-- インデックスの作成
create index training_clicks on training(clicks);
create index training_impressions on training(impressions);
create index training_display_url on training(display_url);
create index training_ad_id on training(ad_id);
create index training_advertiser_id on training(advertiser_id);
create index training_depth on training(depth);
create index training_position on training(position);
create index training_query_id on training(query_id);
create index training_keyword_id on training(keyword_id);
create index training_title_id on training(title_id);
create index training_description_id on training(description_id);
create index training_user_id on training(user_id);

