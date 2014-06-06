-- MedDRA
-- sql script to create tables and indexes

CREATE TABLE llt (
  llt_code SMALLINT NOT NULL,
  llt_name VARCHAR(100) NOT NULL,
  pt_code SMALLINT,
  llt_whoart_code VARCHAR(7),
  llt_harts_code SMALLINT,
  llt_costart_sym VARCHAR(21),
  llt_icd9_code VARCHAR(8),
  llt_icd9cm_code VARCHAR(8),
  llt_icd10_code VARCHAR(8),
  llt_currency VARCHAR(1),
  llt_jart_code VARCHAR(6)
);
CREATE INDEX ix1_pt_llt01 ON llt (llt_code);
CREATE INDEX ix1_pt_llt02 ON llt (llt_name);
CREATE INDEX ix1_pt_llt03 ON llt (pt_code);

CREATE TABLE pt (
  pt_code SMALLINT NOT NULL,
  pt_name VARCHAR(100) NOT NULL,
  null_field VARCHAR(1),
  pt_soc_code SMALLINT,
  pt_whoart_code VARCHAR(7),
  pt_harts_code SMALLINT,
  pt_costart_sym VARCHAR(21),
  pt_icd9_code VARCHAR(8),
  pt_icd9cm_code VARCHAR(8),
  pt_icd10_code VARCHAR(8),
  pt_jart_code VARCHAR(6)
);
CREATE INDEX ix1_pt01 ON pt (pt_code);
CREATE INDEX ix1_pt02 ON pt (pt_name);
CREATE INDEX ix1_pt03 ON pt (pt_soc_code);

CREATE TABLE hlt (
  hlt_code SMALLINT NOT NULL,
  hlt_name VARCHAR(100),
  hlt_whoart_code VARCHAR(7),
  hlt_harts_code SMALLINT,
  hlt_costart_sym VARCHAR(21),
  hlt_icd9_code VARCHAR(8),
  hlt_icd9cm_code VARCHAR(8),
  hlt_icd10_code VARCHAR(8),
  hlt_jart_code VARCHAR(6)
);
CREATE INDEX ix1_hlt01 ON hlt (hlt_code);
CREATE INDEX ix1_hlt02 ON hlt (hlt_name);

CREATE TABLE hlt_pt (
  hlt_code SMALLINT NOT NULL,
  pt_code SMALLINT NOT NULL
);
CREATE INDEX ix1_hlt_pt01 ON hlt_pt (hlt_code, pt_code);
CREATE INDEX ix1_hlt_pt02 ON hlt_pt (pt_code, hlt_code);

CREATE TABLE hlgt (
  hlgt_code SMALLINT NOT NULL,
  hlgt_name VARCHAR(100),
  hlgt_whoart_code VARCHAR(7),
  hlgt_harts_code SMALLINT,
  hlgt_costart_sym VARCHAR(21),
  hlgt_icd9_code VARCHAR(8),
  hlgt_icd9cm_code VARCHAR(8),
  hlgt_icd10_code VARCHAR(8),
  hlgt_jart_code VARCHAR(6)
);
CREATE INDEX ix1_hlgt01 ON hlgt (hlgt_code);
CREATE INDEX ix1_hlgt02 ON hlgt (hlgt_name);

CREATE TABLE hlgt_hlt (
  hlgt_code SMALLINT NOT NULL,
  hlt_code SMALLINT NOT NULL
);
CREATE INDEX ix1_hlgt_hlt01 ON hlgt_hlt (hlgt_code, hlt_code);
CREATE INDEX ix1_hlgt_hlt02 ON hlgt_hlt (hlt_code, hlgt_code);

