# CBR Travel Suggest
Project in the course COMPSCI760 Datamining and Machine Learning at University of Auckland, semester 2 2016. The aim of the project was to implement a case-based reasoner for dealing with a given base of travel cases.

The program has been tested on a Mac OS X v10.11.6 with PostgreSQL v9.5.1.

### Quick installation
Install PostgreSQL by using e.g. Homebrew:
```
$ brew install postgres
```
Start server program postgres:
```
$ pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
```
Create and restore database:
```
$ createdb travel
$ psql travel < traveldb.sql
```

### Running the program
Make sure the server is running (check with `$ pg_ctl -D /usr/local/var/postgres`) and then start the app, *CBR Travel Suggest*.

### Other
For more details about implementation and how to edit code, read the report.
