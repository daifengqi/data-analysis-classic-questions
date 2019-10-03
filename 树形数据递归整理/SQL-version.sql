use data-analysis
create table address(ID char(10) primary key,Name char(10) not null,ParentId char(10) not null);


insert into address values('1','北京市','0');
insert into address values('2','山东省','0');
insert into address values('3','昌平区','1');
insert into address values('4','海淀区','1');
insert into address values('5','沙河镇','3');
insert into address values('6','马池口镇','3');
insert into address values('7','中关村','4');
insert into address values('8','上地','4');
insert into address values('9','烟台市','2');
insert into address values('10','青岛市','2');
insert into address values('11','牟平区','9');
insert into address values('12','芝罘区','9');
insert into address values('13','即墨区','10');
insert into address values('14','城阳','10');

select t1.Name '一级地名',t2.Name '二级地名',t3.Name '三级地名'
from
(select Name,ID
from address 
where ParentId=0)t1
left outer join
(select Name,ParentId,ID
from address
where ParentId in(1,2))t2
on t2.ParentId=t1.ID
left outer join 
(select Name,ParentId
from address 
where ParentId in(3,4,9,10))t3
on t3.ParentId=t2.ID;