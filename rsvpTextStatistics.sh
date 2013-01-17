#!/bin/sh

rm -f results.db && sqlite3 results.db <schema.sql
~/java/bin/javac *.java
~/java/bin/java -cp 'sqlite-jdbc-3.7.2.jar;.' PopulateDb results.db <genres.txt
~/java/bin/java -cp 'ojdbc6.jar;sqlite-jdbc-3.7.2.jar;.' RsvpTextStatistics results.db genres.txt <queries.sql
~/java/bin/java -cp 'sqlite-jdbc-3.7.2.jar;.' ResultExtractor results.db <extractResults.sql
~/java/bin/java -cp 'ojdbc6.jar;sqlite-jdbc-3.7.2.jar;.' RsvpTextStatistics results.db genres.txt <queriesAge.sql
~/java/bin/java -cp 'sqlite-jdbc-3.7.2.jar;.' ResultExtractor results.db <extractResults.sql
