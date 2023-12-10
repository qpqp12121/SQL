/* �⺻���� ��������ȸ */

--���̺� ���� Ȯ��(� �� �ִ��� ����)
desc departments;
--���̺� ��ȸ
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

--< ��� ������ >
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

--< NVL(Į����, ��ü ��) >
--null�� ��� �� 1�� �ٲ���� => null���� 12*salary*1�� ���
select last_name, 12*salary*nvl(commission_pct,1)
from employees;

--< �� ��Ī Alias > + �տ� ASŰ���� ����� ���û���
-- "����, Ư������, ��ҹ��� ����" �� ��� -> ū����ǥ ���
select last_name as name, commission_pct comm
from employees;

select last_name "Name", salary*12 "Annual Salary"
from employees;

select last_name as �̸�, commission_pct ���ʽ�
from employees;

select last_name||job_id as "Employees"
from employees;

--< || ���� ������ >
--< ���ͷ� ���ڿ� > : select ��Ͽ� ���Ե� ����, ��¥, ���� (��¥,���ڸ��ͷ� ���� '��������ǥ'�� ����
select last_name||' is a '||job_id as "Employees Details"
from employees;

select department_id
from employees;

--< DISTINCT > : �ߺ� �� ���� (*SELECT DISTINCT - )
select distinct department_id
from employees;

select distinct department_id, job_id
from employees;

/*����1*/
--1��
desc departments;
select * 
from departments;
--2��
desc employees;
select department_id, last_name, job_id, hire_date startdate
from employees;
--3��
select distinct job_id
from employees;
--4��
select department_id "Emp #", last_name "Employee", job_id "Job", hire_date "Hire Date"
from employees;
--5��
select job_id ||', '|| last_name as "Employee and Title"
from employees; 


/* ������ ���� */

--< WHERE �� > : ���� �����ϴ� �ุ
select employee_id, last_name, job_id, department_id --3.�� Į���� �����Ͷ�
from employees --1.employees���̺���
where department_id = 90; --2.�÷���department_id�� 90�� �ุ


--< WHERE������ ���ڿ�, ��¥ > : ���ڿ�, ��¥ �� '���� ����ǥ'�� ����
--���� ��(������) ��ҹ��� ����!
select last_name, job_id, department_id
from employees
where last_name = 'Whalen';

--�⺻ ��¥ ����: 'YY/MM/DD' (�ѱ۹������)
select last_name
from employees
where hire_date = '05/10/10';

--< �� ������ > *����: Į����-�񱳿���-��
select last_name, salary
from employees
where salary <= 3000;

select last_name, hire_date
from employees
where hire_date < '05/01/01'; --�Ի����� 2005�� ������ ���

--< BETWEEN �ּҰ� and �ִ밪 > : <= and >= 
select last_name, salary
from employees
where salary between 2500 and 3500;
--+�Ʒ� �ִ밪 �ּҰ� �ٲ㼭 �ߴµ��� ������ �� ��. �׷��� �����ϱ�
select last_name, salary
from employees
where salary between 3500 and 2500;

--< IN(��1, ��2, ....) > : ��ȣ ���� ��ϰ� �� �ϳ��� ���� �� ��� (1 or 2 or 3...)
--����,��¥���̸� �ݵ�� '��������ǥ'
select employee_id, last_name, salary, manager_id
from employees
where manager_id in(100, 101, 201);

--< LIKE ������ > : ã�� ���ڿ� ���� �� ���
-- %: ���� ���� �ʰų� ���� ��
-- _: �ϳ��� ���ڸ� ��ü
select first_name
from employees
where first_name like 'S%';

select last_name
from employees
where last_name like '%s';

select last_name, hire_date
from employees
where hire_date like '05%'; --2005���� ���

select last_name
from employees
where last_name like '_o%'; --�ι�° ���ڿ� o�� �ִ� ��� ���

-- + ESCAPE ����ؼ� %�� _ �˻��� �� O
select employee_id, last_name, job_id
from employees
where job_id like '%SA\_%' escape '\'; --�տ� �ƹ� ���ڳ� ���� �ڿ� escape '����' ǥ��

select employee_id, last_name, job_id
from employees
where job_id like '%SA3_%' escape '3';

--< Į�� IS NULL > : null�� ��ȸ
--< Į�� IS NOT NULL >
select *
from employees
where commission_pct is null; --(�� = null)�ƴ� ����!

--< �� ������ >
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

--< ������ �켱���� > : ��ȣ�� ����
select last_name, job_id, salary
from employees
where job_id = 'SA_REP'
or job_id = 'AD_PRES'
and salary > 15000;
--�����Ÿ� �ؿ��� ��ȣ ���
select last_name, job_id, salary
from employees
where (job_id = 'SA_REP'
or job_id = 'AD_PRES')
and salary > 15000;

/*����2*/
--1��
select last_name, salary
from employees
where salary > 12000;
--2��
select last_name, department_id
from employees
where employee_id = 176;
--3��
select last_name, salary
from employees
where salary not between 5000 and 12000;
--6��
select last_name, salary
from employees
where salary between 5000 and 12000
    and department_id in(20, 50);
--7��
select last_name, hire_date
from employees
where hire_date like '05%'
where hire_date between '05/01/01' and '05/12/31';
--8��
select last_name, job_id
from employees
where manager_id is null;
--10��
select last_name
from employees
where last_name like '__a%';
--11��
select last_name
from employees
where last_name like '%a%'
    and last_name like '%e%'
--12��
select last_name, job_id, salary
from employees
where job_id in('SA_REP', 'ST_CLERK')
    and salary not in(2500, 3500, 7000);
--13��
select last_name, salary, commission_pct
from employees
where commission_pct = 0.2;