MedDRA-SQLite
=============

Using MedDRA/J with SQLite3 on Linux or Mac OS X

Supported MedDRA version: 18.0

Preparation
-----------

```sh
$ git clone https://github.com/dceoy/meddra-sqlite.git
$ cd meddra-sqlite
$ cp /path/to/MEDDRA_ASCII_DIRECTORY/*.asc ascii/
```

Automated Migration
-------------------

```sh
$ ./migrate
```

Manual Migration
----------------

MSSO files require to be delete `$` at the end of lines. (JMO files do not.)

```sh
$ mkdir seed/ db/
$ awk '$1 == "-" { print $2 }' ascii_file_list.yml \
    | xargs -I {} bash -c 'nkf -w ascii/{}.asc | tr -d \\r > seed/{}.utf8'
$ sed -ie 's/"/\\"/g' seed/*.utf8
$ ls seed/*.utf8 | grep -v _j.utf8 | xargs sed -ie 's/\$$//g'
$ rm seed/*.utf8e
$ cat schema_meddra.sql | sqlite3 db/meddra.sqlite3
$ awk '$1 == "-" { print $2 }' ascii_file_list.yml \
    | xargs -I {} sqlite3 -separator $ db/meddra.sqlite3 '.import seed/{}.utf8 {}'
$ sqlite3 db/meddra.sqlite3 '.dump' | gzip - > db/dump_meddra.sql.gz
```
