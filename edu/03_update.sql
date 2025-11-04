-- UPDATE 문

UPDATE employees
SET 
	fire_at = NOW()
	,deleted_at = NOW()
WHERE
	emp_id = 100005
;

-- SELECT 문으로 작성하여 불러오는 데이터가 맞는지 확인 후 UPDATE로 변경
UPDATE employees
SET 
	fire_at = NOW()
	,delete_at = NOW()
WHERE 
	emp_id = 100005
;

UPDATE salaries
SET 
	salary = 30000000
WHERE
	sal_id = 1022176
;
		
	
