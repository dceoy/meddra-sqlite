MedDRA-SQLite
=============

Package for Using MedDRA/J with SQLite3

Database Generation
-------------------

Creating Tables and Indexes

```sh
git clone https://github.com/d4i/meddra-sqlite.git
cd meddraj-sqlite
sqlite3 meddra.sqlite3 '.read schema_meddra.sql'
```

Import of MedDRA
----------------

Preparation of ASCII Data

```sh
mkdir data/
cd data/
cp /path/to/ASCII_FILE_DIRECTORY/*.asc .
nkf -w --overwrite *
sed -ie 's/\r$//g' *
```

MSSO files require to be delete "$" at the end of lines. (JMO files do not.)  
Use "gsed" command (GNU sed) instead of "sed" on MacOSX.

```sh
ls *.asc | grep -v _j | xargs sed -ie 's/\$$//g'
rm *.asce
cd ..
```

Import of ASCII Data

```sh
ls data/ | sed -e 's/\.asc//g' | xargs -I {} sqlite3 -separator $ meddra.sqlite3 '.import data/{}.asc {}'
```
