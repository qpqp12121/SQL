/* 기본적인 데이터조회 */

--테이블 구조 확인(어떤 열 있는지 참조)
desc departments;
--테이블 조회
select *
from employees;

select department_id, location_id 
from departments;

select location_id, department_id
from departments;

select department_id, department_id 
from departments;

select last_name, hire_date, salary
from employees;

--< 산술 연산자 >
select last_name, salary, salary + 300
from employees;

select last_name, salary, 12*salary+100
from employees;

select last_name, salary, 12*(salary+100)
from employees;

select last_name, job_id, salary, commission_pct
from employees;

select last_name, 12*salary*commission_pct
from employees;

--< NVL(칼럼명, 대체 값) >
--null인 경우 다 1로 바꿔줘라 => null값은 12*salary*1로 계산
select last_name, 12*salary*nvl(commission_pct,1)
from employees;

--< 열 별칭 Alias > + 앞에 AS키워드 사용은 선택사항
-- "공백, 특수문자, 대소문자 구분" 할 경우 -> 큰따옴표 사용
select last_name as name, commission_pct comm
from employees;

select last_name "Name", salary*12 "Annual Salary"
from employees;

select last_name as 이름, commission_pct 보너스
from employees;

select last_name||job_id as "Employees"
from employees;

--< || 연결 연산자 >
--< 리터럴 문자열 > : select 목록에 포함된 문자, 날짜, 숫자 (날짜,문자리터럴 값은 '작은따옴표'로 묶음
select last_name||' is a '||job_id as "Employees Details"
from employees;

select department_id
from employees;

--< DISTINCT > : 중복 행 제거 (*SELECT DISTINCT - )
select distinct department_id
from employees;

select distinct department_id, job_id
from employees;

/*문제1*/
--1번
desc departments;
select * 
from departments;
--2번
desc employees;
select department_id, last_name, job_id, hire_date startdate
from employees;
--3번
select distinct job_id
from employees;
--4번
select department_id "Emp #", last_name "Employee", job_id "Job", hire_date "Hire Date"
from employees;
--5번
select job_id ||', '|| last_name as "Employee and Title"
from employees; 


/* 데이터 제한 */

--< WHERE 절 > : 조건 만족하는 행만
select employee_id, last_name, job_id, department_id --3.이 칼럼들 가져와라
from employees --1.employees테이블에서
where department_id = 90; --2.컬럼명department_id가 90인 행만


--< WHERE절에서 문자열, 날짜 > : 문자열, 날짜 값 '작은 따옴표'로 묶음
--문자 값(데이터) 대소문자 구분!
select last_name, job_id, department_id
from employees
where last_name = 'Whalen';

--기본 날짜 형식: 'YY/MM/DD' (한글버전사용)
select last_name
from employees
where hire_date = '05/10/10';

--< 비교 연산자 > *순서: 칼럼명-비교연산-값
select last_name, salary
from employees
where salary <= 3000;

select last_name, hire_date
from employees
where hire_date < '05/01/01'; --입사일이 2005년 이전인 사람

--< BETWEEN 최소값 and 최대값 > : <= and >= 
select last_name, salary
from employees
where salary between 2500 and 3500;
--+아래 최대값 최소값 바꿔서 했는데도 오류가 안 뜸. 그러니 주의하기
select last_name, salary
from employees
where salary between 3500 and 2500;

--< IN(값1, 값2, ....) > : 괄호 안의 목록값 중 하나라도 가진 행 출력 (1 or 2 or 3...)
--문자,날짜형이면 반드시 '작은따옴표'
select employee_id, last_name, salary, manager_id
from employees
where manager_id in(100, 101, 201);

--< LIKE 연산자 > : 찾는 문자열 가진 행 출력
-- %: 문자 오지 않거나 여러 개
-- _: 하나의 문자만 대체
select first_name
from employees
where first_name like 'S%';

select last_name
from employees
where last_name like '%s';

select last_name, hire_date
from employees
where hire_date like '05%'; --2005년인 사람

select last_name
from employees
where last_name like '_o%'; --두번째 글자에 o가 있는 사람 출력

-- + ESCAPE 사용해서 %나 _ 검색할 수 O
select employee_id, last_name, job_id
from employees
where job_id like '%SA\_%' escape '\'; --앞에 아무 문자나 적고 뒤에 escape '문자' 표시

select employee_id, last_name, job_id
from employees
where job_id like '%SA3_%' escape '3';

--< 칼럼 IS NULL > : null값 조회
--< 칼럼 IS NOT NULL >
select *
from employees
where commission_pct is null; --(열 = null)아님 주의!

--< 논리 연산자 >
--AND
select employee_id, last_name, job_id, salary
from employees
where salary >= 10000
and job_id like '%MAN%';
--OR
select employee_id, last_name, job_id, salary
from employees
where salary >= 10000
or job_id like '%MAN%';
--NOT 
--( NOT IN() / NOT BETWEEN _ AND _ / NOT LIKE '%_' / IS NOT NULL )
select last_name, job_id
from employees
where job_id not in('IT_PROG', 'ST_CLERK', 'SA_REP');

--< 연산자 우선순위 > : 괄호가 제일
select last_name, job_id, salary
from employees
where job_id = 'SA_REP'
or job_id = 'AD_PRES'
and salary > 15000;
--위에거를 밑에선 괄호 사용
select last_name, job_id, salary
from employees
where (job_id = 'SA_REP'
or job_id = 'AD_PRES')
and salary > 15000;

/*문제2*/
--1번
select last_name, salary
from employees
where salary > 12000;
--2번
select last_name, department_id
from employees
where employee_id = 176;
--3번
select last_name, salary
from employees
where salary not between 5000 and 12000;
--6번
select last_name, salary
from employees
where salary between 5000 and 12000
    and department_id in(20, 50);
--7번
select last_name, hire_date
from employees
where hire_date like '05%'
where hire_date between '05/01/01' and '05/12/31';
--8번
select last_name, job_id
from employees
where manager_id is null;
--10번
select last_name
from employees
where last_name like '__a%';
--11번
select last_name
from employees
where last_name like '%a%'
    and last_name like '%e%'
--12번
select last_name, job_id, salary
from employees
where job_id in('SA_REP', 'ST_CLERK')
    and salary not in(2500, 3500, 7000);
--13번
select last_name, salary, commission_pct
from employees
where commission_pct = 0.2;