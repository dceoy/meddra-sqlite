MedDRA-SQLite
=============

Using MedDRA/J with SQLite3

Database Generation
-------------------

Creating Tables and Indexes

```sh
$ git clone https://github.com/dceoy/meddra-sqlite.git
$ cd meddra-sqlite
$ sqlite3 meddra.sqlite3 '.read schema_meddra.sql'
```

Import of MedDRA
----------------

Preparation of ASCII Data

```sh
$ mkdir data/
$ awk '$1 == "-" { print $2 }' ascii_file_list.yml | xargs -I {} cp /path/to/ASCII_FILE_DIRECTORY/{}.asc data/
$ cd data/
$ nkf -w --overwrite *
$ sed -ie 's/\r$//g' *
$ sed -ie 's/"/\\"/g' *
```

MSSO files require to be delete "$" at the end of lines. (JMO files do not.)  
Use "gsed" command (GNU sed) instead of "sed" on MacOSX.

```sh
$ ls *.asc | grep -v _j | xargs sed -ie 's/\$$//g'
$ rm *e
$ cd ..
```

Import of ASCII Data

```sh
$ awk '$1 == "-" { print $2 }' ascii_file_list.yml | xargs -I {} sqlite3 -separator $ meddra.sqlite3 '.import data/{}.asc {}'
```

Dump the Database

```sh
$ sqlite3 meddra.sqlite3 '.dump' | gzip -c > dump_meddra.sql.gz
```
