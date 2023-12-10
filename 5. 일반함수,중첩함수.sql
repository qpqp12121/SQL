/* 일반함수 */

--* NVL(칼럼, 대체 값) 
--  : 값이 null인 경우, 지정한 대체 값으로 변경해서 계산
--  ** 두 개의 데이터 타입 같아야 된다!
select last_name, salary, NVL(commission_pct,0) com,
       (salary*12) + (salary*12*NVL(commission_pct,0)) AN_SAL
from employees;

select last_name, salary, NVL(to_char(commission_pct),'보너스 없음') com
from employees;

--NVL2( 칼럼,null이 아닌 경우 반환값, null인 경우 값 ) - 잘 사용 X
--제일 앞빼고 뒤에 두 개만 타입 같으면 됨
select last_name, salary, commission_pct, NVL2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;

--NULLIF(칼럼, 칼럼) : 두 표현식 비교 
--동일한 경우 null을 반환, 동일하지X : 첫번째표현식 expr1을 반환
select first_name, length(first_name) "expr1", last_name, length(last_name) "expr2",
    NULLIF(length(first_name), length(last_name)) result
from employees;

--COALESCE()


/* < 조건표현식 >
   : SQL문 안에서 IF-THEN-ELSE 논리를 사용할 수 있도록 함
  º 두 가지 방법
    1) CASE 표현식 ( CASE 칼럼 WHEN 값,연산식 THEN 어떻게 하라 
                             ELSE 아니면 이렇게
                    END (별칭)                       )
    2) DECODE 함수 : equal인 경우에만 사용 가능(비교연산 사용X) +(오라클 구문에만 존재)*/

--1) CASE
select last_name, job_id, salary,
       case job_id when 'IT_PROG' then 1.10*salary
                   when 'ST_CLERK' then 1.15*salary
                   when 'SA_REP' then 1.20*salary
                   else salary
       end "REVISED_SALLARY"
from employees;

select last_name, salary,
       case when salary < 5000 then 'Low'
            when salary < 10000 then 'Medium'
            when salary < 20000 then 'Good'
                                else 'Excellent'
       end qualified_salary
from employees;

--2) DECODE( 칼럼, 값이 이거면, 어떻게 해라 )
select last_name, job_id, salary,
       decode( job_id, 'IT_PROG', 1.10*salary,
                       'ST_CLERK', 1.15*salary,
                       'SA_REP', 1.20*salary,
                                 salary )
      REVISED_SALLARY
from employees;


/* 중첩함수 */
-- : 단일행 함수는 여러 번 중첩 가능
--   * 가장 안쪽부터 -> 바깥쪽 순으로 계산

-- ex. 위에 있던 질의 ( to_char먼저 풀고 바깥 NVL() 풀 듯이)
select last_name, salary, NVL(to_char(commission_pct),'보너스 없음') com
from employees;

/*문제*/
select *
from employees;
--1.
SELECT last_name || ' earns' || TO_CHAR(salary, '$99,999.00') || ' monthly but wants' || TO_CHAR(salary*3,'$99,999.00') "Dream Salaries"
FROM employees;
--2.
SELECT last_name, hire_date,  --( , 2) 도 가능 (일요일이 1) --AMERICAN SESSION으로 변경했어서 오류 떴던 거
    TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6),'월'), 'YYYY.MM.DD DAY') review
FROM employees;
--3.
SELECT last_name, hire_date, TO_CHAR(hire_date, 'DAY') DAY
FROM employees
ORDER BY TO_CHAR(hire_date-1, 'D'); 
--*일주일의 시작 1이 일요일이라 -1하면 월요일 기준 / 'd': 주중의 일을 1~7로 표시(1~7일 일주일을 나타내므로 연도,월 상관없이 일주일 중에 월요일인 것을 기준으로 정렬한다 
--4.
SELECT last_name, NVL(TO_CHAR(commission_pct, '0.99'), 'No Commission') comm
FROM employees;
--5.
--CASE
SELECT job_id 업무,
    CASE job_id WHEN 'AD_PRES' THEN 'A'
                WHEN 'ST_MAN' THEN 'B'
                WHEN 'IT_PROG' THEN 'C'
                WHEN 'SA_REP' THEN 'D'
                WHEN 'ST_CLERK' THEN 'E'
                ELSE '0'
    END 등급
FROM employees
ORDER BY (CASE 등급 WHEN 'A' THEN 0
                  WHEN 'B' THEN 1  
                  WHEN 'C' THEN 2
                  WHEN 'D' THEN 3
                  WHEN 'E' THEN 4
                  ELSE 5
                  END);

--DECODE()
SELECT job_id 업무,
    DECODE ( job_id, 'AD_PRES', 'A', 'ST_MAN', 'B', 'IT_PROG', 'C',
                     'SA_REP', 'D', 'ST_CLERK', 'E', '0' ) 등급
FROM employees
order by 등급;                 
