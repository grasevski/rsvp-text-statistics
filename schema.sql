-- List of categories, i.e. music, movie, sport etc.
create table category (
  id integer primary key,
  name varchar(255) unique not null
);

-- List of genres, grouped by category.
create table genre (
  id integer primary key,
  category integer not null references category(id),
  name varchar(255) not null
);

-- Age groups - young (0), middle (1), old (2)
create table age (
  age integer primary key,
  description varchar(255) unique not null
);

create table gender (id integer primary key);
create table feature (id integer primary key);

insert into age values (0, "young");
insert into age values (1, "middle");
insert into age values (2, "old");
insert into gender values (0);
insert into gender values (1);
insert into feature values (0);
insert into feature values (1);
insert into feature values (2);

-- Total number of users of a given gender who feel a certain way
-- (dislike, neutral, like) about a certain genre.
create table pool (
  genre integer references genre(id),
  gender integer references gender(id),
  feature integer references feature(id),
  pool integer not null,
  primary key (genre, gender, feature)
);

-- As above, grouped by age group.
create table poolAge (
  genre integer references genre(id),
  gender integer references gender(id),
  agegroup integer references age(age),
  feature integer references feature(id),
  pool integer not null,
  primary key (genre, gender, agegroup, feature)
);

-- Number of kisses from lhs to rhs, grouped by the primary key.
create table lhs2rhs (
  genre integer references genre(id),
  positivereply integer,
  g1 integer references gender(id),
  g2 integer references gender(id),
  f1 integer references feature(id),
  f2 integer references feature(id),
  lhs2rhs integer not null,
  primary key (genre, positivereply, g1, g2, f1, f2)
);

-- As above, grouped by the age groups of the sender and recipient,
-- respectively.
create table lhs2rhsAge (
  genre integer references genre(id),
  positivereply integer,
  g1 integer references gender(id),
  g2 integer references gender(id),
  a1 integer references age(age),
  a2 integer references age(age),
  f1 integer references feature(id),
  f2 integer references feature(id),
  lhs2rhs integer not null,
  primary key (genre, positivereply, g1, g2, a1, a2, f1, f2)
);

-- Number of distinct senders and recipients with sender of gender
-- g1 and taste f1, recipient of gender g2 and taste f2, for a
-- given genre.
create table lhs_rhs (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  f1 integer references feature(id),
  f2 integer references feature(id),
  lhs integer not null,
  rhs integer not null,
  primary key (genre, g1, g2, f1, f2)
);

-- As above, grouped by the age groups of the sender and recipient,
-- respectively.
create table lhs_rhsAge (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  a1 integer references age(age),
  a2 integer references age(age),
  f1 integer references feature(id),
  f2 integer references feature(id),
  lhs integer not null,
  rhs integer not null,
  primary key (genre, g1, g2, a1, a2, f1, f2)
);

-- Same as lhs_rhs, except only counting successful kisses.
create table lhs_rhs_t (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  f1 integer references feature(id),
  f2 integer references feature(id),
  lhs integer not null,
  rhs integer not null,
  primary key (genre, g1, g2, f1, f2)
);

-- As above, grouped by the age groups of the sender and recipient,
-- respectively.
create table lhs_rhs_tAge (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  a1 integer references age(age),
  a2 integer references age(age),
  f1 integer references feature(id),
  f2 integer references feature(id),
  lhs integer not null,
  rhs integer not null,
  primary key (genre, g1, g2, a1, a2, f1, f2)
);

-- Number of distinct users in lhs and number of distinct users in
-- q.
create table lhs_q (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  f1 integer references feature(id),
  lhs integer not null,
  q integer not null,
  primary key (genre, g1, g2, f1)
);

-- As above, grouped by the age groups of the sender and recipient,
-- respectively.
create table lhs_qAge (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  a1 integer references age(age),
  a2 integer references age(age),
  f1 integer references feature(id),
  lhs integer not null,
  q integer not null,
  primary key (genre, g1, g2, a1, a2, f1)
);

-- Same as lhs_q, except only counting successful kisses.
create table lhs_q_t (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  f1 integer references feature(id),
  lhs integer not null,
  q integer not null,
  primary key (genre, g1, g2, f1)
);

