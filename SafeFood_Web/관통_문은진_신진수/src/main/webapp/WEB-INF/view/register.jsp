<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="utf-8">
<head>
<!-- Theme Made By www.w3schools.com - No Copyright -->
<title>회원가입.</title>
<meta charset="utf-8">
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
	<c:url value="/register" var="register"/>
	<form method="post" action="${register}" style="border: 1px solid #ccc">
		<div class="container">
			<h1>회원가입</h1>
			<p>안전먹거리 project의 회원가입페이지 입니다.</p>
			<hr>

			<label for="id"> <b>아이디</b>
			</label> <input type="text" id="id" placeholder="아이디 입력" name="id" required>

			<label for="pw1"> <b>비밀번호</b>
			</label> <input type="password" id="pw1" placeholder="영문,숫자 포함 6자리 이상"
				name="password" required> <label for="pw2"> <b>비밀번호
					확인</b>
			</label> <input type="password" id="pw2" placeholder="비밀번호확인" name="pw2"
				required> <label for="name"> <b>이름</b>
			</label> <input type="text" id="name" placeholder="이름" name="name" required>

			<label for="adress"> <b>주소</b>
			</label> <input type="text" id="address" placeholder="주소" name="address" required>

			<label for="phone"> <b>전화번호</b>
			</label> <input type="text" id="phone" placeholder="010-xxxx-xxxx"
				name="phone" required> <label for="allergy"> <b>알레르기</b>
			</label>
			<fieldset style="border: 1">
				<legend>Check</legend>

				<label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="bighead"> 대두
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="pinut"> 땅콩
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="milk"> 우유
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="crab"> 게
				</label> <br> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="shrimp"> 새우
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="tuna"> 참치
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="salmon"> 연어
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="ssook"> 쑥
				</label> <br> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="beef"> 소고기
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="chicken"> 닭고기
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="pork"> 돼지고기
				</label> <br> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="peach"> 복숭아
				</label> <label class="checkbox-inline"> <input class="al"
					name="allergy" type="checkbox" value="mindulle"> 민들레
				</label> <label class="checkbox-inline"> <input class="al"
					type="checkbox" value="eggWhite"> 계란흰자
				</label>
			</fieldset>
			<br>
			<c:url var="index" value="/index"></c:url>
			<div class="clearfix">
				<button type="button" class="cancelbtn" onclick="location.href='${index}'">취소</button>
				<button type="submit" class="signupbtn">가입하기</button>
			</div>
		</div>
	</form>

</body>


</html>
