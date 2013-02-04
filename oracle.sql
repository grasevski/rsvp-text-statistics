-- Delete tables and create new ones.
drop table kiss purge;
drop table movie purge;
drop table music purge;
drop table sport purge;
drop table person purge;
drop table usertext purge;

-- An RSVP users relevant fields. Userid, gender (134 is male, 135
-- is female), status (1, 2 and 3 are the only active statuses) and
-- agegroup (0 is 18-29, 1 is 30-59, and 2 is 60+).
create table person (
  userid integer primary key,
  gender integer not null,
  status integer not null,
  agegroup integer not null
);

-- A simplified kiss table, including only a primary key, sender
-- id, receiver id and the reply type (0 is negative, 1 is
-- positive, 2 is neutral)
create table kiss (
  kissid integer primary key,
  initiatinguserid integer not null references person(userid),
  targetuserid integer not null references person(userid),
  positivereply integer not null
);

-- Movie features table, outputted from the rsvp-text-analysis
-- scripts.
create table movie (
  userid integer primary key references person(userid),
  movie integer not null,
  action integer not null, 
  adventure integer not null, 
  animation integer not null, 
  children integer not null, 
  comedy integer not null, 
  crime integer not null, 
  documentary integer not null, 
  drama integer not null, 
  fantasy integer not null, 
  filmnoir integer not null, 
  horror integer not null, 
  musical integer not null, 
  mystery integer not null, 
  romance integer not null, 
  scifi integer not null, 
  thriller integer not null, 
  war integer not null, 
  western integer not null
);

-- Music features table, outputted from the rsvp-text-analysis
-- scripts.
create table music (
  userid integer primary key references person(userid),
  music integer not null,
  blues integer not null,
  classical integer not null,
  country integer not null,
  folk integer not null,
  jazz integer not null,
  misc integer not null,
  newage integer not null,
  reggae integer not null,
  rock integer not null,
  soundtrack integer not null
);

-- Sport features table, outputted from the rsvp-text-analysis
-- scripts.
create table sport (
  userid integer primary key references person(userid),
  sport integer not null,
  afl integer not null, 
  baseball integer not null, 
  basketball integer not null, 
  bowling integer not null, 
  boxing integer not null, 
  carracing integer not null, 
  cartracing integer not null, 
  cooking integer not null, 
  cricket integer not null, 
  cycling integer not null, 
  dancing integer not null, 
  fishing integer not null, 
  fitness integer not null, 
  flying integer not null, 
  football integer not null, 
  footy integer not null, 
  golf integer not null, 
  horse integer not null, 
  indoor integer not null, 
  lawnbowls integer not null, 
  league integer not null, 
  martialarts integer not null, 
  motorsports integer not null, 
  music integer not null, 
  nfl integer not null, 
  outdoor integer not null, 
  photography integer not null, 
  racquetsport integer not null, 
  rodeo integer not null, 
  rugby_union integer not null, 
  shooting integer not null, 
  soccer integer not null, 
  water integer not null, 
  winter integer not null
);

-- Populate the person table with all users.
insert into person
select userid, gender_prid, status, least(2, trunc(age/30)) from (
  select userid, gender_prid, trunc(months_between('01may12', hdateofbirth)/12) age, status
  from rsvp_0612.ua_useraccount
);

-- Populate the kiss table with all kisses.
insert into kiss
select sr_kiss.id, initiatinguserid, targetuserid, nvl(positivereply, 2)
from rsvp_0612.sr_kiss
left join rsvp_0612.kissreplymessage k on k.id=replymessageid
where sr_kiss.created between '01feb12' and '01may12'
  and initiatinguserid in (select userid from person)
  and targetuserid in (select userid from person);

-- Get all of the relevant free text fields and store them in one
-- table, for easy extraction to csv files.
create table usertext as
select freetextid, userid, movies movie, music, sport
from rsvp_0612.up_freetext
where userid in (select userid from person);
