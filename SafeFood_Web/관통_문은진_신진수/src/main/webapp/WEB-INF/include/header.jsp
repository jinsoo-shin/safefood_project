<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.ssafy.model.dto.User"%>
<%@page import="com.ssafy.model.dto.Food"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css?family=Jua"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua"
	rel="stylesheet">
<!-- Bootstrap core CSS -->
<c:url var="css" value="/static/css" />
<link rel="stylesheet" href="${css}/indexcss.css">
<c:url var="vendor" value="static/vendor" />
<%-- <link href="${vendor}/bootstrap/css/bootstrap.min.css" rel="stylesheet"> --%>
<!-- Modal HTML -->
<div id="myModal" class="modal fade">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">로그인</h4>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">
				<form action="login.do" method="get">
					<input type="hidden" name="action" value="login">
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon">
								<i class="fa fa-user"></i>
							</span>
							<input type="text" id="username" class="form-control"
								name="username" placeholder="Username" required="required">
						</div>
					</div>
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon">
								<i class="fa fa-lock"></i>
							</span>
							<input type="password" id="password" class="form-control"
								name="password" placeholder="Password" required="required">
						</div>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-primary btn-block btn-lg">로그인</button>
					</div>
					<p class="hint-text">
						<c:url var="findpass" value="/findpass"></c:url>
						<a href="${findpass }">비밀번호를 잊으셨어용?</a>
					</p>
				</form>
			</div>
			<div class="modal-footer">
				<c:url var="register" value="/register"></c:url>
				계정이 없나용?
				<a href="${register}">회원가입</a>
			</div>
		</div>
	</div>
</div>
<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-6">
	<ul class="nav navbar-nav  navbar-right">
		<c:if test="${!empty loginUser}">
			<c:url var="mypage" value="/mypage"></c:url>
			<li><a href="${mypage}">${loginUser.name}님 환영합니다.</a> <c:url
					var="logout" value="/logout"></c:url>
			<li><a href="${logout }">Logout</a></li>
		</c:if>
		<c:if test="${empty loginUser}">
			<li><a href="#myModal" class="trigger-btn" data-toggle="modal">Login</a></li>
			<c:url var="register" value="/register"></c:url>
			<li><a href="${register}">Sign Up</a></li>
		</c:if>
	</ul>
</div>

<div class="container-fluid" style="padding-top: 0px">
	<div class="navbar-header">
		<c:url var="main" value="/index"></c:url>
		<a class="navbar-brand" href="${main}">
			<img src="http://edu.ssafy.com/asset/images/header-logo.jpg">
		</a>
	</div>

	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-6">
		<ul class="nav navbar-nav  navbar-right">
			<c:url var="main" value="/index"></c:url>
			<c:url var="qna" value="/qna"></c:url>
			<c:url var="userEat" value="/userEat"></c:url>
			<c:url var="foodinfo" value="/foodinfo"></c:url>
			<c:url var="notice" value="/notice"></c:url>
			<c:url var="recipe" value="/recipe"></c:url>
			<c:url var="price" value="/price"></c:url>
			<c:url var="userMoreEat" value="/userMoreEat"></c:url>
			<li class="active"><a href='${main}'>Home</a></li>
			<li><a href="${qna}">공지사항</a></li>
			<li><a href="${foodinfo}">상품정보</a></li>
			<li><a href="${notice}">관련기사</a></li>
			<li><a href="${recipe}">레시피</a></li>
			<li><a href="${price}">알뜰 장보기</a></li>
<%-- 			<li><a href="${userEat}">내 섭취 정보</a></li> --%>
			<c:if test="${!empty loginUser}">
			<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false">
					사용자 정보
					<span class="caret"></span>
				</a>
				<ul class="dropdown-menu" role="menu">
					<li><a href="${userEat}">찜</a></li>
					<li><a href="${userMoreEat}">내 섭취정보</a></li>
					<li class="divider"></li>
					<li><a href="${mypage}">마이페이지</a></li>
				</ul></li>
				</c:if>
		</ul>
	</div>
</div>
<script>
	let alarm = "${alarm}";
	if (alarm) {
		alert(alarm);
	}
</script>
