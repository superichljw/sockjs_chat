<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Room</title>
<style>

.container {
	width: 500px;
	margin: 0 auto;
	padding: 25px
}

.container h1 {
	text-align: left;
	padding: 5px 5px 5px 15px;
	color: lightblue;
	border-left: 3px solid lightblue;
	margin-bottom: 20px;
}

.roomContainer {
	background-color: #F6F6F6;
	width: 500px;
	height: 500px;
	overflow: auto;
}

.roomList {
	border: none;
}

.roomList th {
	border: 1px solid lightblue;
	background-color: #fff;
	color: black;
}

.roomList td {
	border: 1px solid lightblue;
	background-color: #fff;
	text-align: left;
	color: black;
}

.roomList .num {
	width: 75px;
	text-align: center;
}

.roomList .room {
	width: 350px;
}

.roomList .go {
	width: 71px;
	text-align: center;
}

button {
	background-color: lightblue;
	font-size: 14px;
	color: black;
	border: 1px solid #000;
	border-radius: 5px;
	padding: 3px;
	margin: 3px;
}

.inputTable th {
	padding: 5px;
}

.inputTable input {
	width: 330px;
	height: 25px;
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

#main-index li:hover {
	cursor: pointer;
}

#main-body h1:hover {
	cursor: pointer;
}
</style>
</head>
<script src="http://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script type="text/javascript">
	window.onload = function() {
		getRoom();
		createRoom();
	}

	function getRoom() {
		commonAjax('./getRoom', "", 'post', function(result) {
			createChatingRoom(result);
		});
	}

	function createRoom() {
		$("#createRoom").click(function() {
			var msg = {
				roomName : $('#roomName').val()
			};

			commonAjax('./createRoom', msg, 'post', function(result) {
				createChatingRoom(result);
			});

			$("#roomName").val("");
		});
	}

	function goRoom(number, name) {
		var url = "./moveChating?roomName=" + name + "&" + "roomNumber="
				+ number;
		window
				.open(url, "roomPopup",
						"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=550, height=660")
		/* location.href = "./moveChating?roomName=" + name + "&" + "roomNumber="
				+ number; */
	}

	function createChatingRoom(res) {
		if (res != null) {
			var tag = "<tr><th class='num'>순서</th><th class='room'>방 이름</th><th class='go'></th></tr>";
			res
					.forEach(function(d, idx) {
						var rn = d.roomName;

						var roomNumber = d.roomNumber;
						tag += "<tr>"
								+ "<td class='num'>"
								+ (idx + 1)
								+ "</td>"
								+ "<td class='room'>"
								+ rn
								+ "</td>"
								+ "<td class='go'><button type='button' onclick='goRoom(\""
								+ roomNumber + "\", \"" + rn
								+ "\")'>참여</button></td>" + "</tr>";
					});
			$("#roomList").empty().append(tag);
		}
	}

	function commonAjax(url, parameter, type, calbak, contentType) {
		$.ajax({
			url : url,
			data : parameter,
			type : type,
			contentType : contentType != null ? contentType
					: 'application/x-www-form-urlencoded; charset=UTF-8',
			success : function(res) {
				calbak(res);
			},
			error : function(err) {
				console.log('error-11');
				calbak(err);
			}
		});
	}
</script>
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
	<div class="container">
		<h1>채팅방</h1>
		<h3>${loginUser.userId }(${loginUser.userName })</h3>
		<div id="roomContainer" class="roomContainer">
			<table id="roomList" class="roomList"></table>
		</div>
		<div>
			<table class="inputTable">
				<tr>
					<th>방 제목</th>
					<th><input type="text" name="roomName" id="roomName"></th>
					<th><button id="createRoom">방 만들기</button></th>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>