-- TRANSACTION

-- 트랜잭션 시작
START TRANSACTION;

-- insert
INSERT INTO employees (`name`,birth,gender,hire_at)
VALUES ('미어캣','2000-01-01','M', DATE(NOW()))
;

-- SELECT
SELECT * FROM employees WHERE `name` = '미어캣';

-- ROLLBACK
ROLLBACK;

-- COMMIT
COMMIT;


