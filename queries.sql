--pool
--gender,feature,pool
select gender, %2$s feature, count(*) pool
from person
join %1$s on id=person
group by gender, %2$s;

--lhs2rhs
--positivereply,g1,g2,f1,f2,lhs2rhs
select positivereply, p1.gender g1, p2.gender g2, u1.%2$s f1, u2.%2$s f2, count(*) lhs2rhs
from kiss
join person p1 on p1.id=initiatinguserid
join person p2 on p2.id=targetuserid
join %1$s u1 on u1.person=p1.id
join %1$s u2 on u2.person=p2.id
group by positivereply, p1.gender, p2.gender, u1.%2$s, u2.%2$s;

--lhs_rhs
--g1,g2,f1,f2,lhs,rhs
select p1.gender g1, p2.gender g2, u1.%2$s f1, u2.%2$s f2, count(distinct initiatinguserid) lhs, count(distinct targetuserid) rhs
from kiss
join person p1 on p1.id=initiatinguserid
join person p2 on p2.id=targetuserid
join %1$s u1 on u1.person=p1.id
join %1$s u2 on u2.person=p2.id
group by p1.gender, p2.gender, u1.%2$s, u2.%2$s;

--lhs_rhs_t
--g1,g2,f1,f2,lhs,rhs
select p1.gender g1, p2.gender g2, u1.%2$s f1, u2.%2$s f2, count(distinct initiatinguserid) lhs, count(distinct targetuserid) rhs
from kiss
join person p1 on p1.id=initiatinguserid
join person p2 on p2.id=targetuserid
join %1$s u1 on u1.person=p1.id
join %1$s u2 on u2.person=p2.id
where positivereply = 1
group by p1.gender, p2.gender, u1.%2$s, u2.%2$s;

--lhs_q
--g1,g2,f1,lhs,q
select p1.gender g1, p2.gender g2, u1.%2$s f1, count(distinct initiatinguserid) lhs, count(distinct targetuserid) q
from kiss
join person p1 on p1.id=initiatinguserid
join person p2 on p2.id=targetuserid
join %1$s u1 on u1.person=p1.id
group by p1.gender, p2.gender, u1.%2$s;

--lhs_q_t
--g1,g2,f1,lhs,q
select p1.gender g1, p2.gender g2, u1.%2$s f1, count(distinct initiatinguserid) lhs, count(distinct targetuserid) q
from kiss
join person p1 on p1.id=initiatinguserid
join person p2 on p2.id=targetuserid
join %1$s u1 on u1.person=p1.id
where positivereply = 1
group by p1.gender, p2.gender, u1.%2$s;

--p_rhs
--g1,g2,f2,p,rhs
select p1.gender g1, p2.gender g2, u2.%2$s f2, count(distinct initiatinguserid) p, count(distinct targetuserid) rhs
from kiss
join person p1 on p1.id=initiatinguserid
join person p2 on p2.id=targetuserid
join %1$s u2 on u2.person=p2.id
group by p1.gender, p2.gender, u2.%2$s;

--p_rhs_t
--g1,g2,f2,p,rhs
select p1.gender g1, p2.gender g2, u2.%2$s f2, count(distinct initiatinguserid) p, count(distinct targetuserid) rhs
from kiss
join person p1 on p1.id=initiatinguserid
join person p2 on p2.id=targetuserid
join %1$s u2 on u2.person=p2.id
where positivereply = 1
group by p1.gender, p2.gender, u2.%2$s;