CREATE TABLE soc (
  soc_code SMALLINT NOT NULL,
  soc_name VARCHAR(100),
  soc_abbrev VARCHAR(5) NOT NULL,
  soc_whoart_code VARCHAR(7),
  soc_harts_code SMALLINT,
  soc_costart_sym VARCHAR(21),
  soc_icd9_code VARCHAR(8),
  soc_icd9cm_code VARCHAR(8),
  soc_icd10_code VARCHAR(8),
  soc_jart_code VARCHAR(6)
);
CREATE INDEX ix1_soc01 ON soc (soc_code);
CREATE INDEX ix1_soc02 ON soc (soc_name);

CREATE TABLE soc_hlgt (
  soc_code SMALLINT NOT NULL,
  hlgt_code SMALLINT NOT NULL
);
CREATE INDEX ix1_soc_hlgt01 ON soc_hlgt (soc_code, hlgt_code);
CREATE INDEX ix1_soc_hlgt02 ON soc_hlgt (soc_code);
CREATE INDEX ix1_soc_hlgt03 ON soc_hlgt (hlgt_code, soc_code);

CREATE TABLE mdhier (
  pt_code SMALLINT NOT NULL,
  hlt_code SMALLINT NOT NULL,
  hlgt_code SMALLINT NOT NULL,
  soc_code SMALLINT NOT NULL,
  pt_name VARCHAR(100) NOT NULL,
  hlt_name VARCHAR(100) NOT NULL,
  hlgt_name VARCHAR(100) NOT NULL,
  soc_name VARCHAR(100) NOT NULL,
  soc_abbrev VARCHAR(5) NOT NULL,
  null_field VARCHAR(1),
  pt_soc_code SMALLINT,
  primary_soc_fg VARCHAR(1)
);
CREATE INDEX ix1_md_hier01 ON mdhier (pt_code);
CREATE INDEX ix1_md_hier02 ON mdhier (hlt_code);
CREATE INDEX ix1_md_hier03 ON mdhier (hlgt_code);
CREATE INDEX ix1_md_hier04 ON mdhier (soc_code);
CREATE INDEX ix1_md_hier05 ON mdhier (pt_soc_code);

CREATE TABLE intl_ord (
  intl_ord_code SMALLINT NOT NULL,
  soc_code SMALLINT NOT NULL
);
CREATE INDEX ix1_intl_ord01 ON intl_ord (intl_ord_code, soc_code);

CREATE TABLE llt_j (
  llt_code SMALLINT NOT NULL,
  llt_kanji VARCHAR(140),
  llt_jcurr VARCHAR(1),
  llt_kana VARCHAR(100),
  llt_kana1 VARCHAR(100),
  llt_kana2 VARCHAR(100)
);
CREATE INDEX ix1_pt_llt_j01 ON llt_j (llt_code);
CREATE INDEX ix1_pt_llt_j02 ON llt_j (llt_kanji);
CREATE INDEX ix1_pt_llt_j03 ON llt_j (llt_kana);
CREATE INDEX ix1_pt_llt_j04 ON llt_j (llt_kana1);
CREATE INDEX ix1_pt_llt_j05 ON llt_j (llt_kana2);

CREATE TABLE pt_j (
  pt_code SMALLINT NOT NULL,
  pt_kanji VARCHAR(120),
  pt_kana VARCHAR(120),
  pt_kana1 VARCHAR(120),
  pt_kana2 VARCHAR(120)
);
CREATE INDEX ix1_pt_j01 ON pt_j (pt_code);
CREATE INDEX ix1_pt_j02 ON pt_j (pt_kanji);
CREATE INDEX ix1_pt_j03 ON pt_j (pt_kana);
CREATE INDEX ix1_pt_j04 ON pt_j (pt_kana1);
CREATE INDEX ix1_pt_j05 ON pt_j (pt_kana2);

CREATE TABLE hlt_j (
  hlt_code SMALLINT NOT NULL,
  hlt_kanji VARCHAR(120),
  hlt_kana VARCHAR(120),
  hlt_kana1 VARCHAR(120),
  hlt_kana2 VARCHAR(120)
);
CREATE INDEX ix1_hlt_j01 ON hlt_j (hlt_code);
CREATE INDEX ix1_hlt_j02 ON hlt_j (hlt_kanji);
CREATE INDEX ix1_hlt_j03 ON hlt_j (hlt_kana);
CREATE INDEX ix1_hlt_j04 ON hlt_j (hlt_kana1);
CREATE INDEX ix1_hlt_j05 ON hlt_j (hlt_kana2);

