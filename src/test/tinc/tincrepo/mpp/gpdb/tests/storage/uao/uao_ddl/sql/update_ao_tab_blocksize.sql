-- @description : update UAO tables , with different blocksize
-- 

-- create select uao table with BLOCKSIZE=8K 
DROP TABLE IF EXISTS uao_tab_blocksize_upd_8k cascade;

CREATE TABLE uao_tab_blocksize_upd_8k  with (appendonly=true , BLOCKSIZE=8192 )  AS (
SELECT GENERATE_SERIES::numeric sno
     , (random() * 10000000)::numeric + 10000000 val1
     , timeofday()::varchar(50) val2
     , (random() * 5000)::bigint + 10000000 val3
     , (random() * 10000000)::numeric + 10000000 val4
     , (random() * 10000000)::numeric + 10000000 val5	
  FROM GENERATE_SERIES(10000, 19999)
) ;
CREATE index val3_bmp_idxblocksize_upd_8k on uao_tab_blocksize_upd_8k using bitmap (val3);
\d+ uao_tab_blocksize_upd_8k 
SELECT count(*) from uao_tab_blocksize_upd_8k;
SELECT 1 AS VisimapPresent  FROM pg_appendonly WHERE visimapidxid is not NULL AND visimapidxid is not NULL AND relid=(SELECT oid FROM pg_class WHERE relname='uao_tab_blocksize_upd_8k');

select 1 as block8k_present from pg_appendonly WHERE   blocksize=8192 AND relid=(SELECT oid  FROM pg_class WHERE relname='uao_tab_blocksize_upd_8k');

update  uao_tab_blocksize_upd_8k set val2 = 'new_val' where sno = 10000;
select count(*) AS only_visi_tups  from uao_tab_blocksize_upd_8k;
set gp_select_invisible = true;
select count(*) AS invisi_and_visi_tups  from uao_tab_blocksize_upd_8k;
set gp_select_invisible = false;

-- create select uao table with BLOCKSIZE=2048K 

DROP TABLE IF EXISTS uao_tab_blocksize_upd_2048k cascade;
CREATE TABLE uao_tab_blocksize_upd_2048k  with (appendonly=true , BLOCKSIZE=2097152 )  AS (
SELECT GENERATE_SERIES::numeric sno
     , (random() * 10000000)::numeric + 10000000 val1
     , timeofday()::varchar(50) val2
     , (random() * 5000)::bigint + 10000000 val3
     , (random() * 10000000)::numeric + 10000000 val4
     , (random() * 10000000)::numeric + 10000000 val5	
  FROM GENERATE_SERIES(10000, 19999)
) ;
CREATE index val3_bmp_idxblocksize_upd_2048k on uao_tab_blocksize_upd_2048k using bitmap (val3);

\d+ uao_tab_blocksize_upd_2048k 

SELECT count(*) from uao_tab_blocksize_upd_2048k;
SELECT 1 AS VisimapPresent  FROM pg_appendonly WHERE visimapidxid is not NULL AND visimapidxid is not NULL AND relid=(SELECT oid FROM pg_class WHERE relname='uao_tab_blocksize_upd_2048k');

select 1 as block2048k_present from pg_appendonly WHERE   blocksize=2097152 AND relid=(SELECT oid  FROM pg_class WHERE relname='uao_tab_blocksize_upd_2048k');

update  uao_tab_blocksize_upd_2048k set val2 = 'new_val' where sno = 10000;
select count(*) AS only_visi_tups  from uao_tab_blocksize_upd_2048k;
set gp_select_invisible = true;
select count(*) AS invisi_and_visi_tups  from uao_tab_blocksize_upd_2048k;
set gp_select_invisible = false;

-- create select uao table with BLOCKSIZE=default

DROP TABLE IF EXISTS uao_tab_blocksize_upd_default cascade;

CREATE TABLE uao_tab_blocksize_upd_default with (appendonly=true)  AS (
SELECT GENERATE_SERIES::numeric sno
     , (random() * 10000000)::numeric + 10000000 val1
     , timeofday()::varchar(50) val2
     , (random() * 5000)::bigint + 10000000 val3
     , (random() * 10000000)::numeric + 10000000 val4
     , (random() * 10000000)::numeric + 10000000 val5	
  FROM GENERATE_SERIES(10000, 19999)
) ;
CREATE index val3_bmp_idxblocksize_upd_default on uao_tab_blocksize_upd_default using bitmap (val3);
\d+ uao_tab_blocksize_upd_default 
SELECT count(*) from uao_tab_blocksize_upd_default;
SELECT 1 AS VisimapPresent  FROM pg_appendonly WHERE visimapidxid is not NULL AND visimapidxid is not NULL AND relid=(SELECT oid FROM pg_class WHERE relname='uao_tab_blocksize_upd_default');

select 1 as blockdefault_present from pg_appendonly WHERE   blocksize=32768 AND relid=(SELECT oid  FROM pg_class WHERE relname='uao_tab_blocksize_upd_default');
update  uao_tab_blocksize_upd_default set val2 = 'new_val' where sno = 10000;
select count(*) AS only_visi_tups  from uao_tab_blocksize_upd_default;
set gp_select_invisible = true;
select count(*) AS invisi_and_visi_tups  from uao_tab_blocksize_upd_default;
set gp_select_invisible = false;

