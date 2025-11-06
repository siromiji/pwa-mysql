-- DB생성 (이름 전부 소문자로 씀)

CREATE DATABASE mydb;

-- DB 선택
USE mydb;

-- DB 삭제
DROP DATABASE mydb;

-- 스키마(구조) : CREATE(생성), ALTER(수정), DROP(없애기)
-- DDL 구조와 관련된 조작언어
-- DML 데이터에 관련된 언어 


-- ------------
-- 테이블 생성
-- ------------
-- unsigned :양수만
-- AUTO_INCREMENT: 자동으로 1씩 올림
-- VARCHAR : 가변길이 30~50
-- CHAR : 가변 길이가 고정되어 있음
-- COMMENT:설명을 달 수 있음

CREATE TABLE users(
	id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,`name` VARCHAR(30) NOT NULL COMMENT '이름'
	,gender CHAR(1) NOT NULL COMMENT 'F=여자 M=남자'
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at DATETIME 
);

-- 게시글 테이블
-- pk, 유저번호,제목,내용,작성일,수정일,삭제일
CREATE TABLE posts(

	id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,user_id BIGINT UNSIGNED NOT NULL  
	,title VARCHAR(30) NOT NULL
	,content VARCHAR(500) NOT NULL
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP() 
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP() 
	,deleted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP() 
);


-- -----------
-- 테이블 수정
-- -------------
-- FK 추가방법
-- ALERT TABLE [테이블명]
-- ADD CONSTRAINT [Constraint명]
-- FOREING KEY (Constrain 부여 컬럼명)
-- REFERENCES 참조 테이블명 (참조 테이블 컬럼명)
-- [ON DELETE 동작 / ON UPDATE 동작]

ALTER TABLE posts 
	ADD CONSTRAINT fk_posts_user_id
		FOREIGN KEY  (user_id)
		REFERENCES users(id)
	;
	
-- FK를 삭제
-- add로 추가 drop으로 삭제 

ALTER TABLE posts
DROP CONSTRAINT fk_posts_user_id
;

-- --------
-- 컬럼추가
-- ------------

ALTER TABLE posts
ADD COLUMN image VARCHAR(100) 
;	

-- --------
-- 컬럼제거
-- ------------

ALTER TABLE posts
DROP COLUMN image
;

-- --------
-- 컬럼수정
-- ------------
ALTER TABLE users
MODIFY COLUMN gender VARCHAR(10) NOT NULL COMMENT '남자,여자,미선택'
;

-- --------
-- AUTO_INCREMENT 값 변경
-- -----------
ALTER TABLE users AUTO_INCREMENT = 10;


-- ----------------
-- 테이블 삭제
-- -----------------

DROP TABLE posts;
DROP TABLE users;


-- ------------
-- 테이블의 모든 데이터 삭제
-- 되돌릴 방법 없음 되도록 사용 X
-- ----------------
TRUNCATE TABLE salaries;













