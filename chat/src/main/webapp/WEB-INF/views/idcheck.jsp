<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<h2 >아이디 중복확인</h2>
	<form action="#" name="frm">
		아이디 <input type="text" name="userid" value="${userid }"> <input type="submit" value="중복체크"> <br>
		<c:if test="${result == 1}">
			<script type="text/javascript">
				opener.document.frm.userid.value = "";
			</script>
			${userid}는 이미 사용 중인 아이디입니다.
		</c:if>
		<c:if test="${result==-1}">
		${userid}는 사용 가능한 아이디입니다.
		<a href="javascript:id_check()"><input type="button" value="사용" class="cancel" name="vetId"></input></a>
		
		</c:if>
	</form>
	<script>
	function id_check() {

		opener.frm.userid.value=document.frm.userid.value;
		opener.frm.reid.value=document.frm.userid.value;
		self.close();
		
	}
	</script>
</body>
</html>