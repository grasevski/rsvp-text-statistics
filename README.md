rsvp-text-statistics
====================

Java commandline programs for calculating homophily statistics


Synopsis
--------
This repository consists of 2 main scripts `rsvpTextStatistics.sh` (for POSIX) and `rsvpTextStatistics.bat` (for Windows), as well as some auxiliary files and helper programs written in Java. The purpose of `rsvpTextStatistics.sh` is to gather statistics about the text features from the Oracle server and output them to a set of csv files.


Description
-----------
This is the basic procedure followed by `rsvpTextStatistics.sh`:

1. Initialize an sqlite database with the schema in `schema.sql`.
2. Compile the java programs.
3. Populate the sqlite database with the categories (music, movie etc) and genres (action, romance etc).
4. Run the regular queries on the Oracle database and store the results in the local sqlite database.
5. Print the query results to csv files.
6. Do steps 4 and 5 again with the age grouping queries.


Dependencies
------------
The following libraries and programs are required to run these scripts:

1. Oracle JDBC driver (included for your convenience)
2. SQLite3 JDBC driver (included for your convenience)
3. SQLite3 command line interface (windows version included for your convenience)


Installation
------------

1. Install dependencies
2. Download and extract this repository


Setup
-----
These scripts rely on the following Oracle tables:

* person - the user table, containing the following columns: userid, gender (134 for male or 135 for female), status, dob (date of birth)
* kiss - the kiss table, containing the following columns: kissid, initiatinguserid, targetuserid, positivereply
* personAge - the user table, with dob replaced with age group (0 for 18-29, 1 for 30-59, 2 for 60+).

These need not necessarily be tables, they can be views. An example schema can be found in `oracle.sql`. The names and userspaces of the above 3 tables can be configured in `config.properties`. Below is an example `config.properties`:

----
    person=nicholasg.users
    personAge=personAge
    kiss=rsvp_0612.sr_kiss
----

`config.properties` is simply a list of string substitution rules that are applied to the queries being used in the RsvpTextStatistics java program. If you open one of the input files for RsvpTextStatistics such as `queries.sql` you will see that all of the queries use person, personAge and kiss. These are substituted with the values given in `config.properties` using regex replace during run time when they are read by the RsvpTextStatistics program.

Additionally, the scripts rely on a set of feature tables/views. A feature table/view must contain the following columns:

1. `userid integer primary key references <person_table>(userid)`
2. A set of feature columns `f1 integer not null, f2 integer not null, ...` etc where each column has either '0' for dislike, '1' for neutral or '2' for like

The feature tables to be used must be specified in `genres.csv`, a csv file which contains one entry for each feature table, of the form:

----
    outputname,inputname,f1,f2,f3,...
----

where "outputname" is the name of the corresponding csv file to be produced, "inputname" is the name of the Oracle table to be queried, and f1,f2,... are the names of the feature columns in the Oracle table.


File Formats
------------
Six data files are used by `rsvpTextStatistics.sh` in the statistics generation process:

1. `config.properties` - Oracle table name definitions
2. `genres.csv` - Feature table definitions
3. `schema.sql` - The SQLite3 database schema used to store the intermediate results
4. `queries.sql` - The Oracle queries used to get the results
5. `queriesAge.sql` - The Oracle queries used to get the results, parameterised by age
6. `extractResults.sql` - The queries used to get the final statistics from the intermediate SQLite3 database

The first two were covered in the previous section, but care needs to be taken with the other four as well.

`schema.sql` is the database schema used for the SQLite3 database. It needs to be compatible with SQLite3 as well as all of the other sql files used.

`queries.sql` consists of a list of queries to be performed on the Oracle database. Each query should be separated by at least one newline and should be formatted in the following way:

----
    --queryname
    --col1name,col2name,col3name,...
    select ...
    ... etc
    ...;
----

`queriesAge.sql` is a similar file, except it contains all of the age-related queries instead.

`extractResults.sql` serves mainly as a sort of configuration file for the ResultExctractor java program:

1. The first line is a comment consisting of the column headings for the output.
2. The second line is a query that gets all of the categories.
3. The third line gets the names for each age (this is appended to the names of the output files e.g. `musicYoung.csv`, `musicMiddle.csv` etc).
4. The fourth line gets the results for a given category.
5. The fifth line gets the results for a given category, grouped into young, middle and old.

There is no reason why this couldnt be included in the source code for `ResultExtractor.java` rather than being stored externally.


Usage
-----
Once you have downloaded and extracted the repo, cd to it:

----
    cd /path/to/rsvp-text-statistics
----

Edit `config.properties` and `genres.csv` to reference your Oracle tables, then run `rsvpTextStatistics.bat` if on Windows, otherwise `rsvpTextStatistics.sh` if on POSIX. Then once this is complete, import the resultant csv files into MS Excel.


Resources
---------

* `TextStatistics3MonthNew.xlsx` - An MS Excel file containing the text statistics created by these scripts. The oracle tables used were `person`, `personAge`, `kiss3m`, `music_new`, `movie_new` and `sport_new`, all in the "nicholasg" userspace.
* `TextStatistics9MonthNew.xlsx` - An MS Excel file containing the text statistics created by these scripts. The oracle tables used were `person`, `personAge`, `kiss9m`, `music_new`, `movie_new` and `sport_new`, all in the "nicholasg" userspace.
* `TextStatistics3MonthOld.xlsx` - An MS Excel file containing the text statistics created by these scripts. The oracle tables used were `person`, `personAge`, `kiss3m`, `music_old`, `movie_old` and `sport_old`, all in the "nicholasg" userspace.
* `TextStatistics9MonthOld.xlsx` - An MS Excel file containing the text statistics created by these scripts. The oracle tables used were `person`, `personAge`, `kiss9m`, `music_old`, `movie_old` and `sport_old`, all in the "nicholasg" userspace.
