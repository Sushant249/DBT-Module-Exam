create database ModuleExam;
show databases;
use Moduleexam;
#SECTION I 
# Q1.  Create table DEPT with the following structure:-
/*DEPTNO int(2)
DNAME varchar(15)
LOC varchar(10)*/

create table dept (DEPTNO int(2), DNAME varchar(15),LOC varchar(10));
insert into dept values
(10,'ACCOUNTING','NEWYORK'),
(20,'RESEARCH','DELLAS'),
(30,'SALES','CHICAGO'),
(40,'OPERATIONS','BOSTON');
select * from dept;

# Q2. Create table EMP with the following structure:-
/*EMPNO int(4)
ENAME varchar(10)
JOB varchar(9)
HIREDATE date
SAL float(7,2)
COMM float(7,2)
DEPTNO int(2)*/
create table EMP (EMPNO int(4),ENAME varchar(10),JOB varchar(9),HIREDATE date,SAL float(7,2),COMM float(7,2),DEPTNO int(2));
insert into EMP values
(7839, 'KING', 'MANAGER', '1991-11-17', 5000,NULL,10),
(7698, 'BLAKE', 'CLERK', '1981-05-01', 2850,NULL,30),
(7782, 'CLARK', 'MANAGER', '1981-06-09', 2450,NULL,10),
(7566,'JONES', 'CLERK', '981-04-02', 2975,NULL,20),
(7654,'MARTIN','SALESMAN','1981-09-28',1250,1400,30),
(7499,'ALLEN','SALESMAN','1981-02-2',1600,300,30);
select * from emp;

# Q3. Display all the employees where SAL between 2500 and 5000 (inclusive of both)
select * from emp where sal between 2500 and 5000;

# Q4. Display all the ENAMEs in descending order of ENAME.
select ename"ENAME" from emp order by ename desc;

# Q5.Display all the JOBs in lowercase.
select lower(job) from emp;

# Q6.Display the ENAMEs and the lengths of the ENAMEs.
select ename, length(ename) from emp ;

# Q7.Display the DEPTNO and the count of employees who belong to that DEPTNO .
select deptno, count(deptno) from emp group by deptno;

# Q8.Display the DNAMEs and the ENAMEs who belong to that DNAME.
select dname, ename from emp,dept where dept.deptno = emp.deptno;

# Q9.Display the position at which the string ‘AR’ occurs in the ename.
select instr(ename,'AR') "Position" from emp;

# Q10.Display the HRA for each employee given that HRA is 20% of SAL.
select ename,sal*(20/100) "HRA" from emp;
---------------------------------------------------------------------------------
# SECTION II
/* Q1. . Write a stored procedure by the name of PROC1 that accepts two varchar strings
as parameters. Your procedure should then determine if the first varchar string 
exists inside the varchar string. For example, if string1 = ‘DAC’ and string2 = 
‘CDAC, then string1 exists inside string2. The stored procedure should insert the 
appropriate message into a suitable TEMPP output table. Calling program for the 
stored procedure need not be written. */

delimiter // 
create procedure PROC1(str1 varchar(10),str2 varchar(10))
begin
	if instr(str2,str1) <> 0 then
		insert into tempp values (str1,'Exists');
	else 
		insert into tempp values (str1,'NotExists');
    end if;
end;
// delimiter ;
/* table for storing output
create table tempp (str varchar(10),status varchar(10)); */
call PROC1('SAS','CDAC');
call PROC1('SAS','CDAC');
select * from tempp;
delete from tempp;
drop procedure PROC1;

--------------------------------------------------------------------
/* Q2. Create a stored function by the name of FUNC1 to take three parameters, the 
sides of a triangle. The function should return a Boolean value:- TRUE if the 
triangle is valid, FALSE otherwise. A triangle is valid if the length of each side is 
less than the sum of the lengths of the other two sides. Check if the dimensions 
entered can form a valid triangle. Calling program for the stored function need not 
be written */
 # Stored function :
delimiter //
create function FUNC1(a int,b int, c int)
returns boolean
deterministic
begin 
	if a+b > c and b+c > a and a+c > b then 
		return true;		
	end if;	
    return false;
end;
// delimiter ;

# calling program :

delimiter // 
create procedure fn(a int , b int , c int)
begin
	declare x boolean;
    set x  = FUNC1(a,b,c);
    if x then 
		insert into triangle values (a,b,c,'Valid');
	else 
		insert into triangle values (a,b,c,'InValid');
	end if;    
end;
// delimiter ;
call fn(1,3,5);
call fn(4,3,5);
select * from triangle;
drop procedure fn;
drop function FUNC1;
delete from triangle;

# table for storing result
create table triangle (fir int ,sec int,third int, status varchar(15));