-- As above, grouped by the age groups of the sender and recipient,
-- respectively.
create table lhs_q_tAge (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  a1 integer references age(age),
  a2 integer references age(age),
  f1 integer references feature(id),
  lhs integer not null,
  q integer not null,
  primary key (genre, g1, g2, a1, a2, f1)
);

-- Number of distinct users in p and number of distinct users in
-- rhs.
create table p_rhs (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  f2 integer references feature(id),
  p integer not null,
  rhs integer not null,
  primary key (genre, g1, g2, f2)
);

-- As above, grouped by the age groups of the sender and recipient,
-- respectively.
create table p_rhsAge (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  a1 integer references age(age),
  a2 integer references age(age),
  f2 integer references feature(id),
  p integer not null,
  rhs integer not null,
  primary key (genre, g1, g2, a1, a2, f2)
);

-- Same as lhs_q, except only counting successful kisses.
create table p_rhs_t (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  f2 integer references feature(id),
  p integer not null,
  rhs integer not null,
  primary key (genre, g1, g2, f2)
);

-- As above, grouped by the age groups of the sender and recipient,
-- respectively.
create table p_rhs_tAge (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  a1 integer references age(age),
  a2 integer references age(age),
  f2 integer references feature(id),
  p integer not null,
  rhs integer not null,
  primary key (genre, g1, g2, a1, a2, f2)
);

-- All combinations of sender gender, recipient gender, sender
-- taste, and recipient taste.
create view combos as
select g1.id gender1, g2.id gender2, f1.id feature1, f2.id feature2
from gender g1, gender g2, feature f1, feature f2;

-- A table of all required statistics for the spreadsheet. Select a
-- specific category and order the results to get a specific sheet
-- which can then be outputted to csv and subsequently imported
-- into an excel worksheet.
create view results as
select category, genre.id g, name, gender1, gender2, feature1, feature2, ifnull(lhs_rhs.lhs, 0), ifnull(lhs_rhs.rhs, 0), ifnull(l2r, 0), ifnull(lhs_rhs_t.lhs, 0), ifnull(lhs_rhs_t.rhs, 0), ifnull(lhs2rhs_t, 0), ifnull(lhs_q.lhs, 0), ifnull(lhs_q.q, 0), ifnull(lhs2q, 0), ifnull(lhs_q_t.lhs, 0), ifnull(lhs_q_t.q, 0), ifnull(lhs2q_t, 0), ifnull(p_rhs.p, 0), ifnull(p_rhs.rhs, 0), ifnull(p2rhs, 0), ifnull(p_rhs_t.p, 0), ifnull(p_rhs_t.rhs, 0), ifnull(p2rhs_t, 0), ifnull(lhs_pool.pool, 0), ifnull(rhs_pool.pool, 0)
from genre, combos
left join pool lhs_pool
on lhs_pool.genre=genre.id and lhs_pool.gender=gender1 and lhs_pool.feature=feature1
left join pool rhs_pool
on rhs_pool.genre=genre.id and rhs_pool.gender=gender2 and rhs_pool.feature=feature2
left join (
  select genre, g1, g2, f1, f2, sum(lhs2rhs) l2r
  from lhs2rhs group by genre, g1, g2, f1, f2
) l2r
on l2r.genre=genre.id and l2r.g1=gender1 and l2r.g2=gender2 and l2r.f1=feature1 and l2r.f2=feature2
left join (
  select genre, g1, g2, f1, f2, sum(lhs2rhs) lhs2rhs_t from lhs2rhs
  where positivereply = 1 group by genre, g1, g2, f1, f2
) lhs2rhs_t
on lhs2rhs_t.genre=genre.id and lhs2rhs_t.g1=gender1 and lhs2rhs_t.g2=gender2 and lhs2rhs_t.f1=feature1 and lhs2rhs_t.f2=feature2
left join (
  select genre, g1, g2, f1, sum(lhs2rhs) lhs2q
  from lhs2rhs group by genre, g1, g2, f1
) lhs2q
on lhs2q.genre=genre.id and lhs2q.g1=gender1 and lhs2q.g2=gender2 and lhs2q.f1=feature1
left join (
  select genre, g1, g2, f1, sum(lhs2rhs) lhs2q_t from lhs2rhs
  where positivereply = 1 group by genre, g1, g2, f1
) lhs2q_t
on lhs2q_t.genre=genre.id and lhs2q_t.g1=gender1 and lhs2q_t.g2=gender2 and lhs2q_t.f1=feature1
left join (
  select genre, g1, g2, f2, sum(lhs2rhs) p2rhs
  from lhs2rhs group by genre, g1, g2, f2
) p2rhs
on p2rhs.genre=genre.id and p2rhs.g1=gender1 and p2rhs.g2=gender2 and p2rhs.f2=feature2
left join (
  select genre, g1, g2, f2, sum(lhs2rhs) p2rhs_t from lhs2rhs
  where positivereply = 1 group by genre, g1, g2, f2
) p2rhs_t
on p2rhs_t.genre=genre.id and p2rhs_t.g1=gender1 and p2rhs_t.g2=gender2 and p2rhs_t.f2=feature2
left join lhs_rhs
on lhs_rhs.genre=genre.id and lhs_rhs.g1=gender1 and lhs_rhs.g2=gender2 and lhs_rhs.f1=feature1 and lhs_rhs.f2=feature2
left join lhs_rhs_t
on lhs_rhs_t.genre=genre.id and lhs_rhs_t.g1=gender1 and lhs_rhs_t.g2=gender2 and lhs_rhs_t.f1=feature1 and lhs_rhs_t.f2=feature2
left join lhs_q
on lhs_q.genre=genre.id and lhs_q.g1=gender1 and lhs_q.g2=gender2 and lhs_q.f1=feature1
left join lhs_q_t
on lhs_q_t.genre=genre.id and lhs_q_t.g1=gender1 and lhs_q_t.g2=gender2 and lhs_q_t.f1=feature1
left join p_rhs
on p_rhs.genre=genre.id and p_rhs.g1=gender1 and p_rhs.g2=gender2 and p_rhs.f2=feature2
left join p_rhs_t
on p_rhs_t.genre=genre.id and p_rhs_t.g1=gender1 and p_rhs_t.g2=gender2 and p_rhs_t.f2=feature2;

