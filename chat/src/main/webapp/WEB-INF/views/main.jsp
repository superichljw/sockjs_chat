<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
#main-body {
	width: 70%;
	margin: 0 auto;
}

#main-index {
	list-style-type: none;
}

#main-index li {
	width: 200px;
	height: 40px;
}

#main-body li:hover {
	cursor: pointer;
}

#main-body h1:hover {
	cursor: pointer;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<div id="main-body">
		<h1 onclick="location.href='./'">채팅서비스</h1>
		<ul id="main-index">
			<li onclick="location.href='./signup_page'">회원가입</li>
			<c:choose>
				<c:when test="${empty loginUser }">
					<li onclick="location.href='./loginPage'">로그인</li>
				</c:when>
				<c:otherwise>
					<li>${loginUser.userId }(${loginUser.userName })</li>
					<li onclick="location.href='./logout'">로그아웃</li>
				</c:otherwise>
			</c:choose>

			<li onclick="location.href='./room'">채팅방</li>
		</ul>
	</div>
</body>
</html>