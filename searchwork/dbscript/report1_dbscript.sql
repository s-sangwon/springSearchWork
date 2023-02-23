drop table code_skill cascade constraints;
drop sequence code_skill_seq;
drop table code_department cascade constraints;
drop sequence code_department_seq;
drop table code_school cascade constraints;
drop sequence code_school_seq;
drop table staff cascade constraints;
drop sequence staff_seq;
drop table staff_skill cascade constraints;
drop sequence staff_skill_seq;

create table code_skill (
    skill_code number(3) primary key,
    skill_name varchar2(20) not null unique
);
create sequence code_skill_seq start with 1 increment by 1;

create table code_department (
    department_code number(3) primary key,
    department_name varchar2(30) not null unique
);
create sequence code_department_seq start with 1 increment by 1;

create table code_school (
    school_code number(3) primary key,
    school_name varchar2(20) not null unique
);
create sequence code_school_seq start with 1 increment by 1;

create table staff (
    staff_no number(3) primary key,
    staff_name varchar2(20) not null,
    jumin_no char(14) not null unique,
    school_code number(3) not null,
    department_code number(3) not null,
    graduate_day char(10) not null,
    foreign key(school_code) references code_school(school_code),
    foreign key(department_code) references code_department(department_code)
);
create sequence staff_seq start with 1 increment by 1;

create table staff_skill (
    staff_skill_no number(3) primary key,
    staff_no number(3) not null,
    skill_code number(3) not null,
    foreign key(staff_no) references staff(staff_no) on delete cascade,
    foreign key(skill_code) references code_skill(skill_code)
);


create sequence staff_skill_seq start with 1 increment by 1;

insert into code_skill(skill_code,skill_name) values(code_skill_seq.nextval,'Java');
insert into code_skill(skill_code,skill_name) values(code_skill_seq.nextval,'JSP');
insert into code_skill(skill_code,skill_name) values(code_skill_seq.nextval,'ASP');
insert into code_skill(skill_code,skill_name) values(code_skill_seq.nextval,'PHP');
insert into code_skill(skill_code,skill_name) values(code_skill_seq.nextval,'Delphi');

insert into code_department(department_code, department_name) values(code_department_seq.nextval, 'ICT사업부');
insert into code_department(department_code, department_name) values(code_department_seq.nextval, '디지털트윈사업부');
insert into code_department(department_code, department_name) values(code_department_seq.nextval, 'SI사업부');
insert into code_department(department_code, department_name) values(code_department_seq.nextval, '반도체사업부');
insert into code_department(department_code, department_name) values(code_department_seq.nextval, '기업부설연구소');
insert into code_department(department_code, department_name) values(code_department_seq.nextval, '전략기획팀');
insert into code_department(department_code, department_name) values(code_department_seq.nextval, '경영지원팀');

insert into code_school(school_code, school_name) values(code_school_seq.nextval, '고졸');
insert into code_school(school_code, school_name) values(code_school_seq.nextval, '전문대졸');
insert into code_school(school_code, school_name) values(code_school_seq.nextval, '일반대졸');

commit;

Insert into CODE_SKILL (SKILL_CODE,SKILL_NAME) values (code_skill_seq.nextval'javascript');
Insert into CODE_SKILL (SKILL_CODE,SKILL_NAME) values (code_skill_seq.nextval,'jquery');
Insert into CODE_SKILL (SKILL_CODE,SKILL_NAME) values (code_skill_seq.nextval,'oracle');
Insert into CODE_SKILL (SKILL_CODE,SKILL_NAME) values (code_skill_seq.nextval,'mybatis');
Insert into CODE_SKILL (SKILL_CODE,SKILL_NAME) values (code_skill_seq.nextval,'spring');
Insert into CODE_SKILL (SKILL_CODE,SKILL_NAME) values (code_skill_seq.nextval,'mariadb');
Insert into CODE_SKILL (SKILL_CODE,SKILL_NAME) values (code_skill_seq.nextval,'mysql');
Insert into CODE_SKILL (SKILL_CODE,SKILL_NAME) values (code_skill_seq.nextval,'crm');
Insert into CODE_SKILL (SKILL_CODE,SKILL_NAME) values (code_skill_seq.nextval,'pl/sql');
Insert into CODE_SKILL (SKILL_CODE,SKILL_NAME) values (code_skill_seq.nextval,'ai');

Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'구팔영','980713-1717347',3,5,'1978-12-25');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'저팔계','123456-1234567',1,1,'1983-12-25');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'사오정','123456-2234567',2,2,'1973-12-25');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'손오공','123456-1234568',3,5,'1973-12-25');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'손오반','123457-1234569',3,3,'1993-12-25');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'손무공','123456-1234578',3,6,'2003-12-25');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'저칠계','123454-2234568',3,7,'1963-12-25');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'사육정','123455-2234568',3,5,'1978-12-25');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'서상원','970225-1234568',3,3,'1962-02-03');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'팔육공','860301-1886522',3,3,'1998-12-25');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'팔팔공','880809-1367941',3,4,'1998-12-25');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'팔칠공','870405-2973349',3,2,'1998-12-25');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'구팔영','980504-1861945',3,1,'1998-12-25');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'칠영공','700611-2981714',3,7,'1998-12-25');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'팔구영','890426-2937882',3,6,'1998-12-25');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'구일영사','910420-1445337',1,1,'1998-12-06');
Insert into STAFF (STAFF_NO,STAFF_NAME,JUMIN_NO,SCHOOL_CODE,DEPARTMENT_CODE,GRADUATE_DAY) values (staff_seq.nextval,'홍길동','760706-2913831',2,3,'2011-05-01');

Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,36,4);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,36,16);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,36,11);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,11,2);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,3,1);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,3,3);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,3,4);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,3,5);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,4,2);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,4,3);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,4,4);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,5,1);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,5,2);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,5,3);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,6,3);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,6,4);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,6,5);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,7,1);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,7,2);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,7,3);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,7,4);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,7,5);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,8,3);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,8,4);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,8,5);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,9,2);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,9,5);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,11,5);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,12,2);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,12,5);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,13,2);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,13,5);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,14,2);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,14,4);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,15,2);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,15,3);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,16,2);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,16,2);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,17,2);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,17,4);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,18,10);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,36,10);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,19,1);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,36,9);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,36,7);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,36,12);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,36,14);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,18,1);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,36,2);
Insert into STAFF_SKILL (STAFF_SKILL_NO,STAFF_NO,SKILL_CODE) values (staff_skill_seq.nextval,36,3);

commit;