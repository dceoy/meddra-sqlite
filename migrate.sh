#!/usr/bin/env bash

set -ue

MDR_SCHEMA_SQL="schema_meddra.sql"
MDR_DB="db/meddra.sqlite3"
MDR_DB_DUMP_GZ="db/dump_meddra.sql.gz"
MDR_TABLES=$(awk '$1 == "-" { print $2 }' table_list.yml)

echo "> checking required system commands."
which sed
which awk
which nkf
which sqlite3

echo "> creating the database."
if [ ! -f ${MDR_DB} ]; then
  [[ -d db/ ]] || mkdir db/
  cat ${MDR_SCHEMA_SQL} | sqlite3 ${MDR_DB}
  sqlite3 ${MDR_DB} '.tables'
fi

echo "> migrating the MedDRA data..."
if ls ascii/*.asc > /dev/null; then
  [[ -d seed/ ]] || mkdir seed/
  for t in ${MDR_TABLES[@]}; do
    echo ${t}
    nkf -w ascii/${t}.asc | tr -d '\r' > seed/${t}.utf8           # to UTF-8
    sed -ie 's/"/\\"/g' seed/${t}.utf8                            # escape double quates
    [[ ${t} =~ _j$ ]] || sed -ie 's/\$$//g' seed/${t}.utf8        # modify separaters (only MSSO files)
    rm seed/${t}.utf8e                                            # clean up
    sqlite3 -separator $ ${MDR_DB} ".import seed/${t}.utf8 ${t}"  # migrate
  done
else
  echo "Put MedDRA ASCII files at ./ascii directory!"
  exit
fi

echo "> dumping the database..."
sqlite3 ${MDR_DB} '.dump' | gzip - > ${MDR_DB_DUMP_GZ}

echo "complete."
