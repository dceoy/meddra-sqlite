MedDRA-SQLite
=============

Using MedDRA/J with SQLite3

| MedDRA version | OS              | Depends         |
|:--------------:|:---------------:|:---------------:|
| 18.0           | Linux, Mac OS X | SQLite3, NKF    |

Preparation
-----------

```sh
$ git clone https://github.com/dceoy/meddra-sqlite.git
$ cd meddra-sqlite
```

Automated Migration
-------------------

From a ZIP file

```sh
$ ./migrate /path/to/Med???j.zip
```

From text files
(The ASCII files are needed to copy to `raw/`.)

```sh
$ mkdir raw/
$ cp /path/to/MEDDRA_ASCII/*.asc raw/
$ ./migrate
```

Manual Migration
----------------

MSSO files require to be delete `$` at the end of lines. (JMO files do not.)

```sh
$ mkdir raw/ seed/ db/
$ cp /path/to/MEDDRA_ASCII/*.asc raw/
$ awk '$1 == "-" { print $2 }' table_list.yml \
    | xargs -I {} bash -c 'nkf -w raw/{}.asc | tr -d \\r > seed/{}.utf8'
$ sed -ie 's/"/\\"/g' seed/*.utf8
$ ls seed/*.utf8 | grep -v _j.utf8 | xargs sed -ie 's/\$$//g'
$ rm seed/*.utf8e
$ cat schema_meddra.sql | sqlite3 db/meddra.sqlite3
$ awk '$1 == "-" { print $2 }' table_list.yml \
    | xargs -I {} sqlite3 -separator $ db/meddra.sqlite3 '.import seed/{}.utf8 {}'
$ sqlite3 db/meddra.sqlite3 '.dump' | gzip - > db/dump_meddra.sql.gz
```