CREATE TABLE hlgt_j (
  hlgt_code SMALLINT NOT NULL,
  hlgt_kanji VARCHAR(120),
  hlgt_kana VARCHAR(120),
  hlgt_kana1 VARCHAR(120),
  hlgt_kana2 VARCHAR(120)
);
CREATE INDEX ix1_hlgt_j01 ON hlgt_j (hlgt_code);
CREATE INDEX ix1_hlgt_j02 ON hlgt_j (hlgt_kanji);
CREATE INDEX ix1_hlgt_j03 ON hlgt_j (hlgt_kana);
CREATE INDEX ix1_hlgt_j04 ON hlgt_j (hlgt_kana1);
CREATE INDEX ix1_hlgt_j05 ON hlgt_j (hlgt_kana2);

CREATE TABLE soc_j (
  soc_code SMALLINT NOT NULL,
  soc_kanji VARCHAR(120),
  soc_order SMALLINT,
  soc_kana VARCHAR(120),
  soc_kana1 VARCHAR(120),
  soc_kana2 VARCHAR(120)
);
CREATE INDEX ix1_soc_j01 ON soc_j (soc_code);
CREATE INDEX ix1_soc_j02 ON soc_j (soc_kanji);
CREATE INDEX ix1_soc_j03 ON soc_j (soc_kana);
CREATE INDEX ix1_soc_j04 ON soc_j (soc_kana1);
CREATE INDEX ix1_soc_j05 ON soc_j (soc_kana2);

CREATE TABLE smq_list (
  smq_code SMALLINT NOT NULL,
  smq_name VARCHAR(100) NOT NULL,
  smq_level SMALLINT NOT NULL,
  smq_description VARCHAR(2100) NOT NULL,
  smq_source VARCHAR(2200),
  smq_note VARCHAR(1900),
  MedDRA_version VARCHAR(5) NOT NULL,
  status VARCHAR(1) NOT NULL,
  smq_algorithm VARCHAR(50) NOT NULL
);
CREATE INDEX ix1_smq_list01 ON smq_list (smq_code);

CREATE TABLE smq_list_j (
  smq_code SMALLINT NOT NULL,
  smq_kanji VARCHAR(120) NOT NULL,
  smq_desc_kanji VARCHAR(1000) NOT NULL
);
CREATE INDEX ix1_smq_list_j01 ON smq_list_j (smq_code);

CREATE TABLE smq_content (
  smq_code SMALLINT NOT NULL,
  term_code SMALLINT NOT NULL,
  term_level SMALLINT NOT NULL,
  term_scope SMALLINT NOT NULL,
  term_category VARCHAR(1) NOT NULL,
  term_weight SMALLINT NOT NULL,
  term_status VARCHAR(1) NOT NULL,
  term_addition_version VARCHAR(5) NOT NULL,
  term_last_modified_version VARCHAR(5) NOT NULL
);
CREATE INDEX ix1_smq_content01 ON smq_content (smq_code);
CREATE INDEX ix1_smq_content02 ON smq_content (term_code);

CREATE TABLE llt_syn (
  llt_code SMALLINT NOT NULL,
  llt_s_kanji VARCHAR(140) NOT NULL,
  llt_s_jcurr VARCHAR(1) NOT NULL,
  llt_s_kana VARCHAR(200),
  llt_s_kana1 VARCHAR(200),
  llt_s_kana2 VARCHAR(200),
  llt_s_code SMALLINT NOT NULL
);
CREATE INDEX ix1_llt_syn01 ON llt_syn (llt_code);
CREATE INDEX ix1_llt_syn02 ON llt_syn (llt_s_code);

