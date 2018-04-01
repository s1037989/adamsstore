-- 1 up
create table if not exists orders (
  id           serial primary key,
  stripe_token varchar(32),
  timestamp    timestamp with time zone default current_timestamp,
  email        varchar(255),
  name         varchar(255),
  cartsubtotal numeric,
  tax          numeric,
  carttotal    numeric,
  cart         json,
  stripe       json
);

-- 1 down
drop table if exists orders;

-- 2 up
alter table orders add column store varchar(255);
alter table orders add column address varchar(255);
alter table orders add column city varchar(255);
alter table orders add column state varchar(30);
alter table orders add column zip varchar(10);

-- 2 down
alter table orders drop column if exists store;
alter table orders drop column if exists address;
alter table orders drop column if exists city;
alter table orders drop column if exists state;
alter table orders drop column if exists zip;

-- 3 up
alter table orders add column processed boolean;

-- 3 down
alter table orders drop column if exists processed;
