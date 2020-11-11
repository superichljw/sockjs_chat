<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#signupForm {
	margin: 0 auto;
}

#signupForm ul {
	list-style-type: none;
}

#signupForm {
	width: 50%;
	padding-top: 30px;
	padding-bottom: 50px;
}

#signupForm input {
	width: 300px;
	height: 20px;
	padding: 0;
}

#signupForm .idck {
	width: 80px;
	height: 24px;
	padding: 0;
	margin-left: 10px;
}

#signupForm li {
	margin-top: 10px;
}

#signupForm .addr li {
	margin-top: 10px;
}

#signupForm #extraAddress {
	width: 100px;
	margin-left: 10px;
}

#signupForm .signup-submit {
	margin-top: 80px;
	margin-left: 200px;
}
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

<script type="text/javascript">
	function idCheck() {
		if (document.frm.userid.value == "") {
			alert('아이디를 입력하여 주십시오.');
			document.frm.userid.focus();
			return;
		}
		var url = "./id_check?userid=" + document.frm.userid.value;
		window.open(url, "_blank_1", "toolbar=no, menubar=no, scrollbars=yes,"
				+ " resizable=no, width=450, height=200");

	}
</script>
</head>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
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
	<form action="./signup" name="frm" id="signupForm">
		<h1>개인회원가입</h1>
		<div>
			<ul>
				<li>아이디</li>
				<li><input type="text" class="textblock" name="userid"
					value="${userid }" /> <input type="hidden" name="reid" size="20"
					value="${reid }" /> <input type="button" value="중복체크"
					onclick="idCheck()" class="idck" /></li>
			</ul>
			<ul>
				<li>비밀번호</li>
				<li><input type="password" name="pw" style="font-family: gulim">
			</ul>
			<ul>
				<li>비밀번호 확인</li>
				<li><input type="password" name="pw_check"
					style="font-family: gulim">
			</ul>
			<ul>
				<li>이름</li>
				<li><input type="text" name="name">
			</ul>
			<ul>
				<li>주소</li>
				<li>
					<ul style="list-style-type: none; margin-left: -40px;" class="addr">
						<li><input type="text" id="postcode" placeholder="   (우편번호)"
							name="postcode" /><input type="button" value="우편번호검색"
							id="postcodeSearch" onclick="execDaumPostcode()"
							style="width: 90px; height: 24px; margin-left: 10px;" /></li>
						<li><input type="text" id="addrblock" placeholder="   (주소)"
							name="address" /><input type="text" id="extraAddress"
							placeholder="   (참고항목)" name="referAdd" /></li>
						<li><input type="text" id="detailAddress"
							placeholder="   (상세주소)" name="detailAdd" /></li>

					</ul>
				</li>
			</ul>
			<ul>
				<li>전화번호</li>
				<li><input type="text" name="phone">
			</ul>
			<ul>
				<li>생년월일</li>
				<li><input type="text" name="birth"
					placeholder="   (구분자없이 8자리 입력 (예시) 20060203)">
			</ul>
			<ul>
				<li>이메일</li>
				<li><input type="text" name="email">
			</ul>

		</div>
		<div class='signup_submit'>
			<input type="submit" onclick="return personal_check();" name="apply"
				style="margin-top: 40px; margin-left: 100px; width: 80px; height: 40px;"
				value="가입하기"> <input type="button"
				style="margin-top: 40px; margin-left: 20px; width: 80px; height: 40px;"
				value="취소하기" onclick="window.location.reload(true)">
		</div>
	</form>
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
		// 다음 주소검색

		function execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								// 조합된 참고항목을 해당 필드에 넣는다.
								document.getElementById("extraAddress").value = extraAddr;

							} else {
								document.getElementById("extraAddress").value = '';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('postcode').value = data.zonecode;
							document.getElementById("addrblock").value = addr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("detailAddress").focus();
						}
					}).open();
		}
	</script>
</body>
</html>