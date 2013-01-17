--drop table kiss purge;
--drop table movie purge;
--drop table music purge;
--drop table sport purge;
--drop table person purge;
--drop table usertext purge;

create table person (
  userid integer primary key,
  gender integer not null,
  agegroup integer not null
);

create table kiss (
  kissid integer primary key,
  initiatinguserid integer not null references person(userid),
  targetuserid integer not null references person(userid),
  positivereply integer not null
);

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

insert into person
select userid, gender_prid, least(2, trunc(age/30)) from (
  select userid, gender_prid, trunc(months_between(sysdate, hdateofbirth)/12) age, status
  from rsvp_0612.ua_useraccount
) where status in (1, 2, 3);

insert into kiss
select sr_kiss.id, initiatinguserid, targetuserid, positivereply
from rsvp_0612.sr_kiss
join rsvp_0612.kissreplymessage k on k.id=replymessageid
where sr_kiss.created between '01feb12' and '01may12' and initiatinguserid in (select userid from person) and targetuserid in (select userid from person);

create table usertext as
select freetextid, userid, movies movie, music, sport
from rsvp_0612.up_freetext
where userid in (select userid from person);