-- As above, grouped by the age groups of the sender, where the
-- recipient age group is the same as the sender age group.
create view resultsAge as
select category, genre.id g, age, name, gender1, gender2, feature1, feature2, ifnull(lhs_rhsAge.lhs, 0), ifnull(lhs_rhsAge.rhs, 0), ifnull(l2r, 0), ifnull(lhs_rhs_tAge.lhs, 0), ifnull(lhs_rhs_tAge.rhs, 0), ifnull(lhs2rhs_t, 0), ifnull(lhs_qAge.lhs, 0), ifnull(lhs_qAge.q, 0), ifnull(lhs2q, 0), ifnull(lhs_q_tAge.lhs, 0), ifnull(lhs_q_tAge.q, 0), ifnull(lhs2q_t, 0), ifnull(p_rhsAge.p, 0), ifnull(p_rhsAge.rhs, 0), ifnull(p2rhs, 0), ifnull(p_rhs_tAge.p, 0), ifnull(p_rhs_tAge.rhs, 0), ifnull(p2rhs_t, 0), ifnull(lhs_pool.pool, 0), ifnull(rhs_pool.pool, 0)
from genre, age, combos
left join poolAge lhs_pool
on lhs_pool.genre=genre.id and lhs_pool.agegroup=age and lhs_pool.gender=gender1 and lhs_pool.feature=feature1
left join poolAge rhs_pool
on rhs_pool.genre=genre.id and rhs_pool.agegroup=age and rhs_pool.gender=gender2 and rhs_pool.feature=feature2
left join (
  select genre, a1, g1, g2, f1, f2, sum(lhs2rhs) l2r
  from lhs2rhsAge where a1 = a2 group by genre, a1, g1, g2, f1, f2
) l2r
on l2r.genre=genre.id and l2r.a1=age and l2r.g1=gender1 and l2r.g2=gender2 and l2r.f1=feature1 and l2r.f2=feature2
left join (
  select genre, a1, g1, g2, f1, f2, sum(lhs2rhs) lhs2rhs_t
  from lhs2rhsAge where positivereply = 1 and a1 = a2
  group by genre, a1, g1, g2, f1, f2
) lhs2rhs_t
on lhs2rhs_t.genre=genre.id and lhs2rhs_t.a1 = age and lhs2rhs_t.g1=gender1 and lhs2rhs_t.g2=gender2 and lhs2rhs_t.f1=feature1 and lhs2rhs_t.f2=feature2
left join (
  select genre, a1, g1, g2, f1, sum(lhs2rhs) lhs2q
  from lhs2rhsAge where a1 = a2 group by genre, g1, g2, f1
) lhs2q
on lhs2q.genre=genre.id and lhs2q.a1 = age and lhs2q.g1=gender1 and lhs2q.g2=gender2 and lhs2q.f1=feature1
left join (
  select genre, a1, g1, g2, f1, sum(lhs2rhs) lhs2q_t from lhs2rhsAge
  where positivereply = 1 and a1 = a2 group by genre, g1, g2, f1
) lhs2q_t
on lhs2q_t.genre=genre.id and lhs2q_t.a1 = age and lhs2q_t.g1=gender1 and lhs2q_t.g2=gender2 and lhs2q_t.f1=feature1
left join (
  select genre, a1, g1, g2, f2, sum(lhs2rhs) p2rhs
  from lhs2rhsAge where a1 = a2 group by genre, g1, g2, f2
) p2rhs
on p2rhs.genre=genre.id and p2rhs.a1 = age and p2rhs.g1=gender1 and p2rhs.g2=gender2 and p2rhs.f2=feature2
left join (
  select genre, a1, g1, g2, f2, sum(lhs2rhs) p2rhs_t from lhs2rhsAge
  where positivereply = 1 and a1 = a2 group by genre, g1, g2, f2
) p2rhs_t
on p2rhs_t.genre=genre.id and p2rhs_t.a1 = age and p2rhs_t.g1=gender1 and p2rhs_t.g2=gender2 and p2rhs_t.f2=feature2
left join lhs_rhsAge
on lhs_rhsAge.genre=genre.id and lhs_rhsAge.a1 = age and lhs_rhsAge.g1=gender1 and lhs_rhsAge.g2=gender2 and lhs_rhsAge.f1=feature1 and lhs_rhsAge.f2=feature2
left join lhs_rhs_tAge
on lhs_rhs_tAge.genre=genre.id and lhs_rhs_tAge.a1 = age and lhs_rhs_tAge.g1=gender1 and lhs_rhs_tAge.g2=gender2 and lhs_rhs_tAge.f1=feature1 and lhs_rhs_tAge.f2=feature2
left join lhs_qAge
on lhs_qAge.genre=genre.id and lhs_qAge.a1 = age and lhs_qAge.g1=gender1 and lhs_qAge.g2=gender2 and lhs_qAge.f1=feature1
left join lhs_q_tAge
on lhs_q_tAge.genre=genre.id and lhs_q_tAge.a1 = age and lhs_q_tAge.g1=gender1 and lhs_q_tAge.g2=gender2 and lhs_q_tAge.f1=feature1
left join p_rhsAge
on p_rhsAge.genre=genre.id and p_rhsAge.a1 = age and p_rhsAge.g1=gender1 and p_rhsAge.g2=gender2 and p_rhsAge.f2=feature2
left join p_rhs_tAge
on p_rhs_tAge.genre=genre.id and p_rhs_tAge.a1 = age and p_rhs_tAge.g1=gender1 and p_rhs_tAge.g2=gender2 and p_rhs_tAge.f2=feature2
where lhs_rhsAge.a1 = lhs_rhsAge.a2 and lhs_rhs_tAge.a1 = lhs_rhs_tAge.a2 and lhs_qAge.a1 = lhs_qAge.a2 and lhs_q_tAge.a1 = lhs_q_tAge.a2 and p_rhsAge.a1 = p_rhsAge.a2 and p_rhs_tAge.a1 = p_rhs_tAge.a2;
