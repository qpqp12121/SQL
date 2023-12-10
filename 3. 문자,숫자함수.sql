/* 문자함수 */
desc dual;

select *
from dual;
--날짜 sysdate치면 데이터 수만큼 날짜 다 나오ㅏ서 dual 씀
select sysdate
from employees;
-- dual테이블: 값 한번만 반환할 때 유용 (DUMMY라는 컬럼 & X값 소유)
select sysdate
from dual;

--< 대소문자 조작 함수 >
-- UPPER() / LOWER() / INITCAP()
select 'The job id for ' || upper(last_name) || ' is ' || lower(job_id) as "EMPLOYEE DETAILS"
from employees;

 --이름 대소문자 중 뭘로 들어있는지 몰라 컬럼 자체를 소문자로 바꿔서 찾음
select employee_id, last_name, department_id
from employees
where lower(last_name) = 'higgins';

--< 문자 조작 함수 >
-- *SUBSTR(문자열, 시작위치, 몇글자) : 시작위치에 음수로 하면 뒤에서부터 (-3,2) 3번째자리부터 두글자 나오게
-- CONCAT(문자열1,문자열2) : 두 문자 연결
-- LENGTH(문자열)

-- TRIM('d' FROM 'ddyedamd'): 앞뒤 자르기  + TRIM(' 문자열 ') 앞뒤공백 없애 줌
--  LTRIM(문자열, '자를문자')
--  RTRIM(문자열, '자를문자')

-- LPAD('yedam', 10, '*') => *****yedam : 문자길이 10글자로 하고 yedam글자 나오기 전까지 *로 채워라
-- RPAD('yedam', 10, '*') => yedam*****

select last_name, substr(last_name, -3,2)
from employees
where department_id = 90;

--+ instr(열, '찾는문자'): 찾는문자 시작 위치 반환 (없으면 0)
select employee_id, concat(concat(first_name, ' '), last_name) NAME,
       job_id, length(last_name), instr(last_name,'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'REP';

--LTRIM 왼쪽부터 잘라내는데 앞부분만 가능(중간에 다른 글자나오면 stop)
SELECT LTRIM('yyedaymy', 'yea')
from dual;
--RTRIM 오른쪽부터
SELECT RTRIM('yyedaymy', 'yea')
from dual;


/* 숫자함수 */
--ROUND()
select round(345.678), round(345.678,0), round(345.678,1), round(345.678,-1)
from dual;
--TRUNC(): 소수점 자리까지 두고 값 버림
SELECT TRUNC(345.678), TRUNC(345.678,0), TRUNC(345.678,1), TRUNC(345.678,-1)
from dual;
--MOD() : 나눗셈의 나머지를 반환
SELECT last_name, salary, MOD(salary, 5000)
from employees;

select *
from employees;

/*문제*/
--1번
select sysdate "Date"
from dual;
--2번
select employee_id, last_name, salary, Round(salary * 1.15) "New Salary"
from employees;
--3번
select employee_id, last_name, salary,(salary * 1.15) "New Salary", (salary * 1.15) - salary "Increase"
from employees;
--4번
select upper(last_name) name, length(last_name) name_length
from employees
where substr(last_name, 1,1) in('J','A','M') --이름 첫번째 글자가 J,A,M으로 시작하는 )SUBSTR(열,시작위치, 몇글자)
order by 1;
