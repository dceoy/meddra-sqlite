MedDRA-SQLite
=============

Using MedDRA/J with SQLite3

Supported MedDRA version: 18.0

Setup
-----

1.  Install the required packages

    ```sh
    # Ubuntu
    $ sudo apt-get -y install sqlite3 nkf

    # CentOS
    $ sudo yum -y install sqlite nkf

    # Fedora
    $ sudo dnf -y install sqlite nkf

    # Homebrew on MacOSX
    $ brew install gnu-sed sqlite nkf
    ```

2.  Check out `meddra-sqlite`

    ```sh
    $ git clone https://github.com/dceoy/meddra-sqlite.git
    $ cd meddra-sqlite
    ```

Migration
---------

`create_db.sh` create an SQLite3 database in `db` directory and migrate data to it.  
Run `./create_db.sh --help` for the usage on a command.

```sh
# From a ZIP file
$ ./create_db.sh --zip /path/to/Med???j.zip

# From ASCII files (needed to copy to `ascii/`)
$ mkdir ascii/
$ cp /path/to/MEDDRA_ASCII/*.asc ascii/
$ ./create_db.sh --ascii ascii/
```
