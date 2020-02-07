<%@page import="java.util.*"%>
<%@page import="com.ssafy.model.dto.User"%>
<%@page import="com.ssafy.model.dto.Food"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}

* {
	box-sizing: border-box
}

/* Full-width input fields */
input[type=text], input[type=password] {
	width: 100%;
	padding: 15px;
	margin: 5px 0 22px 0;
	display: inline-block;
	border: none;
	background: #f1f1f1;
}

input[type=text]:focus, input[type=password]:focus {
	background-color: #ddd;
	outline: none;
}

hr {
	border: 1px solid #f1f1f1;
	margin-bottom: 25px;
}

/* Set a style for all buttons */
button {
	background-color: #4CAF50;
	color: white;
	padding: 14px 20px;
	margin: 8px 0;
	border: none;
	cursor: pointer;
	width: 100%;
	opacity: 0.9;
}

button:hover {
	opacity: 1;
}

/* Extra styles for the cancel button */
.cancelbtn {
	padding: 14px 20px;
	background-color: #f44336;
}

/* Float cancel and signup buttons and add an equal width */
.cancelbtn, .signupbtn {
	float: left;
	width: 50%;
}

/* Add padding to container elements */
.container {
	padding: 16px;
}

/* Clear floats */
.clearfix::after {
	content: "";
	clear: both;
	display: table;
}

/* Change styles for cancel button and signup button on extra small screens */
@media screen and (max-width: 300px) {
	.cancelbtn, .signupbtn {
		width: 100%;
	}
}

fieldset {
	border: 1;
}
</style>
</head>
<body>

	<%
		User user = (User) session.getAttribute("loginUser");
	%>
	<c:url value="/mypage" var="mypage" />
	<form method="post" action="${mypage}" style="border: 1px solid #ccc">
		<div class="container">
			<h1><%=user.getId()%>님의 마이페이지
			</h1>
			<p>안전먹거리 project의 회원정보페이지 입니다.</p>
			<hr>

			<label for="id"> <b>아이디</b>
			</label> <input type="text" id="id" name="id" value="<%=user.getId()%>"
				readonly="readonly"> <label for="pw1"> <!-- 				<b>비밀번호</b> -->
			</label> <input type="password" id="pw1" name="password"
				value="<%=user.getPassword()%>"> <label for="pw2"> <!-- 				<b>비밀번호 확인</b> -->
			</label> <input type="password" id="pw2" placeholder="비밀번호확인" name="pw2"
				value="<%=user.getPassword()%>"> <label for="name">
				<b>이름</b>
			</label> <input type="text" id="name" name="name" value="<%=user.getName()%>">

			<label for="adress"> <b>주소</b>
			</label> <input type="text" id="addr" name="address"
				value="<%=user.getAddress()%>"> <label for="phone">
				<b>전화번호</b>
			</label> <input type="text" id="phone" name="phone"
				value="<%=user.getPhone()%>"> <label for="allergy">
				<b>알레르기</b>
			</label>
			<fieldset style="border: 1">
				<legend>Check</legend>

				<label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="bighead" id="bighead">
					대두
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="pinut" id="pinut"> 땅콩
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="milk" id="milk"> 우유
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="crab" id="crab"> 게
				</label> <br> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="shrimp" id="shrimp">
					새우
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="tuna" id="tuna"> 참치
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="salmon" id="salmon">
					연어
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="ssook" id="ssook"> 쑥
				</label> <br> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="beef" id="beef"> 소고기
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="chicken" id="chicken">
					닭고기
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="pork" id="pork"> 돼지고기
				</label> <br> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="peach" id="peach">
					복숭아
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="mindulle" id="mindulle">
					민들레
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="eggWhite" id="eggWhite">
					계란흰자
				</label>
			</fieldset>
			<br>

			<c:url value="/index" var="main" />
			<c:url value="/bye" var="bye" />
			<div class="clearfix">
				<button type="button" class="cancelbtn"
					onclick="location.href = '${main}'">돌아가기</button>
				<button type="submit" class="signupbtn">수정하기</button>
				<button type="button" class="btn btn-info"
					onclick="location.href='${bye}'">탈퇴하기</button>
			</div>
		</div>
	</form>
</body>
<script>
	function load() {
<%List<String> allergy = user.getAllergy();
			Map<String, String> map = new HashMap<>();
			map.put("대두", "bighead");
			map.put("땅콩", "pinut");
			map.put("우유", "milk");
			map.put("게", "crab");
			map.put("새우", "shrimp");
			map.put("참치", "tuna");
			map.put("연어", "salmon");
			map.put("쑥", "ssook");
			map.put("소고기", "beef");
			map.put("닭고기", "chicken");
			map.put("돼지고기", "pork");
			map.put("복숭아", "peach");
			map.put("민들레", "mindulle");
			map.put("계란흰자", "eggWhite");
			for (int i = 0; i < allergy.size(); i++) {
				request.setAttribute("change", map.get(allergy.get(i)));%>
	$("#${change}").prop("checked", true);
<%}%>
	};
	load();
</script>
</html>