--poolAge
--gender,agegroup,feature,pool
select gender, agegroup, %2$s feature, count(*) pool
from (
  select id, gender, least(2, trunc(age/30)) agegroup from (
    select id, gender, trunc(months_between(sysdate, dob)/12) age
    from person
  ) where age >= 18
) p
join %1$s on id=person
group by gender, agegroup, %2$s;

--lhs2rhsAge
--positivereply,g1,g2,a1,a2,f1,f2,lhs2rhs
select positivereply, p1.gender g1, p2.gender g2, p1.agegroup a1, p2.agegroup a2, u1.%2$s f1, u2.%2$s f2, count(*) lhs2rhs
from kiss
join (
  select id, gender, least(2, trunc(age/30)) agegroup from (
    select id, gender, trunc(months_between(sysdate, dob)/12) age
    from person
  ) where age >= 18
) p1 on p1.id=initiatinguserid
join (
  select id, gender, least(2, trunc(age/30)) agegroup from (
    select id, gender, trunc(months_between(sysdate, dob)/12) age
    from person
  ) where age >= 18
) p2 on p2.id=targetuserid
join %1$s u1 on u1.person=p1.id
join %1$s u2 on u2.person=p2.id
group by positivereply, p1.gender, p2.gender, p1.agegroup, p2.agegroup, u1.%2$s, u2.%2$s;

--lhs_rhsAge
--g1,g2,a1,a2,f1,f2,lhs,rhs
select p1.gender g1, p2.gender g2, p1.agegroup a1, p2.agegroup a2, u1.%2$s f1, u2.%2$s f2, count(distinct initiatinguserid) lhs, count(distinct targetuserid) rhs
from kiss
join (
  select id, gender, least(2, trunc(age/30)) agegroup from (
    select id, gender, trunc(months_between(sysdate, dob)/12) age
    from person
  ) where age >= 18
) p1 on p1.id=initiatinguserid
join (
  select id, gender, least(2, trunc(age/30)) agegroup from (
    select id, gender, trunc(months_between(sysdate, dob)/12) age
    from person
  ) where age >= 18
) p2 on p2.id=targetuserid
join %1$s u1 on u1.person=p1.id
join %1$s u2 on u2.person=p2.id
group by p1.gender, p2.gender, p1.agegroup, p2.agegroup, u1.%2$s, u2.%2$s;

--lhs_rhs_tAge
--g1,g2,a1,a2,f1,f2,lhs,rhs
select p1.gender g1, p2.gender g2, p1.agegroup a1, p2.agegroup a2, u1.%2$s f1, u2.%2$s f2, count(distinct initiatinguserid) lhs, count(distinct targetuserid) rhs
from kiss
join (
  select id, gender, least(2, trunc(age/30)) agegroup from (
    select id, gender, trunc(months_between(sysdate, dob)/12) age
    from person
  ) where age >= 18
) p1 on p1.id=initiatinguserid
join (
  select id, gender, least(2, trunc(age/30)) agegroup from (
    select id, gender, trunc(months_between(sysdate, dob)/12) age
    from person
  ) where age >= 18
) p2 on p2.id=targetuserid
join %1$s u1 on u1.person=p1.id
join %1$s u2 on u2.person=p2.id
where positivereply = 1
group by p1.gender, p2.gender, p1.agegroup, p2.agegroup, u1.%2$s, u2.%2$s;

--lhs_qAge
--g1,g2,a1,a2,f1,lhs,q
select p1.gender g1, p2.gender g2, p1.agegroup a1, p2.agegroup a2, u1.%2$s f1, count(distinct initiatinguserid) lhs, count(distinct targetuserid) q
from kiss
join (
  select id, gender, least(2, trunc(age/30)) agegroup from (
    select id, gender, trunc(months_between(sysdate, dob)/12) age
    from person
  ) where age >= 18
) p1 on p1.id=initiatinguserid
join (
  select id, gender, least(2, trunc(age/30)) agegroup from (
    select id, gender, trunc(months_between(sysdate, dob)/12) age
    from person
  ) where age >= 18
) p2 on p2.id=targetuserid
join %1$s u1 on u1.person=p1.id
group by p1.gender, p2.gender, p1.agegroup, p2.agegroup, u1.%2$s;

--lhs_q_tAge
--g1,g2,a1,a2,f1,lhs,q
select p1.gender g1, p2.gender g2, p1.agegroup a1, p2.agegroup a2, u1.%2$s f1, count(distinct initiatinguserid) lhs, count(distinct targetuserid) q
from kiss
join (
  select id, gender, least(2, trunc(age/30)) agegroup from (
    select id, gender, trunc(months_between(sysdate, dob)/12) age
    from person
  ) where age >= 18
) p1 on p1.id=initiatinguserid
join (
  select id, gender, least(2, trunc(age/30)) agegroup from (
    select id, gender, trunc(months_between(sysdate, dob)/12) age
    from person
  ) where age >= 18
) p2 on p2.id=targetuserid
join %1$s u1 on u1.person=p1.id
where positivereply = 1
group by p1.gender, p2.gender, p1.agegroup, p2.agegroup, u1.%2$s;

--p_rhsAge
--g1,g2,a1,a2,f2,p,rhs
select p1.gender g1, p2.gender g2, p1.agegroup a1, p2.agegroup a2, u2.%2$s f2, count(distinct initiatinguserid) p, count(distinct targetuserid) rhs
from kiss
join (
  select id, gender, least(2, trunc(age/30)) agegroup from (
    select id, gender, trunc(months_between(sysdate, dob)/12) age
    from person
  ) where age >= 18
) p1 on p1.id=initiatinguserid
join (
  select id, gender, least(2, trunc(age/30)) agegroup from (
    select id, gender, trunc(months_between(sysdate, dob)/12) age
    from person
  ) where age >= 18
) p2 on p2.id=targetuserid
join %1$s u2 on u2.person=p2.id
group by p1.gender, p2.gender, p1.agegroup, p2.agegroup, u2.%2$s;

--p_rhs_tAge
--g1,g2,a1,a2,f2,p,rhs
select p1.gender g1, p2.gender g2, p1.agegroup a1, p2.agegroup a2, u2.%2$s f2, count(distinct initiatinguserid) p, count(distinct targetuserid) rhs
from kiss
join (
  select id, gender, least(2, trunc(age/30)) agegroup from (
    select id, gender, trunc(months_between(sysdate, dob)/12) age
    from person
  ) where age >= 18
) p1 on p1.id=initiatinguserid
join (
  select id, gender, least(2, trunc(age/30)) agegroup from (
    select id, gender, trunc(months_between(sysdate, dob)/12) age
    from person
  ) where age >= 18
) p2 on p2.id=targetuserid
join %1$s u2 on u2.person=p2.id
where positivereply = 1
group by p1.gender, p2.gender, p1.agegroup, p2.agegroup, u2.%2$s;
