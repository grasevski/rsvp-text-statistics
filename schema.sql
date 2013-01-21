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

-- These basic tables are used to generate all combinations of age,
-- gender and feature, by using a simple cross product of the three
-- tables.
insert into age values (0, "young");
insert into age values (1, "middle");
insert into age values (2, "old");
insert into gender values (134);
insert into gender values (135);
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
  g1 integer references gender(id),
  g2 integer references gender(id),
  f1 integer references feature(id),
  f2 integer references feature(id),
  lhs2rhs integer not null,
  lhs integer not null,
  rhs integer not null,
  primary key (genre, g1, g2, f1, f2)
);

-- As above, grouped by the age groups of the sender and recipient,
-- respectively.
create table lhs2rhsAge (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  a1 integer references age(age),
  a2 integer references age(age),
  f1 integer references feature(id),
  f2 integer references feature(id),
  lhs2rhs integer not null,
  lhs integer not null,
  rhs integer not null,
  primary key (genre, g1, g2, a1, a2, f1, f2)
);

-- Number of kisses from lhs to rhs, grouped by the primary key.
create table lhs2rhs_t (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  f1 integer references feature(id),
  f2 integer references feature(id),
  lhs2rhs_t integer not null,
  lhs integer not null,
  rhs integer not null,
  primary key (genre, g1, g2, f1, f2)
);

-- As above, grouped by the age groups of the sender and recipient,
-- respectively.
create table lhs2rhs_tAge (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  a1 integer references age(age),
  a2 integer references age(age),
  f1 integer references feature(id),
  f2 integer references feature(id),
  lhs2rhs_t integer not null,
  lhs integer not null,
  rhs integer not null,
  primary key (genre, g1, g2, a1, a2, f1, f2)
);

-- Number of kisses from lhs to q, grouped by the primary key.
create table lhs2q (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  f1 integer references feature(id),
  lhs2q integer not null,
  lhs integer not null,
  q integer not null,
  primary key (genre, g1, g2, f1)
);

-- As above, grouped by the age groups of the sender and recipient,
-- respectively.
create table lhs2qAge (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  a1 integer references age(age),
  a2 integer references age(age),
  f1 integer references feature(id),
  lhs2q integer not null,
  lhs integer not null,
  q integer not null,
  primary key (genre, g1, g2, a1, a2, f1)
);

-- Number of kisses from lhs to q, grouped by the primary key.
create table lhs2q_t (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  f1 integer references feature(id),
  lhs2q_t integer not null,
  lhs integer not null,
  q integer not null,
  primary key (genre, g1, g2, f1)
);

-- As above, grouped by the age groups of the sender and recipient,
-- respectively.
create table lhs2q_tAge (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  a1 integer references age(age),
  a2 integer references age(age),
  f1 integer references feature(id),
  lhs2q_t integer not null,
  lhs integer not null,
  q integer not null,
  primary key (genre, g1, g2, a1, a2, f1)
);

-- Number of kisses from p to rhs, grouped by the primary key.
create table p2rhs (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  f2 integer references feature(id),
  p2rhs integer not null,
  p integer not null,
  rhs integer not null,
  primary key (genre, g1, g2, f2)
);

-- As above, grouped by the age groups of the sender and recipient,
-- respectively.
create table p2rhsAge (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  a1 integer references age(age),
  a2 integer references age(age),
  f2 integer references feature(id),
  p2rhs integer not null,
  p integer not null,
  rhs integer not null,
  primary key (genre, g1, g2, a1, a2, f2)
);

-- Number of kisses from p to rhs, grouped by the primary key.
create table p2rhs_t (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  f2 integer references feature(id),
  p2rhs_t integer not null,
  p integer not null,
  rhs integer not null,
  primary key (genre, g1, g2, f2)
);

