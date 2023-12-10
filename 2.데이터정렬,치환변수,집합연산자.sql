/* 데이터 정렬 */
--< order by 칼럼 > : ASC 기본값
--< order by 칼럼 DESC >    
select last_name, job_id, department_id, hire_date
from employees
order by hire_date desc;

--별칭으로도 가능
select employee_id, last_name, salary*12 annsal
from employees
order by annsal;

--오라클에선 숫자로도 가능
select last_name, job_id, department_id, hire_date
from employees
order by 3;

--여러컬럼으로 정렬도 가능 (앞에거 먼저 1차정렬 - 2차정렬)
select last_name, department_id, salary
from employees
order by department_id, salary desc; --dep_id로 1차정렬해서 부서별로 나오고 - 2차salary내림차순으로 해서 부서별로 급여 제일 높은 사람

--select절에 없는 칼럼이라도 테이블엔 있으니 정렬 가능
select employee_id, salary
from employees
order by hire_date;

--< 치환변수 > 많이 사용하진 X (오라클교재1권.113p참고)
-- 단일 & 앰퍼샌드: 변수 앞에 앰퍼샌드& 붙이면 유저가 값을 입력할 수 O (일시적)
select employee_id, last_name, salary, department_id
from employees
where employee_id = &employee_num; --실행하면 입력창 나오고 employee_id 칼럼의 무슨 값 출력? ex. 101 입력하면 emp_id 101인 행 출력

select employee_id, last_name, job_id, &coloumn_name --salary입력
from employees
where &condition --salary > 15000
order by &order_column; --last_name

--더블 && : 이 변수에 처음 입력받은 값이 영구적으로 메모리에 저장 됨. 그래서 oder by절에서 단일&써서 입력받은 값 사용
select employee_id, last_name, job_id, &&column_name --department_id 입력(영구적)-그래서 밑에서 계속 사용가능
from employees
order by &column_name;

select employee_id, salary
from employees
order by &column_name; --위에서 && 저장해뒀기 때문에 입력창 안뜨고 바로 실행(근데 보여지는 칼럼에는 department_id 없어서 눈으론 확인 안 되는 거임)

--더블&& 해당하는 치환변수 메모리에서 삭제
undefine column_name;
--삭제 후 실행하니 입력창 뜨면서 다시 입력받음
select employee_id, salary
from employees
order by &coloumn_name;


/* 집합 연산자 */
--employees, job_history 테이블 (employee_id / job_id / deparment_id 열 같음)
select *
from employees; --107개 행

select *
from job_history; --10개 행

--UNION ALL 빼고는 다 첫번째 컬럼으로 오름차순 정렬 됨

--< UNION > : 합집합(중복값 제외)
select employee_id, job_id 
from employees              --107개행   
UNION                       --두 칼럼 중복 2개데이터 => 115개행 출력
select employee_id, job_id
from job_history;           --10개행

--< UNION ALL > : 합집합 
--*중복제거 X, 정렬도 X => 항상 정렬하려면 맨 마지막에 ORDER BY절 적기
select employee_id, job_id
from employees
UNION ALL
select employee_id, job_id
from job_history
order by employee_id;

--< INTERSECT > : 교집합(공통행 리턴
select employee_id, job_id
from employees
INTERSECT
select employee_id, job_id
from job_history;
--테이블명 순서 바껴도 결과 똑같이 나옴
select employee_id, job_id
from job_history
INTERSECT
select employee_id, job_id
from employees;

--< MINUS > : 차집합(첫번째 질의에 해당되는 값만 나옴
--=>테이블명 순서 바뀌면 결과값 다름
select employee_id, job_id
from employees
MINUS
select employee_id, job_id
from job_history;
--테이블 순서 바꿈
select employee_id, job_id
from job_history
MINUS
select employee_id, job_id
from employees;

