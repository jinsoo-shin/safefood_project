<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
</head>
<body>
	<c:url value="/index" var="index" />
	<a href="${index}">시작하기</a>
	<script>
		location.href ="${index}";
	</script>
</body>
</html>

