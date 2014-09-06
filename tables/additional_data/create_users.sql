-- 区切り文字の変更
.separator "\t"

-- テーブル生成
create table users(
  id integer primary key autoincrement,
  gender integer,
  age integer
);

-- データのインポート
.import userid_profile.txt users

-- インデックスの作成
create index users_age_index on users(age);

-- 区切り文字を元に戻す
.separator "|"