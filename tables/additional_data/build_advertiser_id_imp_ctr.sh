#!/bin/sh

data_base="../track2.sqlite3"

# テーブルの元になるデータを生成
echo "generating..."
sqlite3 ${data_base} <<END
.mode csv
.output advertiser_id_imp_ctr.txt.tmp
SELECT advertiser_id, SUM(clicks) AS clicks, SUM(impressions) AS impressions, CAST(SUM(clicks) AS real) / SUM(impressions) AS ctr 
FROM training WHERE age IS NOT NULL AND gender IN (1,2) GROUP BY advertiser_id;
END

# idを付け加える
echo "formatting..."
awk -F "," -v OFS=","  'NR == 1 { print "id",$0 } NR > 1 { print NR-1,$0 }' advertiser_id_imp_ctr.txt.tmp > advertiser_id_imp_ctr.txt
rm advertiser_id_imp_ctr.txt.tmp

# テーブル生成 & データ流し込み
echo "importing..."
sqlite3 ${data_base} <<END
create table advertiser_id_imp_ctr(
  id integer primary key autoincrement,
  advertiser_id integer,
  clicks integer,
  impressions integer,
  ctr real
);
.separator ,
.import advertiser_id_imp_ctr.txt advertiser_id_imp_ctr
create index advertiser_id_imp_ctr_advertiser_id_index on advertiser_id_imp_ctr(advertiser_id);
END

