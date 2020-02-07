<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
#box {
	width: 350px;
	hight: 350px;
	background-color: #c8d7ff;
}
</style>
<body>
	<h3>비밀번호 찾습니다.</h3>

	<c:url var="getpass" value="/getpass"></c:url>
	<form method="get" action="${getpass }" style="border: 1px solid #ccc">
		<input type="hidden" name="action" value="findpass">
		 아이디를 입력하세요 <input type = "text" name="id"> <br>
		 전화번호를 입력하세요 <input type ="text" name = "phone">
		 <button type="submit">비밀번호 찾기</button>
		</form>
	<% String pass = (String) session.getAttribute("pass"); 
	if(pass!=null){
		%>
		<h3>비밀번호 : <%=pass %></h3>
		<% 
	}
		%>	
	<c:url var="index" value="/index"></c:url>
	<a href = "${index}">메인페이지로가기</a>
		
			
</body>
</html>