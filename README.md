# sockjs_chat
webchat-with-sockjs

- oracle db
- id: houschool
- pw: 1234

table info

--chat 프로젝트 테이블
create sequence chat_seq start with 1 increment by 1;

create table chat(
userId varchar2(30) primary key,--아이디
userPw varchar2(30),--비번
userName varchar2(30),--이름
userAdres varchar2(150),--주소
userPhone varchar2(20),--연락처
userDate date,--생년월일
userEmail varchar2(50)--이메일 
);
