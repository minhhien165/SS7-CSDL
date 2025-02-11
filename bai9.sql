create database bai9;

use bai9;

create table tblPhim (
  PhimID int primary key auto_increment,
  Ten_phim varchar(30),
  Loai_phim varchar(25),
  Thoi_gian int
);

create table tblPhong (
  PhongID int primary key auto_increment,
  Ten_phong varchar(20),
  Trang_thai tinyint
);

create table tblGhe (
  GheID int primary key auto_increment,
  PhongID int,
  So_ghe varchar(10)
);

create table tblVe (
  PhimID int,
  GheID int,
  Ngay_chieu datetime,
  Trang_thai varchar(20)
);

alter table tblGhe
add constraint FK_PhongID foreign key (PhongID)
references tblPhong(PhongID);

alter table tblVe
add constraint FK_PhimID foreign key (PhimID)
references tblPhim(PhimID);

alter table tblVe
add constraint FK_GheID foreign key (GheID)
references tblGhe(GheID);

insert into tblPhim (Ten_phim, Loai_phim, Thoi_gian) 
values 
('Em bé Hà Nôi', 'Tâm lý', 90),
('Nhiệm vụ bất khả thi', 'Hành động', 100),
('Dị nhân', 'Viễn tưởng', 90),
('Cuốn theo chiều gió', 'Tình cảm', 120);

insert into tblPhong (Ten_phong, Trang_thai)
values 
('Phòng chiếu 1', 1),
('Phòng chiếu 2', 1),
('Phòng chiếu 3', 0);

insert into tblGhe (PhongID, So_ghe)
values
(1, 'A3'),
(1, 'B5'),
(2, 'A7'),
(2, 'D1'),
(3, 'T2');

insert into tblVe (PhimID, GheID, Ngay_chieu, Trang_thai)
values
(1, 1, '2008-10-20', 'Đã bán'),
(1, 3, '2008-11-20', 'Đã bán'),
(1, 4, '2008-12-23', 'Đã bán'),
(2, 1, '2009-02-14', 'Đã bán'),
(3, 1, '2009-02-14', 'Đã bán'),
(2, 5, '2009-03-08', 'Chưa bán'),
(2, 3, '2009-03-08', 'Chưa bán');

-- 1
select
tblphim.Ten_phim,
tblphim.Thoi_gian 
from tblphim
order by tblphim.Thoi_gian asc;

-- 2
select
tblphim.Ten_phim
from tblphim 
order by tblphim.Thoi_gian desc limit 1;

-- 3
select
tblphim.Ten_phim
from tblphim 
order by tblphim.Thoi_gian asc limit 1;

-- 4
select
tblghe.So_ghe 
from tblghe
where tblghe.So_ghe like "A%";

-- 5
alter table tblphong
modify Trang_thai varchar(25);

-- 6
update tblphong
set Trang_thai = 
case 
when Trang_thai = 0 then  "Dang sua"
when Trang_thai = 1 then "Dan su dung"
when Trang_thai = null then  "Unknow"
end
where tblphong.PhongID > 0;

-- 7
select
tblphim.Ten_phim
from tblphim
where length(tblphim.Ten_phim) between 15 and 25;

-- 8
select
concat(Ten_Phong, " - ",Trang_Thai) as "Trang thai phong chieu"
from tblphong;

-- 10
alter table tblphim
add column Mo_ta varchar(255);

update tblphim
set Mo_ta = concat("Day la bo phim the loai", " ", tblphim.Loai_Phim)
where tblphim.PhimID > 0;
select *from tblphim;

update tblphim
set Mo_ta = replace(Mo_ta,'bo phim','film')
where tblphim.PhimID > 0;

select table_name, constraint_name
from information_schema.key_column_usage
where referenced_table_name is not null
and table_name in ('tblghe', 'tblve');

-- 11
alter table tblghe drop foreign key fk_phongid;
alter table tblve drop foreign key fk_phimid;
alter table tblve drop foreign key fk_gheid;

-- 12
delete from tblghe;

-- 13
select 
  Ngay_chieu as "Ngày giờ hiện chiếu",
  DATE_ADD(Ngay_chieu, interval 5000 minute) as "Ngày giờ chiếu + 5000 phút"
from tblVe;