--pool
--gender,feature,pool
select gender, %2$s feature, count(*) pool
from person
join %1$s u on u.userid=person.userid
group by gender, %2$s;

--lhs2rhs
--g1,g2,f1,f2,lhs2rhs,lhs,rhs
select p1.gender g1, p2.gender g2, u1.%2$s f1, u2.%2$s f2, count(*) lhs2rhs, count(distinct initiatinguserid) lhs, count(distinct targetuserid) rhs
from kiss
join person p1 on p1.userid=initiatinguserid
join person p2 on p2.userid=targetuserid
join %1$s u1 on u1.userid=p1.userid
join %1$s u2 on u2.userid=p2.userid
group by p1.gender, p2.gender, u1.%2$s, u2.%2$s;

--lhs2rhs_t
--g1,g2,f1,f2,lhs2rhs_t,lhs,rhs
select p1.gender g1, p2.gender g2, u1.%2$s f1, u2.%2$s f2, count(*) lhs2rhs_t, count(distinct initiatinguserid) lhs, count(distinct targetuserid) rhs
from kiss
join person p1 on p1.userid=initiatinguserid
join person p2 on p2.userid=targetuserid
join %1$s u1 on u1.userid=p1.userid
join %1$s u2 on u2.userid=p2.userid
where positivereply = 1
group by p1.gender, p2.gender, u1.%2$s, u2.%2$s;

--lhs2q
--g1,g2,f1,lhs2q,lhs,q
select p1.gender g1, p2.gender g2, u1.%2$s f1, count(*) lhs2q, count(distinct initiatinguserid) lhs, count(distinct targetuserid) q
from kiss
join person p1 on p1.userid=initiatinguserid
join person p2 on p2.userid=targetuserid
join %1$s u1 on u1.userid=p1.userid
group by p1.gender, p2.gender, u1.%2$s;

--lhs2q_t
--g1,g2,f1,lhs2q_t,lhs,q
select p1.gender g1, p2.gender g2, u1.%2$s f1, count(*) lhs2q_t, count(distinct initiatinguserid) lhs, count(distinct targetuserid) q
from kiss
join person p1 on p1.userid=initiatinguserid
join person p2 on p2.userid=targetuserid
join %1$s u1 on u1.userid=p1.userid
where positivereply = 1
group by p1.gender, p2.gender, u1.%2$s;

--p2rhs
--g1,g2,f2,p2rhs,p,rhs
select p1.gender g1, p2.gender g2, u2.%2$s f2, count(*) p2rhs, count(distinct initiatinguserid) lhs, count(distinct targetuserid) q
from kiss
join person p1 on p1.userid=initiatinguserid
join person p2 on p2.userid=targetuserid
join %1$s u2 on u2.userid=p2.userid
group by p1.gender, p2.gender, u2.%2$s;

--p2rhs_t
--g1,g2,f2,p2rhs_t,p,rhs
select p1.gender g1, p2.gender g2, u2.%2$s f2, count(*) p2rhs_t, count(distinct initiatinguserid) lhs, count(distinct targetuserid) q
from kiss
join person p1 on p1.userid=initiatinguserid
join person p2 on p2.userid=targetuserid
join %1$s u2 on u2.userid=p2.userid
where positivereply = 1
group by p1.gender, p2.gender, u2.%2$s;
