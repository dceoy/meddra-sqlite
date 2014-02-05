-- MedDRA
-- sql script to create tables and indexes

CREATE TABLE llt (
  llt_code integer not null,
  llt_name text not null,
  pt_code integer,
  llt_whoart_code text,
  llt_harts_code integer,
  llt_costart_sym text,
  llt_icd9_code text,
  llt_icd9cm_code text,
  llt_icd10_code text,
  llt_currency text,
  llt_jart_code text
);
CREATE INDEX ix1_pt_llt01 on llt (llt_code);
CREATE INDEX ix1_pt_llt02 on llt (llt_name);
CREATE INDEX ix1_pt_llt03 on llt (pt_code);

CREATE TABLE pt (
  pt_code integer not null,
  pt_name text not null,
  null_field text,
  pt_soc_code integer,
  pt_whoart_code text,
  pt_harts_code integer,
  pt_costart_sym text,
  pt_icd9_code text,
  pt_icd9cm_code text,
  pt_icd10_code text,
  pt_jart_code text
);
CREATE INDEX ix1_pt01 on pt (pt_code);
CREATE INDEX ix1_pt02 on pt (pt_name);
CREATE INDEX ix1_pt03 on pt (pt_soc_code);

CREATE TABLE hlt (
  hlt_code integer not null,
  hlt_name text,
  hlt_whoart_code text,
  hlt_harts_code integer,
  hlt_costart_sym text,
  hlt_icd9_code text,
  hlt_icd9cm_code text,
  hlt_icd10_code text,
  hlt_jart_code text
);
CREATE INDEX ix1_hlt01 on hlt (hlt_code);
CREATE INDEX ix1_hlt02 on hlt (hlt_name);

CREATE TABLE hlt_pt (
  hlt_code integer not null,
  pt_code integer not null
);
CREATE INDEX ix1_hlt_pt01 on hlt_pt (hlt_code, pt_code);
CREATE INDEX ix1_hlt_pt02 on hlt_pt (pt_code, hlt_code);

CREATE TABLE hlgt (
  hlgt_code integer not null,
  hlgt_name text,
  hlgt_whoart_code text,
  hlgt_harts_code integer,
  hlgt_costart_sym text,
  hlgt_icd9_code text,
  hlgt_icd9cm_code text,
  hlgt_icd10_code text,
  hlgt_jart_code text
);
CREATE INDEX ix1_hlgt01 on hlgt (hlgt_code);
CREATE INDEX ix1_hlgt02 on hlgt (hlgt_name);

CREATE TABLE hlgt_hlt (
  hlgt_code integer not null,
  hlt_code integer not null
);
CREATE INDEX ix1_hlgt_hlt01 on hlgt_hlt (hlgt_code, hlt_code);
CREATE INDEX ix1_hlgt_hlt02 on hlgt_hlt (hlt_code, hlgt_code);

CREATE TABLE soc (
  soc_code integer not null,
  soc_name text,
  soc_abbrev text not null,
  soc_whoart_code text,
  soc_harts_code integer,
  soc_costart_sym text,
  soc_icd9_code text,
  soc_icd9cm_code text,
  soc_icd10_code text,
  soc_jart_code text
);
CREATE INDEX ix1_soc01 on soc (soc_code);
CREATE INDEX ix1_soc02 on soc (soc_name);

CREATE TABLE soc_hlgt (
  soc_code integer not null,
  hlgt_code integer not null
);
CREATE INDEX ix1_soc_hlgt01 on soc_hlgt (soc_code, hlgt_code);
CREATE INDEX ix1_soc_hlgt02 on soc_hlgt (soc_code);
CREATE INDEX ix1_soc_hlgt03 on soc_hlgt (hlgt_code, soc_code);

CREATE TABLE mdhier (
  pt_code integer not null,
  hlt_code integer not null,
  hlgt_code integer not null,
  soc_code integer not null,
  pt_name text not null,
  hlt_name text not null,
  hlgt_name text not null,
  soc_name text not null,
  soc_abbrev text not null,
  null_field text,
  pt_soc_code integer,
  primary_soc_fg text
);
CREATE INDEX ix1_md_hier01 on mdhier (pt_code);
CREATE INDEX ix1_md_hier02 on mdhier (hlt_code);
CREATE INDEX ix1_md_hier03 on mdhier (hlgt_code);
CREATE INDEX ix1_md_hier04 on mdhier (soc_code);
CREATE INDEX ix1_md_hier05 on mdhier (pt_soc_code);

CREATE TABLE intl_ord (
  intl_ord_code integer not null,
  soc_code integer not null
);
CREATE INDEX ix1_intl_ord01 on intl_ord (intl_ord_code, soc_code);

