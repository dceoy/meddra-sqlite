#!/usr/bin/env bash
#
# Usage:  ./create_db.sh [--zip file]
#         ./create_db.sh [--ascii directory]
#         ./create_db.sh [ -h | --help | -v | --version ]
#
# Description:
#   Create an SQLite3 database with MedDRA/J
#
# Options:
#   -h, --help          Print usage
#   -v, --version       Print version information and quit
#   --zip               Migrate data from a ZIP file
#   --ascii             Migrate data from ASCII files in a directory

set -e

if [[ "${1}" = '--debug' ]]; then
  set -x
  shift 1
fi

SCRIPT_NAME='create_db.sh'
SCRIPT_VERSION='1.1.0'
MDR_SCHEMA_SQL='./schema_meddra.sql'
DB_DIR='./db'
DB_SEED_DIR="${DB_DIR}/seed"
MDR_DB="${DB_DIR}/meddra.sqlite3"
MDR_DB_DUMP_GZ="${DB_DIR}/dump_meddra.sql.gz"

[[ -d "${DB_SEED_DIR}" ]] || mkdir -p ${DB_SEED_DIR}

function print_version {
  echo "${SCRIPT_NAME}: ${SCRIPT_VERSION}"
}

function print_usage {
  ${SED} -ne '
    1,2d
    /^#/!q
    s/^#$/# /
    s/^# //p
  ' ${SCRIPT_NAME}
}

function abort {
  {
    if [[ ${#} -eq 0 ]]; then
      cat -
    else
      echo "${SCRIPT_NAME}: ${*}"
    fi
  } >&2
  exit 1
}

case "${OSTYPE}" in
  'darwin'* )
    SED='gsed'
    ;;
  'linux'* )
    SED='sed'
    ;;
  * )
    abort 'not supported OS type'
    ;;
esac

case "${1}" in
  '' )
    {
      print_version && echo && print_usage
    } | abort
    ;;
  '-v' | '--version' )
    print_version
    exit 0
    ;;
  '-h' | '--help' )
    print_usage
    exit 0
    ;;
  '--zip' )
    [[ -n "${2}" ]] || abort 'missing a target file'
    ASCII_DIR='./ascii'
    echo '> extracting files.'
    unzip ${2} -d ${ASCII_DIR}
    echo
    ;;
  '--ascii' )
    [[ -n "${2}" ]] || abort 'missing a target directory'
    ASCII_DIR="$(dirname ${2})/$(basename ${2})"
    ;;
  * )
    abort "invalid argument \`${1}\`"
    ;;
esac

echo '> checking the commands.'
echo '[Sed]' && which ${SED}
echo '[NKF]' && which nkf
echo '[SQLite3]' && which sqlite3
echo

echo '> creating the database.'
echo "${MDR_SCHEMA_SQL} => ${MDR_DB}"
if [[ -f "${MDR_DB}" ]]; then
  abort "\`${MDR_DB}\` already exists."
else
  sqlite3 ${MDR_DB} ".read ${MDR_SCHEMA_SQL}"
fi

echo '> migrating the MedDRA data...'
for t in $(${SED} -ne 's/^CREATE TABLE \([a-z_]\+\) (/\1/gp' ${MDR_SCHEMA_SQL}); do
  asc="${ASCII_DIR}/${t}.asc"
  seed="${DB_SEED_DIR}/${t}.utf8"
  [[ -f "${asc}" ]] || continue
  echo "${asc} => ${seed} => ${MDR_DB} (table: \`${t}\`)"
  nkf -w ${asc} | tr -d '\r' | ${SED} -e 's/"/\\"/g' > ${seed}              # to UTF-8
  [[ ! "${t}" =~ _j$ ]] && ${SED} -ie 's/\$$//g' ${seed} && rm "${seed}e"   # modify separaters (only MSSO files)
  sqlite3 -separator '$' ${MDR_DB} ".import ${seed} ${t}"                   # migrate data
done
echo

echo '> dumping the database...'
echo "${MDR_DB} => ${MDR_DB_DUMP_GZ}"
sqlite3 ${MDR_DB} '.dump' | gzip - > ${MDR_DB_DUMP_GZ}
echo

echo 'done.'
