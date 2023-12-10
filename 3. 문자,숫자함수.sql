/* �����Լ� */
desc dual;

select *
from dual;
--��¥ sysdateġ�� ������ ����ŭ ��¥ �� �������� dual ��
select sysdate
from employees;
-- dual���̺�: �� �ѹ��� ��ȯ�� �� ���� (DUMMY��� �÷� & X�� ����)
select sysdate
from dual;

--< ��ҹ��� ���� �Լ� >
-- UPPER() / LOWER() / INITCAP()
select 'The job id for ' || upper(last_name) || ' is ' || lower(job_id) as "EMPLOYEE DETAILS"
from employees;

 --�̸� ��ҹ��� �� ���� ����ִ��� ���� �÷� ��ü�� �ҹ��ڷ� �ٲ㼭 ã��
select employee_id, last_name, department_id
from employees
where lower(last_name) = 'higgins';

--< ���� ���� �Լ� >
-- *SUBSTR(���ڿ�, ������ġ, �����) : ������ġ�� ������ �ϸ� �ڿ������� (-3,2) 3��°�ڸ����� �α��� ������
-- CONCAT(���ڿ�1,���ڿ�2) : �� ���� ����
-- LENGTH(���ڿ�)

-- TRIM('d' FROM 'ddyedamd'): �յ� �ڸ���  + TRIM(' ���ڿ� ') �յڰ��� ���� ��
--  LTRIM(���ڿ�, '�ڸ�����')
--  RTRIM(���ڿ�, '�ڸ�����')

-- LPAD('yedam', 10, '*') => *****yedam : ���ڱ��� 10���ڷ� �ϰ� yedam���� ������ ������ *�� ä����
-- RPAD('yedam', 10, '*') => yedam*****

select last_name, substr(last_name, -3,2)
from employees
where department_id = 90;

--+ instr(��, 'ã�¹���'): ã�¹��� ���� ��ġ ��ȯ (������ 0)
select employee_id, concat(concat(first_name, ' '), last_name) NAME,
       job_id, length(last_name), instr(last_name,'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'REP';

--LTRIM ���ʺ��� �߶󳻴µ� �պκи� ����(�߰��� �ٸ� ���ڳ����� stop)
SELECT LTRIM('yyedaymy', 'yea')
from dual;
--RTRIM �����ʺ���
SELECT RTRIM('yyedaymy', 'yea')
from dual;


/* �����Լ� */
--ROUND()
select round(345.678), round(345.678,0), round(345.678,1), round(345.678,-1)
from dual;
--TRUNC(): �Ҽ��� �ڸ����� �ΰ� �� ����
SELECT TRUNC(345.678), TRUNC(345.678,0), TRUNC(345.678,1), TRUNC(345.678,-1)
from dual;
--MOD() : �������� �������� ��ȯ
SELECT last_name, salary, MOD(salary, 5000)
from employees;

select *
from employees;

/*����*/
--1��
select sysdate "Date"
from dual;
--2��
select employee_id, last_name, salary, Round(salary * 1.15) "New Salary"
from employees;
--3��
select employee_id, last_name, salary,(salary * 1.15) "New Salary", (salary * 1.15) - salary "Increase"
from employees;
--4��
select upper(last_name) name, length(last_name) name_length
from employees
where substr(last_name, 1,1) in('J','A','M') --�̸� ù��° ���ڰ� J,A,M���� �����ϴ� )SUBSTR(��,������ġ, �����)
order by 1;
