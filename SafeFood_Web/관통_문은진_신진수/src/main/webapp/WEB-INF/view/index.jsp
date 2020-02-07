<%@page import="com.ssafy.model.dto.User"%>
<%@page import="com.ssafy.model.dto.Food"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SafeFood_Web_Front_GJ_02_문은진_신진수</title>
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
<style>

.jumbotron2 {
	text-shadow: 2px 2px 3px cadetblue;
	background-image:
 		url(http://www.juliengoniche.com/img/Fotolia_96148349_Subscription_Monthly_M.jpg); 
/* 		url(https://i.kinja-img.com/gawker-media/image/upload/s---izHO4zf--/c_fit,fl_progressive,q_80,w_636/wojsrqpmxrfhjajjzaz6.gif); */
/* 	url("/WEB-INF/static/img/finger.gif");  */
		
	color: #9ce9d7;
}

.jumbotron2>h1 {
	font-size: 50px;
	font-family: 'Kaushan Script', cursive;
}

.jumbotron2>p {
    color: dimgray;
font-size: 28px;
	font-family: 'Kaushan Script', cursive;
}
#search-rank>table{
background: lightsteelblue;
}
#search-rank{
	z-index: 5;
	color:black;
    position: absolute;
    width: 88%;
 	height: 100%;
   margin-top: 34px;
 display:none;   
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>

<%-- 	<c:url var="mainimg" value="/static/img/finger.gif" /> --%>
<%-- 	<div class="jumbotron2 text-center" style="background-image:url(${mainimg});"> --%>
	<c:url value="/static/" var="staticurl" />
	<div class="jumbotron2 text-center">
		<h1>WHAT WE PROVIDE</h1>
		<p>건강한 삶을 위한 먹거리 프로젝트</p>
		<c:url var="search" value="/indexsearch" />
		<form class="form-inline" method="get" action="${search}">
			<div class="input-group">
				<div class="input-group-btn">
					<div id="search-option" class="btn btn-danger2">검색조건</div>
				</div>
				<select class="form-control"  id="sorted" name="key">
					<option value="name" selected="selected">상품명</option>
					<option value="maker">제조사</option>
					<option value="material">성분명</option>
				</select>
			</div>
			<div class="input-group">
				<input id="search-text" type="text" class="form-control" size="50"
					placeholder="검색어를 입력하세요." name="word"  autocomplete=off>
				<div id="search-rank">
					<c:set var="count" value='0' />
					<table class="table">
						<c:forEach var="fname" items="${rank} ">
						<c:set var="count" value='${count+1}' />
						<tr>
							<td>
						<img class='img-fluid rounded' src='${staticurl}img/${count}.jpg' style="width:50px" >
							</td>
							<td class="text-center" style="vertical-align: middle; "><h4>${fname}</h4></td>
						</tr>
						</c:forEach>
						
					</table>
				</div>
				<div class="input-group-btn">
					<button id="search" type="submit" class="btn btn-danger2">검색</button>
				</div>
			</div>

		</form>
	</div>
	<!-- 상품정보 -->
	<div class="container-fluid" style="position: relative; z-index:3; width: 80%">
		<div>
			<h2>상품정보</h2>
		</div>
		<div id="product">
			<c:forEach var="food" items="${foodList}">
				<div class='row'>
					<div class='col-md-offset-1  col-md-3 container'>
						<div>
							<c:url var="detail" value="/detail"></c:url>
							<a href='${detail}/?code=${food.code}'> <img
								class='img-fluid rounded' src='${staticurl}${food.img}'
								style="width: 100%"></a>
						</div>
						<div class='overlay align-bottom'>
							<div class='text'>
								'${food.name}' <br>'${food.maker}'
							</div>
						</div>
					</div>
					<div class='col-md-8'>
						<h3>'${food.name}'</h3>
						<p>'${food.material}'</p>
						<c:url var="eat" value="/eat"></c:url>
						<c:url var="moreeat" value="/moreeat"></c:url>
						 <a class='btn btn-primary' href='${moreeat}?code=${food.code}&count=1' id='cartinsert'>섭취추가 <span
							class='glyphicon glyphicon-plus'></span></a>
						<a class='btn btn-primary eat' id='${food.code}'
							href='${eat}?code=${food.code}'>찜 추가 <span
							class='glyphicon glyphicon-shopping-cart'></span></a> 

						<c:if test="${!empty loginUser.allergy}">
							<div class="divider"  ></div>
							<c:forEach var="userAllergy" items='${loginUser.allergy}'>
								<c:forEach var="foodAllergy" items='${food.allergy}'>
									<c:if test="${userAllergy eq foodAllergy}">
										<button type='button' class='btn btn-danger'  style="margin-top:10px;">
											<span class='glyphicon glyphicon-exclamation-sign'></span>
											${userAllergy}
										</button>
									</c:if>
								</c:forEach>
							</c:forEach>
						</c:if>
					</div>
				</div>
				<br>
				<hr>
				
			</c:forEach>
		</div>
	</div>

	<jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>
</body>
<script>
	$("#search-text").hover(function(){
		$("#search-rank").css("display","block");
	},function(){
		$("#search-rank").css("display","none");
	});

</script>
</html>