/* �Ϲ��Լ� */

--* NVL(Į��, ��ü ��) 
--  : ���� null�� ���, ������ ��ü ������ �����ؼ� ���
--  ** �� ���� ������ Ÿ�� ���ƾ� �ȴ�!
select last_name, salary, NVL(commission_pct,0) com,
       (salary*12) + (salary*12*NVL(commission_pct,0)) AN_SAL
from employees;

select last_name, salary, NVL(to_char(commission_pct),'���ʽ� ����') com
from employees;

--NVL2( Į��,null�� �ƴ� ��� ��ȯ��, null�� ��� �� ) - �� ��� X
--���� �ջ��� �ڿ� �� ���� Ÿ�� ������ ��
select last_name, salary, commission_pct, NVL2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;

--NULLIF(Į��, Į��) : �� ǥ���� �� 
--������ ��� null�� ��ȯ, ��������X : ù��°ǥ���� expr1�� ��ȯ
select first_name, length(first_name) "expr1", last_name, length(last_name) "expr2",
    NULLIF(length(first_name), length(last_name)) result
from employees;

--COALESCE()


/* < ����ǥ���� >
   : SQL�� �ȿ��� IF-THEN-ELSE ���� ����� �� �ֵ��� ��
  �� �� ���� ���
    1) CASE ǥ���� ( CASE Į�� WHEN ��,����� THEN ��� �϶� 
                             ELSE �ƴϸ� �̷���
                    END (��Ī)                       )
    2) DECODE �Լ� : equal�� ��쿡�� ��� ����(�񱳿��� ���X) +(����Ŭ �������� ����)*/

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

--2) DECODE( Į��, ���� �̰Ÿ�, ��� �ض� )
select last_name, job_id, salary,
       decode( job_id, 'IT_PROG', 1.10*salary,
                       'ST_CLERK', 1.15*salary,
                       'SA_REP', 1.20*salary,
                                 salary )
      REVISED_SALLARY
from employees;


/* ��ø�Լ� */
-- : ������ �Լ��� ���� �� ��ø ����
--   * ���� ���ʺ��� -> �ٱ��� ������ ���

-- ex. ���� �ִ� ���� ( to_char���� Ǯ�� �ٱ� NVL() Ǯ ����)
select last_name, salary, NVL(to_char(commission_pct),'���ʽ� ����') com
from employees;

/*����*/
select *
from employees;
--1.
SELECT last_name || ' earns' || TO_CHAR(salary, '$99,999.00') || ' monthly but wants' || TO_CHAR(salary*3,'$99,999.00') "Dream Salaries"
FROM employees;
--2.
SELECT last_name, hire_date,  --( , 2) �� ���� (�Ͽ����� 1) --AMERICAN SESSION���� �����߾ ���� ���� ��
    TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6),'��'), 'YYYY.MM.DD DAY') review
FROM employees;
--3.
SELECT last_name, hire_date, TO_CHAR(hire_date, 'DAY') DAY
FROM employees
ORDER BY TO_CHAR(hire_date-1, 'D'); 
--*�������� ���� 1�� �Ͽ����̶� -1�ϸ� ������ ���� / 'd': ������ ���� 1~7�� ǥ��(1~7�� �������� ��Ÿ���Ƿ� ����,�� ������� ������ �߿� �������� ���� �������� �����Ѵ� 
--4.
SELECT last_name, NVL(TO_CHAR(commission_pct, '0.99'), 'No Commission') comm
FROM employees;
--5.
--CASE
SELECT job_id ����,
    CASE job_id WHEN 'AD_PRES' THEN 'A'
                WHEN 'ST_MAN' THEN 'B'
                WHEN 'IT_PROG' THEN 'C'
                WHEN 'SA_REP' THEN 'D'
                WHEN 'ST_CLERK' THEN 'E'
                ELSE '0'
    END ���
FROM employees
ORDER BY (CASE ��� WHEN 'A' THEN 0
                  WHEN 'B' THEN 1  
                  WHEN 'C' THEN 2
                  WHEN 'D' THEN 3
                  WHEN 'E' THEN 4
                  ELSE 5
                  END);

--DECODE()
SELECT job_id ����,
    DECODE ( job_id, 'AD_PRES', 'A', 'ST_MAN', 'B', 'IT_PROG', 'C',
                     'SA_REP', 'D', 'ST_CLERK', 'E', '0' ) ���
FROM employees
order by ���;                 
