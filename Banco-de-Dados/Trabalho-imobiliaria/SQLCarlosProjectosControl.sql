
CREATE DATABASE dbCarlosProjectsControl;
use dbCarlosProjectsControl;

CREATE TABLE tbContratante(
CodContratante int not null primary key identity (1,1),
Name NVARCHAR (50) not null,
Endereco NVARCHAR (40) not null,
City NVARCHAR (30) not null,
Estado NVARCHAR (2) not null,
Telephone NUMERIC (11,0) not null,
Email NVARCHAR (40) not null);


CREATE TABLE tbConsultor(
CodConsultor int not null primary key identity (1,1),
NameConsultor nvarchar (50) not null,
CPF nvarchar (11) not null unique,
Specialization nvarchar (11) not null);


CREATE TABLE tbProjeto(
CodProjeto int not null primary key identity (1,1),
DateStart date not null,
DateEnd date not null,
Valor decimal(9,2) not null,
CodContratante int not null foreign key references tbContratante(CodContratante));


CREATE TABLE tbConsultorProjeto(
CodConsultorProjeto int not null primary key identity (1,1),
CodProjeto int not null foreign key references tbProjeto(CodProjeto),
CodConsultor int not null foreign key references tbConsultor(CodConsultor),
HoursWorked numeric (5,0) not null,
FunctionPerformed varchar(30) not null);


------- aula

alter table tbConsultor add EmailConsultor nvarchar(40);

alter table tbContratante add Region varchar(15);

alter table tbConsultor add TelephoneConsultor numeric (11,0) not null;

exec sp_rename 'tbContratante.Name','NameContratante';

exec sp_rename 'tbContratante.Telephone','TelephoneContratante';

exec sp_rename 'tbContratante.Email','EmailContratante';

alter table tbConsultor alter column Specialization text;

alter table tbContratante drop column Region;

--Letra K - registros abaixo:

INSERT INTO tbContratante 
VALUES
('Ultramedical','Rua Gandu','S?o Paulo','SP',11996692027,'gmail@gmail.com'),
('Cassems','Av Otaviano dos santos','Iguatemi','MS','67989998867','suporte@hotmail.com'),
('Unimed','Rua Pra?a Joaquim','Belo Horizonte','MG',04133164340,'info@yahoo.com');
GO

INSERT INTO tbConsultor
VALUES
('Carlos','03999978147','Engenheiro','carlos@gmail.com','67996692027'),
('Marcos','12347891011','Gestao','marcos@hotmail','67992884050'),
('Jean','12131415999','Fisica','jean@yahoo.com','66998980103');
GO

INSERT INTO tbProjeto
VALUES
('01/01/2300','02/02/2300',10,1),
('01/05/2310','10/07/2300',12,2),
('08/01/2320','07/03/2300',15,3);
GO

INSERT INTO tbConsultorProjeto
VALUES
(1,1,6,'segurity'),
(2,2,8,'professor'),
(2,3,8,'director');
GO

--   Quest?o 3

select * from tbConsultorProjeto;
select CodContratante, NameContratante from tbContratante;
select * from tbProjeto where DateEnd = '02/02/2300';
select * from tbConsultor where CPF = 12345678999;
select * from tbContratante where NameContratante = 'Animal';
select * from tbContratante where NameContratante LIKE 'P%';
select * from tbContratante where TelephoneContratante = 789;
select * from tbProjeto where Valor >=10;
select * from tbProjeto where Valor <=12;
select * from tbProjeto where Valor <>12;
select CodProjeto from tbProjeto where Valor = 10 or Valor = 15;
select CodContratante from tbContratante where TelephoneContratante = 456 AND EmailContratante = 'yahoo';
select DateEnd from tbProjeto where Valor = 10 AND CodContratante = 3;
select * from tbConsultorProjeto where CodConsultor >=1 and HoursWorked <=8;
select * from tbConsultorProjeto where CodProjeto IN (1,2,3);
select * from tbConsultorProjeto where FunctionPerformed in ('segurity','professor');
select * from tbConsultorProjeto where FunctionPerformed not in ('segurity','professor');
select * from tbConsultorProjeto where HoursWorked is not null;
select * from tbConsultorProjeto where HoursWorked is null;


