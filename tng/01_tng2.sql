-- SELECT문의 기본 구조
SELECT [DISTINCT] [컬럼명]
FROM [테이블명]
WHERE [쿼리 조건]
GROUP BY [컬럼명] HAVING [집계함수 조건]
ORDER BY [컬럼명 ASC || 컬럼명 DESC]
LIMIT [n] OFFSET [n]
;


-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.

SELECT 
	emp.emp_id
	,emp.`name`
	,ti.title_code
FROM employees emp
	JOIN title_emps ti
	ON emp.emp_id = ti.emp_id
	AND ti.end_at IS NULL
;



-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT 
	emp.emp_id
	,emp.gender
	,sal.salary
FROM employees emp
	JOIN salaries sal
	ON emp.emp_id = sal.emp_id
	AND sal.end_at IS NULL
;
-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
	SELECT 
		emp.`name`
		,sal.start_at
		,sal.end_at
		,sal.salary
	FROM employees emp
	JOIN salaries sal
	ON emp.emp_id = sal.emp_id
	AND sal.emp_id = 10010
ORDER BY sal.start_at ASC

;
-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.

	SELECT
		emp.emp_id
		,emp.`name`
		,dep.dept_name
	FROM employees emp
		JOIN department_emps detem
		ON emp.emp_id = detem.emp_id
		AND detem.end_at IS NULL
			JOIN departments dep
			ON  detem.dept_code = dep.dept_code
;	
	
-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
	SELECT 
		emp.emp_id
		,emp.`name`
		,sal.salary	
	FROM employees emp
		JOIN salaries sal
	 ON emp.emp_id = sal.emp_id
	 AND emp.fire_at IS NULL
	 AND sal.end_at IS NULL
	ORDER BY sal.salary DESC 
	LIMIT 10
;
	SELECT 
		emp.emp_id
		,emp.`name`
		,tmp_sal.salary	
	FROM employees emp
		JOIN(
			SELECT
				sal.emp_id
				,sal.salary
				FROM salaries sal
				WHERE
					sal.end_at IS NULL
					ORDER BY sal.salary DESC
					LIMIT 10
		)		tmp_sal
				ON emp.emp_id = tmp_sal.emp_id
ORDER BY tmp_sal.salary DESC
;
	
-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
	SELECT
		emp.`name`
		,emp.hire_at
		,dept.dept_name
		
		FROM employees emp
		JOIN department_managers dema
		ON emp.emp_id = dema.emp_id
		AND dema.end_at IS NULL
			JOIN departments dept
			ON dema.dept_code = dept.dept_code
		AND dema.end_at IS NULL
	ORDER BY dept.end_at IS NULL
					
;
-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
	SELECT 
		AVG(sal.salary) avg_sal
		,title.title
	FROM title_emps titleemp
	JOIN titles title
	ON titleemp.title_code = title.title_code
	AND title.title = '부장'
		JOIN salaries sal
		ON titleemp.emp_id = sal.emp_id
;
-- 현재 각 부장별 이름, 연봉평균
	SELECT 
		emp.`name`
		,AVG(sal.salary) sal_avg
	FROM title_emps titleemp
	JOIN titles title
	ON titleemp.title_code = title.title_code
	AND title.title = '부장'
		JOIN salaries sal
		ON titleemp.emp_id = sal.emp_id
		AND sal.end_at IS NULL
			JOIN employees emp
			ON sal.emp_id = emp.emp_id
	GROUP BY emp.`name`
	;
	

			

	-- ▼ 선생님 풀이
	
	SELECT 
		emp.`name`
		,AVG(sal.salary)
	FROM titles tit
		JOIN title_emps tite
			ON tit.title_code = tite.title_code
			AND tit.title = '부장'
			AND tite.end_at IS NULL
		JOIN employees emp
			ON emp.emp_id = tite.emp_id
			AND emp.fire_at IS NULL
		JOIN salaries sal
			ON emp.emp_id = sal.sal_id
GROUP BY sal.emp_id , emp.`name`

;



	SELECT 
		emp.`name`
		,sub_salaries.avg_sal
	FROM employees emp
		JOIN(
			SELECT
			sal.emp_id
			,AVG(sal.salary) avg_sal
			FROM title_emps tite
				JOIN titles tit
					ON tite.title_code = tit.title_code
					AND tit.title = '부장'
					AND tite.end_at IS NULL
				JOIN salaries sal
					ON sal.emp_id = tite.emp_id
			GROUP BY sal. emp_id		
		) sub_salaries
			ON emp.emp_id = sub_salaries.emp_id
			AND emp.fire_at IS NULL
		
;
		
		
		
-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.

	SELECT 
		emp.`name`
		,sal.start_at
		,emp.emp_id
		,titleemp.title_emp_id
	FROM employees emp
		JOIN department_managers dema
			ON emp.emp_id = dema.emp_id
		JOIN departments dept
			ON dema.dept_code = dept.dept_code
		JOIN title_emps titleemp
			ON titleemp.emp_id = emp.emp_id
		JOIN titles title
			ON titleemp.title_code = title.title_code 
			AND title.title LIKE '%장'
		JOIN salaries sal
			ON emp.emp_id = sal.emp_id
	;
		-- ▼ 선생님 풀이

	SELECT 
		emp.`name`
		,emp.hire_at
		,emp.emp_id
		,depm.dept_code
	FROM department_managers depm
	JOIN employees emp
		ON depm.emp_id = emp.emp_id
;

		
		
		
-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을
--		평균연봉 내림차순으로 출력해 주세요.
SELECT 
		temp.title_code
		,tit.title
		,AVG(sal.salary) AS avg_sal
		FROM salaries sal
			JOIN title_emps temp
			ON temp.emp_id = sal.emp_id
				JOIN titles tit
				ON tit.title_code = temp.title_code
			GROUP BY temp.title_code
			HAVING AVG(sal.salary) >= 60000000 
									 
;			
		-- ▼ 선생님 풀이
		SELECT 
			tit.title
			,CEILING (AVG(sal.salary)) avg_sal
		FROM salaries sal
			JOIN title_emps tite
				ON sal.emp_id = tite.emp_id
				AND sal.end_at IS NULL
				AND tite.end_at IS NULL
			JOIN titles tit
				ON tit.title_code = tite.title_code
		GROUP BY tit.title
			HAVING avg_sal >= 60000000 
		ORDER BY avg_sal DESC 
;
			
		
		
-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
	SELECT 
		tit.title
		,COUNT(emp.gender) cntgen
		FROM employees emp
			JOIN title_emps timp
			ON emp.emp_id = timp.emp_id
			AND gender = 'F'
				JOIN titles tit
				ON timp.title_code = tit.title_code
				GROUP BY timp.title_code
;				
				-- ▼ 선생님 풀이		
	
	SELECT 
		tite.title_code
		,emp.gender
		,COUNT(*) cnt_f_emp
	FROM employees emp
		JOIN title_emps tite
			ON emp.emp_id = tite.emp_id
			AND emp.fire_at IS NULL
			AND emp.fire_at IS NULL
-- 			AND emp.gender = 'F'
	GROUP BY tite.title_code, emp.gender
	ORDER BY tite.title_code ASC, emp.gender ASC
	;
			