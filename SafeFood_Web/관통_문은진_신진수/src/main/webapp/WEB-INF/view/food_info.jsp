<%@page import="com.ssafy.model.dto.User"%>
<%@page import="com.ssafy.model.dto.Food"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="utf-8">
<head>
<!-- Theme Made By www.w3schools.com - No Copyright -->
<title>SafeFood_Web_Front_GJ_02_문은진_신진수</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css?family=Jua"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Kaushan+Script"
	rel="stylesheet">


<c:url var="css" value="/static/css" />
<link rel="stylesheet" href="${css}/indexcss.css">
<link rel="stylesheet" href="${css}/card.css">
<!-- Custom styles for this template -->
<!--   <link href="css/small-business.css" rel="stylesheet"> -->
<style>
.card-body {
	padding: 1.6rem;
}

.jumbotron2 {
	text-shadow: 2px 2px 3px cadetblue;
	background-image:
		url(http://www.juliengoniche.com/img/Fotolia_96148349_Subscription_Monthly_M.jpg);
	color: #9ce9d7;
}

.jumbotron2>h2 {
	font-size: 50px;
	font-family: 'Kaushan Script', cursive;
}

.jumbotron2>p {
    color: dimgray;
font-size: 28px;
	font-family: 'Kaushan Script', cursive;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>


	<div class="jumbotron2 text-center">
		<h2>WHAT WE PROVIDE</h2>
		<p>건강한 삶을 위한 먹거리 프로젝트</p>
		<c:url var="search" value="/infosearch" />
		<form class="form-inline" method="get" action="${search}">
			<div class="input-group">
				<div class="input-group-btn">
					<div id="search-option" class="btn btn-danger2">검색조건</div>
				</div>
				<select class="form-control" id="sorted" name="key">
					<option value="name" selected="selected">상품명</option>
					<option value="maker">제조사</option>
					<option value="material">성분명</option>
				</select>
			</div>
			<div class="input-group">
				<input id="search-text" type="text" class="form-control" size="50"
					placeholder="검색어를 입력하세요." name="word">
				<div class="input-group-btn">
					<button id="search" type="submit" class="btn btn-danger2">검색</button>
				</div>
			</div>

		</form>
	</div>
	<c:url value="/static/" var="staticurl" />

	<div class="container-fluid" style="width: 80%">

		<h2 class="my-4">상품 정보</h2>
		<div class="row" id="dataarea"></div>
		<div class="card-deck">
			<c:set var="count" value='0' />
			<c:forEach var="food" items="${foodList}">
				<c:set var="count" value='${count+1}' />
				<div class='col-lg-6 mb-6' id='foodinfo'>
					<div class='card h-100'>
						<h4 class='card-header'>'${food.name}'</h4>
						<div class='card-body'>
							<div class='row'>
								<div class='col-lg-6 mb-6 container'>
									<div>
										<c:url var="detail" value="/detail"></c:url>
										<a href='${detail}/?code=${food.code}'><img
											class='card-img-top img-fluid rounded'
											src='${staticurl}${food.img}' style="width: 100%"></a>
									</div>
									<div class='overlay align-bottom'>
										<div class='text'>
											'${food.name}' <br>'${food.maker}'
										</div>
									</div>
								</div>
								<div class='col-lg-6 mb-6'>
									<p class='card-text'>'${food.material}'</p>
								</div>
							</div>
						</div>
						<c:url var="eat" value="/eat"></c:url>
						<div class='card-footer'>
						 	<c:url var="moreeat" value="/moreeat"></c:url>
						 <a class='btn btn-primary' href='${moreeat}?code=${food.code}&count=1' id='cartinsert'>섭취추가 <span
							class='glyphicon glyphicon-plus'></span></a>
						<a class='btn btn-primary eat' id='${food.code}'
							href='${eat}?code=${food.code}'>찜 추가 <span
							class='glyphicon glyphicon-shopping-cart'></span></a> 
						
							<c:if test="${!empty loginUser.allergy}">
								<div class="divider" ></div>	
								<c:forEach var="userAllergy" items='${loginUser.allergy}'>
									<c:forEach var="foodAllergy" items='${food.allergy}'>
										<c:if test="${userAllergy eq foodAllergy}">
											<button type='button' class='btn btn-danger' style="margin-top:10px;">
												<span class='glyphicon glyphicon-exclamation-sign'></span>
												${userAllergy}
											</button>
										</c:if>
									</c:forEach>
								</c:forEach>
							</c:if>
						</div>
					</div>
				</div>
				<c:if test="${count%2==0}">
					<div style="width: 100%; padding: 10px"></div>
				</c:if>
			</c:forEach>
		</div>
	</div>



	<jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>


</body>
</html>