-- As above, grouped by the age groups of the sender and recipient,
-- respectively.
create table p2rhs_tAge (
  genre integer references genre(id),
  g1 integer references gender(id),
  g2 integer references gender(id),
  a1 integer references age(age),
  a2 integer references age(age),
  f2 integer references feature(id),
  p2rhs_t integer not null,
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
select category, genre.id g, name, gender1, gender2, feature1, feature2, ifnull(lhs2rhs.lhs, 0), ifnull(lhs2rhs.rhs, 0), ifnull(lhs2rhs, 0), ifnull(lhs2rhs_t.lhs, 0), ifnull(lhs2rhs_t.rhs, 0), ifnull(lhs2rhs_t, 0), ifnull(lhs2q.lhs, 0), ifnull(lhs2q.q, 0), ifnull(lhs2q, 0), ifnull(lhs2q_t.lhs, 0), ifnull(lhs2q_t.q, 0), ifnull(lhs2q_t, 0), ifnull(p2rhs.p, 0), ifnull(p2rhs.rhs, 0), ifnull(p2rhs, 0), ifnull(p2rhs_t.p, 0), ifnull(p2rhs_t.rhs, 0), ifnull(p2rhs_t, 0), ifnull(lhs_pool.pool, 0), ifnull(rhs_pool.pool, 0)
from genre, combos
left join pool lhs_pool
on lhs_pool.genre=genre.id
  and lhs_pool.gender=gender1
  and lhs_pool.feature=feature1
left join pool rhs_pool
on rhs_pool.genre=genre.id
  and rhs_pool.gender=gender2
  and rhs_pool.feature=feature2
left join lhs2rhs
on lhs2rhs.genre=genre.id
  and lhs2rhs.g1=gender1
  and lhs2rhs.g2=gender2
  and lhs2rhs.f1=feature1
  and lhs2rhs.f2=feature2
left join lhs2rhs_t
on lhs2rhs_t.genre=genre.id
  and lhs2rhs_t.g1=gender1
  and lhs2rhs_t.g2=gender2
  and lhs2rhs_t.f1=feature1
  and lhs2rhs_t.f2=feature2
left join lhs2q
on lhs2q.genre=genre.id
  and lhs2q.g1=gender1
  and lhs2q.g2=gender2
  and lhs2q.f1=feature1
left join lhs2q_t
on lhs2q_t.genre=genre.id
  and lhs2q_t.g1=gender1
  and lhs2q_t.g2=gender2
  and lhs2q_t.f1=feature1
left join p2rhs
on p2rhs.genre=genre.id
  and p2rhs.g1=gender1
  and p2rhs.g2=gender2
  and p2rhs.f2=feature2
left join p2rhs_t
on p2rhs_t.genre=genre.id
  and p2rhs_t.g1=gender1
  and p2rhs_t.g2=gender2
  and p2rhs_t.f2=feature2;

-- As above, grouped by the age groups of the sender, where the
-- recipient age group is the same as the sender age group.
create view resultsAge as
select category, genre.id g, age, name, gender1, gender2, feature1, feature2, ifnull(lhs2rhsAge.lhs, 0), ifnull(lhs2rhsAge.rhs, 0), ifnull(lhs2rhs, 0), ifnull(lhs2rhs_tAge.lhs, 0), ifnull(lhs2rhs_tAge.rhs, 0), ifnull(lhs2rhs_t, 0), ifnull(lhs2qAge.lhs, 0), ifnull(lhs2qAge.q, 0), ifnull(lhs2q, 0), ifnull(lhs2q_tAge.lhs, 0), ifnull(lhs2q_tAge.q, 0), ifnull(lhs2q_t, 0), ifnull(p2rhsAge.p, 0), ifnull(p2rhsAge.rhs, 0), ifnull(p2rhs, 0), ifnull(p2rhs_tAge.p, 0), ifnull(p2rhs_tAge.rhs, 0), ifnull(p2rhs_t, 0), ifnull(lhs_pool.pool, 0), ifnull(rhs_pool.pool, 0)
from genre, age, combos
left join poolAge lhs_pool
on lhs_pool.genre=genre.id
  and lhs_pool.agegroup=age
  and lhs_pool.gender=gender1
  and lhs_pool.feature=feature1
left join poolAge rhs_pool
on rhs_pool.genre=genre.id
  and rhs_pool.agegroup=age
  and rhs_pool.gender=gender2
  and rhs_pool.feature=feature2
left join lhs2rhsAge
on lhs2rhsAge.genre=genre.id
  and lhs2rhsAge.a1=age
  and lhs2rhsAge.g1=gender1
  and lhs2rhsAge.g2=gender2
  and lhs2rhsAge.f1=feature1
  and lhs2rhsAge.f2=feature2
left join lhs2rhs_tAge
on lhs2rhs_tAge.genre=genre.id
  and lhs2rhs_tAge.a1 = age
  and lhs2rhs_tAge.g1=gender1
  and lhs2rhs_tAge.g2=gender2
  and lhs2rhs_tAge.f1=feature1
  and lhs2rhs_tAge.f2=feature2
left join lhs2qAge
on lhs2qAge.genre=genre.id
  and lhs2qAge.a1 = age
  and lhs2qAge.g1=gender1
  and lhs2qAge.g2=gender2
  and lhs2qAge.f1=feature1
left join lhs2q_tAge
on lhs2q_tAge.genre=genre.id
  and lhs2q_tAge.a1 = age
  and lhs2q_tAge.g1=gender1
  and lhs2q_tAge.g2=gender2
  and lhs2q_tAge.f1=feature1
left join p2rhsAge
on p2rhsAge.genre=genre.id
  and p2rhsAge.a1 = age
  and p2rhsAge.g1=gender1
  and p2rhsAge.g2=gender2
  and p2rhsAge.f2=feature2
left join p2rhs_tAge
on p2rhs_tAge.genre=genre.id
  and p2rhs_tAge.a1 = age
  and p2rhs_tAge.g1=gender1
  and p2rhs_tAge.g2=gender2
  and p2rhs_tAge.f2=feature2;