-- Aula 21.03.19




select sum (Valor) from tbProjeto;
select avg (Valor) from tbProjeto;
select count (DateStart) from tbProjeto;
select max (Valor) from tbProjeto;
select min (Valor) from tbProjeto;
select avg (Valor) from tbProjeto where Valor = 1;


select avg (Valor), DateEnd from tbProjeto group by DateEnd;


select count (*) NameContratante , City from tbContratante group by City;



select avg (Valor), CodContratante from tbProjeto group by CodContratante having avg (Valor) > 10;

select count (*) , CodContratante from tbProjeto group by CodContratante having count (*) >=15;

select avg (Valor), CodContratente from tbProjeto group by CodContratante having avg (Valor) > 12;


select * from tbConsultorProjeto order by HoursWorked desc;
select * from tbConsultorProjeto order by HoursWorked asc;
select * from tbConsultorProjeto order by HoursWorked;
select * from tbConsultorProjeto order by FunctionPerformed asc;


select all Specialization from tbConsultor;

--nao repete informa??es, quais pre?os existem:
select distinct Estado from tbContratante;

select concat ('The Project ', CodProjeto ,' End in ',DateEnd ) as [Deadline Projetos] from tbProjeto;




-- Aula 28/03


--constraints

alter table tbContratante
add constraint defa_city
default 'Campo Grande' for City;

alter table tbContratante
add constraint defa_state
default 'MS' for Estado;

alter table tbConsultorProjeto
add constraint CheckHoursWorked
check (HoursWorked >=1);

alter table tbConsultor
add Sex nvarchar (1) check (sex in ('M','F'));

alter table tbConsultor
add constraint uniquecpf unique (CPF);



-- VIEW

CREATE VIEW QueryConsultor
as select NameConsultor, Specialization
from tbConsultor;


--select * from QueryConsultor;

CREATE VIEW QueryProjetos
as select count (CodProjeto) CodProduto
from tbProjeto;

--select * from QueryProjetos;

CREATE VIEW QueryContraA
as select NameContratante
from tbContratante where  NameContratante Like 'A%';

--select *from QueryContraA;

create view QueryValorProjeto
as select Valor
from tbProjeto where Valor>10;


--select *from QueryValorProjeto;

create view QueryMediaValor
as select avg (valor) Valor
from tbProjeto;

--select *from QueryMediaValor;

create view ProjConstrtHWorked
as select HoursWorked
from tbConsultorProjeto where HoursWorked > 5;

--select *from ProjConstrtHWorked;

create view ProjValorData
as select Valor
from tbProjeto where Valor>10 and DateStart LIKE '2019%';

--select *from ProjValorData;




-- Atividade 04/04

create view VProjContra
as select
p.CodProjeto as [C?digo do Projeto],
p.DateStart as [Data de In?cio],
p.DateEnd as [Data do Fim],
p.Valor,
c.NameContratante as [Nome do Contratante]
from tbProjeto as p
inner join tbContratante as c
on p.CodProjeto = c.CodContratante;

select * from VProjContra;


create view VProjConsCons
as select
cp.CodConsultorProjeto as [C?digo Projetos-Consultor],
cp.CodProjeto as [C?digo Projetos],
c.NameConsultor as [Nome do Consultor],
cp.HoursWorked as [Horas Trabalhadas],
cp.FunctionPerformed as [Fun??o Exercida]
from tbConsultorProjeto as cp
inner join tbConsultor as c
on cp.CodConsultorProjeto = c.CodConsultor;


select * from VProjConsCons;


