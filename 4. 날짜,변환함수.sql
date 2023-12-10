/* 날짜 */

--기본 형식: 한글버전 YY/MM/DD (DD/MON/YY)
--SYSDATE : 현재의 날짜&시간 반환 ( DUAL 테이블 선택 )
select sysdate
from dual;

/* < 날짜 연산 >  
  [ 날짜 + 숫자 ] : 날짜에 일수 더함
  [ 날짜 - 숫자 ] : 날짜에 일수 뺌
  [ 날짜 - 날짜 ] : 날짜에서 다른날짜 뺌
  [ 날짜 + 숫자/24 ] : 날짜에 시간 수를 더함        */

/* < 날짜 함수 >
   MONTHS_BETWEEN(날짜1, 날짜2) : 두 날짜 사이의 월 수 반환
   ADD_MONTHS(날짜열, 더할 월수) : 날짜에 월을 더함
   NEXT_DAY(날짜열, '요일') : 날짜의 다음 - 명시한 '요일'의 날짜 반환 ex.입사 03/06/17(화)=> 금요일 날짜 03/06/20 반환
   LAST_DAY(날짜열) : 해당 월의 마지막 날짜 반환
   ROUND() : 날짜 반올림
   TRUNC() : 날짜 버림                                                        */

select last_name, (SYSDATE - hire_date) / 7 WEEKS --'/ 7' 한거 외국주급계산때문에 사용 
from employees
where department_id = 90;

select employee_id, hire_date, MONTHS_BETWEEN(SYSDATE, hire_date) TENURE,
        ADD_MONTHS(hire_date,6) REVIEW, NEXT_DAY(hire_date,'금'), LAST_DAY(hire_date)
from employees;   

/* ROUND(SYSDATE, 'YEAR') : 7월 1일 0시부터 반올림
   ROUND(SYSDATE, 'MONTH') : 16일 0시부터
   ROUND(SYSDATE, 'DAY') : 수요일 낮 12시부터 (DAY는 일요일부터 시작해서 일월화/수/목금토)
   ROUND(SYSDATE, 'DD') : 낮 12시부터                 */

select ROUND(SYSDATE, 'YEAR'), ROUND(SYSDATE, 'MONTH'),
       ROUND(SYSDATE, 'DAY'), ROUND(SYSDATE, 'DD')
from dual;

/* TRUNC(SYSDATE, 'YEAR') : 현재 연도 첫날 반환
   TRUNC(SYSDATE, 'MONTH') : 현재 월 첫날
   TRUNC(SYSDATE, 'DAY') : 이번 주 (일요일부터 시작)
   TRUNC(SYSDATE, 'DD') : 오늘                    */
   
select TRUNC(SYSDATE, 'YEAR'), TRUNC(SYSDATE, 'MONTH')
      ,TRUNC(SYSDATE, 'DAY'), TRUNC(SYSDATE, 'DD')
from dual;


/* 변환함수 */
-- : 데이터 타입 변환

--암시적 데이터 유형 변환 (알아서 변환하니 신경X) 
select *
from employees
where employee_id = '101'; --문자로 쳤지만 알아서 숫자 101로 바꿔서 인식


--명시적 데이터 유형 변환
/* TO_CHAR (날짜열, '형식모델') : 칼럼의 날짜를 '이런 형식'의 문자로 바꿔라
   : 날짜 -> 문자로 바꾸는 */

ALTER SESSION SET
NLS_DATE_LANGUAGE = AMERICAN; --(그전에 날짜 형식 미국으로 잠깐 변환)
 
select employee_id, to_char(hire_date, 'MM/YY') Month_Hired
from employees;

--MONTH/Month/month .. 대소문자 구분함 ( JUNE/June/june )
select last_name, to_char(hire_date, 'DD MONTH YYYY')
from employees;

select last_name, to_char(hire_date, 'DD month YYYY')
from employees;

--'fm - ' 형식 앞에 fm 붙이면 공백 한 자리 빼고 다 제거 or 앞에 0이 있으면 0 제거
select last_name, to_char(hire_date, 'fmDD MONTH YYYY') --위에선 03 JANUARY 나왔으면 fm붙어서 3 JANUARY 출력
from employees;
--DDTH : 서수 (17th)
--DDSP : 문자로 표시한 수 (17을 SEVENTEEN) + Ddsp (Seventeenth)
--+ th, sp도 대소문자 구분 됨
select last_name, to_char(hire_date, 'fmDdspth "of" Month YYYY fmHH:MI:SS AM')
from employees;

/* TO_CHAR (숫자, '숫자형식모델')
   : 숫자 -> 문자 
     - 9 : 숫자를 표시
     - 0 : 0을 강제로 표시
     - $ : $ 기호 표시
     - L : 지역화폐 기호 표시
     - . : 명시한 위치에 소수점 표시
     - , : 명시한 위치에 구분자 표시   */

select to_char(salary, '$99,999.00') salary
from employees;

--* 제일 큰 자리수만큼 9 넣어줘야 숫자 뜸 ( 자기보다 작은 자리수로 입력되면 ###으로 표시 됨)
select to_char(salary, '$9,999.00') salary
from employees; 

-- TO_NUMBER(문자열, '형식모델') 
-- : 문자 -> 숫자로 변환 ( 이 문자는, 이런형식을 가진 숫자이다)
select to_number('$3,400', '$99,999') 
from dual;

select to_number('3400')
from dual; -- 기호 없이 숫자만 있는 문자면 형식모델 생략O

--* To_DATE(문자열, '형식모델) 
--  : 문자 -> 날짜로 (이 문자는, 이런형식을 가진 날짜입니다)
select to_date('2010년, 02월', 'YYYY"년", MM"월"')
from dual;

--입력 된 날짜 데이터 형식 어떤지 모르니까 만들어주기
--ex. 사원들 중에서 2005년 7월 1일 이후에 입사한 사원의 이름과 입사일을 출력하시오 
select last_name, hire_date
from employees
where hire_date > to_date('2005년 07월 01일', 'YYYY"년" MM"월" DD"일"');
  --where hire_date > to_date('05/07/01', 'YY/MM/DD') ('05/07/01', 'YY-MM-DD') 형태 비슷하면 알아서 적용 됨
  
--앞에 'fx- ' 붙인건 정확하게 똑같은지
select last_name, hire_date
from employees
where hire_date > to_date('05/07/01', 'fxYY/MM/DD');


/*문제*/
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
