/* ��¥ */

--�⺻ ����: �ѱ۹��� YY/MM/DD (DD/MON/YY)
--SYSDATE : ������ ��¥&�ð� ��ȯ ( DUAL ���̺� ���� )
select sysdate
from dual;

/* < ��¥ ���� >  
  [ ��¥ + ���� ] : ��¥�� �ϼ� ����
  [ ��¥ - ���� ] : ��¥�� �ϼ� ��
  [ ��¥ - ��¥ ] : ��¥���� �ٸ���¥ ��
  [ ��¥ + ����/24 ] : ��¥�� �ð� ���� ����        */

/* < ��¥ �Լ� >
   MONTHS_BETWEEN(��¥1, ��¥2) : �� ��¥ ������ �� �� ��ȯ
   ADD_MONTHS(��¥��, ���� ����) : ��¥�� ���� ����
   NEXT_DAY(��¥��, '����') : ��¥�� ���� - ����� '����'�� ��¥ ��ȯ ex.�Ի� 03/06/17(ȭ)=> �ݿ��� ��¥ 03/06/20 ��ȯ
   LAST_DAY(��¥��) : �ش� ���� ������ ��¥ ��ȯ
   ROUND() : ��¥ �ݿø�
   TRUNC() : ��¥ ����                                                        */

select last_name, (SYSDATE - hire_date) / 7 WEEKS --'/ 7' �Ѱ� �ܱ��ֱް�궧���� ��� 
from employees
where department_id = 90;

select employee_id, hire_date, MONTHS_BETWEEN(SYSDATE, hire_date) TENURE,
        ADD_MONTHS(hire_date,6) REVIEW, NEXT_DAY(hire_date,'��'), LAST_DAY(hire_date)
from employees;   

/* ROUND(SYSDATE, 'YEAR') : 7�� 1�� 0�ú��� �ݿø�
   ROUND(SYSDATE, 'MONTH') : 16�� 0�ú���
   ROUND(SYSDATE, 'DAY') : ������ �� 12�ú��� (DAY�� �Ͽ��Ϻ��� �����ؼ� �Ͽ�ȭ/��/�����)
   ROUND(SYSDATE, 'DD') : �� 12�ú���                 */

select ROUND(SYSDATE, 'YEAR'), ROUND(SYSDATE, 'MONTH'),
       ROUND(SYSDATE, 'DAY'), ROUND(SYSDATE, 'DD')
from dual;

/* TRUNC(SYSDATE, 'YEAR') : ���� ���� ù�� ��ȯ
   TRUNC(SYSDATE, 'MONTH') : ���� �� ù��
   TRUNC(SYSDATE, 'DAY') : �̹� �� (�Ͽ��Ϻ��� ����)
   TRUNC(SYSDATE, 'DD') : ����                    */
   
select TRUNC(SYSDATE, 'YEAR'), TRUNC(SYSDATE, 'MONTH')
      ,TRUNC(SYSDATE, 'DAY'), TRUNC(SYSDATE, 'DD')
from dual;


/* ��ȯ�Լ� */
-- : ������ Ÿ�� ��ȯ

--�Ͻ��� ������ ���� ��ȯ (�˾Ƽ� ��ȯ�ϴ� �Ű�X) 
select *
from employees
where employee_id = '101'; --���ڷ� ������ �˾Ƽ� ���� 101�� �ٲ㼭 �ν�


--����� ������ ���� ��ȯ
/* TO_CHAR (��¥��, '���ĸ�') : Į���� ��¥�� '�̷� ����'�� ���ڷ� �ٲ��
   : ��¥ -> ���ڷ� �ٲٴ� */

ALTER SESSION SET
NLS_DATE_LANGUAGE = AMERICAN; --(������ ��¥ ���� �̱����� ��� ��ȯ)
 
select employee_id, to_char(hire_date, 'MM/YY') Month_Hired
from employees;

--MONTH/Month/month .. ��ҹ��� ������ ( JUNE/June/june )
select last_name, to_char(hire_date, 'DD MONTH YYYY')
from employees;

select last_name, to_char(hire_date, 'DD month YYYY')
from employees;

--'fm - ' ���� �տ� fm ���̸� ���� �� �ڸ� ���� �� ���� or �տ� 0�� ������ 0 ����
select last_name, to_char(hire_date, 'fmDD MONTH YYYY') --������ 03 JANUARY �������� fm�پ 3 JANUARY ���
from employees;
--DDTH : ���� (17th)
--DDSP : ���ڷ� ǥ���� �� (17�� SEVENTEEN) + Ddsp (Seventeenth)
--+ th, sp�� ��ҹ��� ���� ��
select last_name, to_char(hire_date, 'fmDdspth "of" Month YYYY fmHH:MI:SS AM')
from employees;

/* TO_CHAR (����, '�������ĸ�')
   : ���� -> ���� 
     - 9 : ���ڸ� ǥ��
     - 0 : 0�� ������ ǥ��
     - $ : $ ��ȣ ǥ��
     - L : ����ȭ�� ��ȣ ǥ��
     - . : ����� ��ġ�� �Ҽ��� ǥ��
     - , : ����� ��ġ�� ������ ǥ��   */

select to_char(salary, '$99,999.00') salary
from employees;

--* ���� ū �ڸ�����ŭ 9 �־���� ���� �� ( �ڱ⺸�� ���� �ڸ����� �ԷµǸ� ###���� ǥ�� ��)
select to_char(salary, '$9,999.00') salary
from employees; 

-- TO_NUMBER(���ڿ�, '���ĸ�') 
-- : ���� -> ���ڷ� ��ȯ ( �� ���ڴ�, �̷������� ���� �����̴�)
select to_number('$3,400', '$99,999') 
from dual;

select to_number('3400')
from dual; -- ��ȣ ���� ���ڸ� �ִ� ���ڸ� ���ĸ� ����O

--* To_DATE(���ڿ�, '���ĸ�) 
--  : ���� -> ��¥�� (�� ���ڴ�, �̷������� ���� ��¥�Դϴ�)
select to_date('2010��, 02��', 'YYYY"��", MM"��"')
from dual;

--�Է� �� ��¥ ������ ���� ��� �𸣴ϱ� ������ֱ�
--ex. ����� �߿��� 2005�� 7�� 1�� ���Ŀ� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ� 
select last_name, hire_date
from employees
where hire_date > to_date('2005�� 07�� 01��', 'YYYY"��" MM"��" DD"��"');
  --where hire_date > to_date('05/07/01', 'YY/MM/DD') ('05/07/01', 'YY-MM-DD') ���� ����ϸ� �˾Ƽ� ���� ��
  
--�տ� 'fx- ' ���ΰ� ��Ȯ�ϰ� �Ȱ�����
select last_name, hire_date
from employees
where hire_date > to_date('05/07/01', 'fxYY/MM/DD');


/*����*/
--5.
select last_name, round(months_between(SYSDATE,hire_date)) "MONTHS_WORKED"
from employees;
--6.
select last_name, LPAD(salary, 15, '#') salary
from employees; 

--7.
select last_name, Round((SYSDATE - hire_date) / 7) TENURE
from employees
where department_id = 90;
