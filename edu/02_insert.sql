-- INSERT 문
-- 신규 데이터를 저장하기위해 사용하는 문
-- 실행할 때마다 들어감
INSERT INTO employees(
	`name`
	,birth
	,gender
	,hire_at
	,fire_at
	,sup_id
	,created_at
	,updated_at
	,deleted_at	
)
VALUES(
	'백미지'
	,'1999-01-19'
	,'F'
	,'2025-10-31'
	,NULL
	,NULL
	,NOW()
	,NOW()
	,NULL
);



SELECT *
FROM employees
WHERE
	`name` = '백미지'
	AND birth = '1999-01-19'
	AND hire_at = '2025-10-31'
;

-- 자신의 연봉 데이터 넣기 
INSERT INTO salaries(
	emp_id
	,salary
	,start_at

)
VALUES
(	
	100005
	,28965232
	,NOW()


);

-- SELECT INSERT
INSERT INTO salaries (
	emp_id
	,salary
	,start_at
)
SELECT 
	emp_id
	,30000000 AS salary
	,created_at
FROM employees
WHERE
	`name` = '백미지'
	AND birth = '1999-01-19'
	AND hire_at = '2025-10-31'
;

SELECT