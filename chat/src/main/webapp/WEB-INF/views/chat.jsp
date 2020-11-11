<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Chating</title>
<style>
* {
	margin: 0;
	padding: 0;
}

.container {
	width: 500px;
	margin: 0 auto;
	padding: 25px
}

.container h1 {
	text-align: left;
	padding: 5px 5px 5px 15px;
	color: #FFBB00;
	border-left: 3px solid #FFBB00;
	margin-bottom: 20px;
}

.chatting-room {
	background-color: #000;
	width: 500px;
	height: 500px;
	overflow: auto;
}

.chatting-room p {
	color: #fff;
	text-align: left;
}

.chatting-room .me {
	color: #F6F6F6;
	text-align: right;
}

.chatting-room .others {
	color: #FFE400;
	text-align: left;
}

input {
	width: 330px;
	height: 25px;
}

/* #yourMsg {
	display: none;
} */
.msgImg {
	width: 200px;
	height: 125px;
}

.clearBoth {
	clear: both;
}

.img {
	float: right;
}
</style>
</head>

<script src="http://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script type="text/javascript">
	var sock = new SockJS("<c:url value='/wsocket?roomNumber=${roomNumber}'/>");

	sock.onopen = function onOpen() {
		$("#chatting-room")
				.append(
						"<p style='text-align:center;'>${loginUser.userName} 님이 입장하였습니다</p>");
	}
	sock.onmessage = onMessage;
	sock.onclose = onClose;

	document.addEventListener("keypress", function(e) {
		if (e.keyCode == 13) { //enter press
			sendMessage();
		}
	});
	function onMessage(evt) {
		var data = evt.data;
		if (data != null && data.trim() != '') {

			var d = JSON.parse(data);
			if (d.type == "getId") {
				var si = d.sessionId != null ? d.sessionId : "";
				if (si != '') {
					$("#sessionId").val(si);
				}
			} else if (d.type == "message") {
				if (d.sessionId == $("#sessionId").val()) {
					$("#chatting-room").append(
							"<p class='me'>나 (" + d.userName + ") :" + d.msg
									+ "</p>");
				} else {
					$("#chatting-room").append(
							"<p class='others'>" + d.userName + " :" + d.msg
									+ "</p>");
				}

			} else {
				console.warn("unknown type!")
			}
		}
	}
	function onClose(evt) {
		$("#chatting-room").append(
				"<p style='text-align:center;'> 서버 연결 끊김 </p>");
	}

	function sendMessage() {
		var option = {
			type : "message",
			roomNumber : $("#roomNumber").val(),
			sessionId : $("#sessionId").val(),
			userName : $("#userid").val(),
			msg : $("#chatting").val()
		}
		sock.send(JSON.stringify(option));
		$('#chatting').val("");
	}
</script>
<body>
	<div id="container" class="container">
		<h1>${roomName}의채팅방</h1>
		<input type="hidden" id="sessionId" value=""> <input
			type="hidden" id="roomNumber" value="${roomNumber}">
		<div id="chatting-room" class="chatting-room"></div>

		<div id="yourMsg">
			<table class="inputTable">
				<tr>
					<th>메시지</th>
					<th><input type="hidden" id="userid"
						value="${loginUser.userId }"></th>
					<th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
					<th><button onclick="sendMessage()" id="sendBtn">보내기</button></th>
				</tr>

			</table>
		</div>
	</div>
</body>
</html>