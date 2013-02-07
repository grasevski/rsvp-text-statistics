rem Rsvp text statistics

rem This is the windows batch file equivalent of
rem rsvpTextStatistics.sh

set results=results.db
set genres=genres.csv
set config=config.properties

set cc=javac
set j=java

set user=%1
set pass=%2

echo Initializing results db...
rm -f $results && sqlite3 %results% <schema.sql
echo Compiling java programs...
%javac% *.java
echo Inserting categories and genres into results db...
%java% -cp "sqlite-jdbc-3.7.2.jar;." PopulateDb %results% <%genres%
echo Gathering regular query results...
%java% -cp "ojdbc6.jar;sqlite-jdbc-3.7.2.jar;." RsvpTextStatistics %user% %pass% %config% %results% %genres% <queries.sql
echo Printing regular query results to csv files...
%java% -cp "sqlite-jdbc-3.7.2.jar;." ResultExtractor %results% <extractResults.sql
echo Gathering query results with age groupings...
%java% -cp "ojdbc6.jar;sqlite-jdbc-3.7.2.jar;." RsvpTextStatistics %user% %pass% %config% %results% %genres% <queriesAge.sql
echo Printing query results with age groupings to csv files...
%java% -cp "sqlite-jdbc-3.7.2.jar;." ResultExtractor %results% <extractResults.sql