CREATE TABLE llt_j (
  llt_code integer not null,
  llt_kanji text,
  llt_jcurr text,
  llt_kana text,
  llt_kana1 text,
  llt_kana2 text
);
CREATE INDEX ix1_pt_llt_j01 on llt_j (llt_code);
CREATE INDEX ix1_pt_llt_j02 on llt_j (llt_kanji);
CREATE INDEX ix1_pt_llt_j03 on llt_j (llt_kana);
CREATE INDEX ix1_pt_llt_j04 on llt_j (llt_kana1);
CREATE INDEX ix1_pt_llt_j05 on llt_j (llt_kana2);

CREATE TABLE pt_j (
  pt_code integer not null,
  pt_kanji text,
  pt_kana text,
  pt_kana1 text,
  pt_kana2 text
);
CREATE INDEX ix1_pt_j01 on pt_j (pt_code);
CREATE INDEX ix1_pt_j02 on pt_j (pt_kanji);
CREATE INDEX ix1_pt_j03 on pt_j (pt_kana);
CREATE INDEX ix1_pt_j04 on pt_j (pt_kana1);
CREATE INDEX ix1_pt_j05 on pt_j (pt_kana2);

CREATE TABLE hlt_j (
  hlt_code integer not null,
  hlt_kanji text,
  hlt_kana text,
  hlt_kana1 text,
  hlt_kana2 text
);
CREATE INDEX ix1_hlt_j01 on hlt_j (hlt_code);
CREATE INDEX ix1_hlt_j02 on hlt_j (hlt_kanji);
CREATE INDEX ix1_hlt_j03 on hlt_j (hlt_kana);
CREATE INDEX ix1_hlt_j04 on hlt_j (hlt_kana1);
CREATE INDEX ix1_hlt_j05 on hlt_j (hlt_kana2);

CREATE TABLE hlgt_j (
  hlgt_code integer not null,
  hlgt_kanji text,
  hlgt_kana text,
  hlgt_kana1 text,
  hlgt_kana2 text
);
CREATE INDEX ix1_hlgt_j01 on hlgt_j (hlgt_code);
CREATE INDEX ix1_hlgt_j02 on hlgt_j (hlgt_kanji);
CREATE INDEX ix1_hlgt_j03 on hlgt_j (hlgt_kana);
CREATE INDEX ix1_hlgt_j04 on hlgt_j (hlgt_kana1);
CREATE INDEX ix1_hlgt_j05 on hlgt_j (hlgt_kana2);

CREATE TABLE soc_j (
  soc_code integer not null,
  soc_kanji text,
  soc_order integer,
  soc_kana text,
  soc_kana1 text,
  soc_kana2 text
);
CREATE INDEX ix1_soc_j01 on soc_j (soc_code);
CREATE INDEX ix1_soc_j02 on soc_j (soc_kanji);
CREATE INDEX ix1_soc_j03 on soc_j (soc_kana);
CREATE INDEX ix1_soc_j04 on soc_j (soc_kana1);
CREATE INDEX ix1_soc_j05 on soc_j (soc_kana2);

CREATE TABLE smq_list (
  smq_code integer not null,
  smq_name text not null,
  smq_level integer not null,
  smq_description text not null,
  smq_source text,
  smq_note text,
  MedDRA_version text not null,
  status text not null,
  smq_algorithm text not null
);
CREATE INDEX ix1_smq_list01 on smq_list (smq_code);

CREATE TABLE smq_list_j (
  smq_code integer not null,
  smq_kanji text not null,
  smq_desc_kanji text not null
);
CREATE INDEX ix1_smq_list_j01 on smq_list_j (smq_code);

CREATE TABLE smq_content (
  smq_code integer not null,
  term_code integer not null,
  term_level integer not null,
  term_scope integer not null,
  term_category text not null,
  term_weight integer not null,
  term_status text not null,
  term_addition_version text not null,
  term_last_modified_version text not null
);
CREATE INDEX ix1_smq_content01 on smq_content (smq_code);
CREATE INDEX ix1_smq_content02 on smq_content (term_code);

CREATE TABLE llt_syn (
  llt_code integer not null,
  llt_s_kanji text not null,
  llt_s_jcurr text not null,
  llt_s_kana text,
  llt_s_kana1 text,
  llt_s_kana2 text,
  llt_s_code integer not null
);
CREATE INDEX ix1_llt_syn01 on llt_syn (llt_code);
CREATE INDEX ix1_llt_syn02 on llt_syn (llt_s_code);

