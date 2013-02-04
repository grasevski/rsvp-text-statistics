#!/bin/sh

# Rsvp text statistics
#
# This batch script serves as a basic use case of the programs in
# this directory. A new sqlite database is initialized with the
# provided schema and it is then populated by the PopulateDb
# program, which reads the categories and genres from standard
# input. The main program (RsvpTextStatistics) is then run to
# query the oracle database and store the results in the sqlite
# file. These results are then printed to csv files by running
# ResultExtractor.

results=results.db
genres=genres.csv
config=config.properties

read -p Username: user
read -sp Password: pass
echo 'Initializing results db...'
rm -f $results && sqlite3 $results <schema.sql
echo 'Compiling java programs...'
~/java/bin/javac *.java
echo 'Inserting categories and genres into results db...'
~/java/bin/java -cp 'sqlite-jdbc-3.7.2.jar;.' PopulateDb $results <$genres
echo 'Gathering regular query results...'
~/java/bin/java -cp 'ojdbc6.jar;sqlite-jdbc-3.7.2.jar;.' RsvpTextStatistics $user $pass $config $results $genres <queries.sql
echo 'Printing regular query results to csv files...'
~/java/bin/java -cp 'sqlite-jdbc-3.7.2.jar;.' ResultExtractor $results <extractResults.sql
echo 'Gathering query results with age groupings...'
~/java/bin/java -cp 'ojdbc6.jar;sqlite-jdbc-3.7.2.jar;.' RsvpTextStatistics $user $pass $config $results $genres <queriesAge.sql
echo 'Printing query results with age groupings to csv files...'
~/java/bin/java -cp 'sqlite-jdbc-3.7.2.jar;.' ResultExtractor $results <extractResults.sql
