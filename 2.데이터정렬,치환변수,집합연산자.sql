/* ������ ���� */
--< order by Į�� > : ASC �⺻��
--< order by Į�� DESC >    
select last_name, job_id, department_id, hire_date
from employees
order by hire_date desc;

--��Ī���ε� ����
select employee_id, last_name, salary*12 annsal
from employees
order by annsal;

--����Ŭ���� ���ڷε� ����
select last_name, job_id, department_id, hire_date
from employees
order by 3;

--�����÷����� ���ĵ� ���� (�տ��� ���� 1������ - 2������)
select last_name, department_id, salary
from employees
order by department_id, salary desc; --dep_id�� 1�������ؼ� �μ����� ������ - 2��salary������������ �ؼ� �μ����� �޿� ���� ���� ���

--select���� ���� Į���̶� ���̺� ������ ���� ����
select employee_id, salary
from employees
order by hire_date;

--< ġȯ���� > ���� ������� X (����Ŭ����1��.113p����)
-- ���� & ���ۻ���: ���� �տ� ���ۻ���& ���̸� ������ ���� �Է��� �� O (�Ͻ���)
select employee_id, last_name, salary, department_id
from employees
where employee_id = &employee_num; --�����ϸ� �Է�â ������ employee_id Į���� ���� �� ���? ex. 101 �Է��ϸ� emp_id 101�� �� ���

select employee_id, last_name, job_id, &coloumn_name --salary�Է�
from employees
where &condition --salary > 15000
order by &order_column; --last_name

--���� && : �� ������ ó�� �Է¹��� ���� ���������� �޸𸮿� ���� ��. �׷��� oder by������ ����&�Ἥ �Է¹��� �� ���
select employee_id, last_name, job_id, &&column_name --department_id �Է�(������)-�׷��� �ؿ��� ��� ��밡��
from employees
order by &column_name;

select employee_id, salary
from employees
order by &column_name; --������ && �����صױ� ������ �Է�â �ȶ߰� �ٷ� ����(�ٵ� �������� Į������ department_id ��� ������ Ȯ�� �� �Ǵ� ����)

--����&& �ش��ϴ� ġȯ���� �޸𸮿��� ����
undefine column_name;
--���� �� �����ϴ� �Է�â �߸鼭 �ٽ� �Է¹���
select employee_id, salary
from employees
order by &coloumn_name;


/* ���� ������ */
--employees, job_history ���̺� (employee_id / job_id / deparment_id �� ����)
select *
from employees; --107�� ��

select *
from job_history; --10�� ��

--UNION ALL ����� �� ù��° �÷����� �������� ���� ��

--< UNION > : ������(�ߺ��� ����)
select employee_id, job_id 
from employees              --107����   
UNION                       --�� Į�� �ߺ� 2�������� => 115���� ���
select employee_id, job_id
from job_history;           --10����

--< UNION ALL > : ������ 
--*�ߺ����� X, ���ĵ� X => �׻� �����Ϸ��� �� �������� ORDER BY�� ����
select employee_id, job_id
from employees
UNION ALL
select employee_id, job_id
from job_history
order by employee_id;

--< INTERSECT > : ������(������ ����
select employee_id, job_id
from employees
INTERSECT
select employee_id, job_id
from job_history;
--���̺�� ���� �ٲ��� ��� �Ȱ��� ����
select employee_id, job_id
from job_history
INTERSECT
select employee_id, job_id
from employees;

--< MINUS > : ������(ù��° ���ǿ� �ش�Ǵ� ���� ����
--=>���̺�� ���� �ٲ�� ����� �ٸ�
select employee_id, job_id
from employees
MINUS
select employee_id, job_id
from job_history;
--���̺� ���� �ٲ�
select employee_id, job_id
from job_history
MINUS
select employee_id, job_id
from employees;

