-- nicholasg.xxx_TEXT_FEATURES verification
define date_from=01feb12;
define date_to=01may12;
define feature_table=movie;
define feature=movie;
define kiss_table=rsvp_0612.sr_kiss;
define account_table=rsvp_0612.ua_useraccount;
define pos_reply_table=alfredk.positive_replies;
define u1_gender=(134);
define u2_gender=(135);
define u1_feature=(0,1,2);
define u2_feature=(0,1,2);

create table temp_feature as
select initiatinguserid, targetuserid, replymessageid, ac1.gender_prid u1_gender_prid, ac2.gender_prid u2_gender_prid
from &kiss_table
join &account_table ac1 on ac1.userid=initiatinguserid
join &account_table ac2 on ac2.userid=targetuserid
where created between '&date_from' and '&date_to';

select count(*) from &kiss_table
where created between '&date_from' and '&date_to';

-- U1 to U2 (LHS2RHS)
select &u1_gender, &u2_gender, &u1_feature, &u2_feature, * from (
  select count(*) LHS2RHS, count(distinct initiatinguserid) nLHS_LHS2RHS, count(distinct targetuserid) nRHS_LHS2RHS
  from temp_feature
  where u1_gender_prid in &u1_gender
    and u2_gender_prid in &u2_gender
    and initiatinguserid in (select userid from &feature_table where &feature in &u1_feature)
    and targetuserid in (select userid from &feature_table where &feature in &u2_feature)
), (
  select count(*) LHS2RHS_T, count(distinct initiatinguserid) nLHS_LHS2RHS_T, count(distinct targetuserid) nRHS_LHS2RHS_T
  from temp_feature
  where u1_gender_prid in &u1_gender
    and u2_gender_prid in &u2_gender
    and initiatinguserid in (select userid from &feature_table where &feature in &u1_feature)
    and targetuserid in (select userid from &feature_table wher &feature in &u2_feature)
    and replymessageid in (select replymessageid from &pos_reply_table)
);

-- U1 to all (LHS2Q)
select &u1_gender, &u2_gender, &u1_feature, &u2_feature, * from (
  select count(*) LHS2Q, count(distinct initiatinguserid) nLHS_LHS2Q, count(distinct targetuserid) nQ_LHS2Q
  from temp_feature
  where u1_gender_prid in &u1_gender
    and u2_gender_prid in &u2_gender
    and initiatinguserid in (select userid from &feature_table where &feature in &u1_feature)
), (
  select count(*) LHS2Q_T, count(distinct initiatinguserid) nLHS_LHS2Q_T, count(distinct targetuserid) nQ_LHS2Q_T
  from temp_feature
  where u1_gender_prid in &u1_gender
    and u2_gender_prid in &u2_gender
    and initiatinguserid in (select userid from &feature_table where &feature in &u1_feature)
    and replymessageid in (select replymessageid from &pos_reply_table)
);

-- all to U2 (P2RHS)
select &u1_gender, &u2_gender, &u1_feature, &u2_feature, * from (
  select count(*) P2RHS, count(distinct initiatinguserid) nP_P2RHS, count(distinct targetuserid) nRHS_P2RHS
  from temp_feature
  where u1_gender_prid in &u1_gender
    and u2_gender_prid in &u2_gender
    and targetuserid in (select userid from &feature_table where &feature in &u2_feature)
), (
  select count(*) P2RHS, count(distinct initiatinguserid) nP_P2RHS, count(distinct targetuserid) nRHS_P2RHS
  from temp_feature
  where u1_gender_prid in &u1_gender
    and u2_gender_prid in &u2_gender
    and targetuserid in (select userid from &feature_table where &feature in &u2_feature)
    and replymessageid in (select replymessageid from &pos_reply_table)
);

-- U1, U2 in user pool
select &u1_gender, &u2_gender, &u1_feature, &u2_feature, * from (
  select count(*) nLHS_POOL from &account_table
  where gender_prid in &u1_gender and status in (1, 2, 3)
    and userid in (select userid from &feature_table where &feature in &u1_feature)
), (select count(*) nRHS_POOL from &account_table
  where gender_prid in &u2_gender and status in (1, 2, 3)
    and userid in (select userid from &feature_table where &feature in &u2_feature)
);

drop table temp_feature purge;
