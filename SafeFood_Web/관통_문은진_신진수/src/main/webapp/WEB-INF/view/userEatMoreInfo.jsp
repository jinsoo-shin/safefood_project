<%@page import="com.ssafy.model.dto.User"%>
<%@page import="com.ssafy.model.dto.Food"%>
<%@page import="java.util.List"%>
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
<!-- <link href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round" -->
<!-- 	rel="stylesheet"> -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> -->
<!-- <link href="https://fonts.googleapis.com/css?family=Jua" -->
<!-- 	rel="stylesheet"> -->
<!-- <link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua" -->
<!-- 	rel="stylesheet"> -->
<c:url var="css" value="/static/css" />
<link rel="stylesheet" href="${css}/indexcss.css">
<link rel="stylesheet" href="${css}/card.css">

</head>

<style>
#chartdiv {
	width: 100%;
	height: 600px;
}

@import url(//fonts.googleapis.com/earlyaccess/notosanskannada.css);

h2 {
	font-family: 'Noto Sans Kannada';
}
</style>
<body>

	<jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>
	<div class="container-fluid" style="width: 80%">
		<c:url value="/static/" var="staticurl" />
		<h2 class="my-4">내 섭취 정보</h2>
		<c:if test="${empty eatmorefoods}">
			<h3>상품 정보가 없습니다.</h3>
		</c:if>
		<div class="row" id="dataarea"></div>
		<div class="card-deck">
			<c:set var="count" value='0' />
			<c:forEach var="food" items="${eatmorefoods}">
				<c:set var="count" value='${count+1}' />
				<div class='col-lg-4 mb-4' id='foodinfo'>
					<div class='card h-100'>
						<h4 class='card-header'>'${food.name}'</h4>
						<div class='card-body'>
							<!-- 							<div class='row'> -->
							<!-- 							<div class='col-lg-4 mb-4 container'> -->
							<div>
								<c:url var="detail" value="/detail"></c:url>
								<a href='${detail}/?code=${food.code}'> <img
									class='card-img-top img-fluid rounded'
									src='${staticurl}${food.img}'>
								</a>
							</div>
							<!-- 							</div> -->
							<!-- 							</div> -->
						</div>
						<c:url var="eat" value="/eat"></c:url>
						<c:url var="moreeat" value="/moreeat"></c:url>
						<div class='card-footer'>
							<button type='button' class='btn btn-info '
								style="margin-right: 10px;">섭취 ${food.count} 개</button>
							<!-- 							<a class='btn btn-primary' -->
							<%-- 								href='${deleteMoreEat}?code=${food.code}'> --%>
							<!-- 								삭제 -->
							<!-- 								<span class='glyphicon glyphicon-chevron-right'></span> -->
							<!-- 							</a> -->


							<a class='btn btn-primary'
								href='${moreeat}?code=${food.code}&count=1' id='cartinsert'>
								섭취 <span class='glyphicon glyphicon-arrow-up'></span>
							</a> <a class='btn btn-primary'
								href='${moreeat}?code=${food.code}&count=-1' id='cartinsert'>
								섭취 <span class='glyphicon glyphicon-arrow-down'></span>
							</a>




							<c:if test="${!empty loginUser.allergy}">
								<div class="divider"></div>
								<c:forEach var="userAllergy" items='${loginUser.allergy}'>
									<c:forEach var="foodAllergy" items='${food.allergy}'>
										<c:if test="${userAllergy eq foodAllergy}">
											<button type='button' class='btn btn-danger'
												style="margin-top: 10px;">
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
				<c:if test="${count%3==0}">
					<div style="width: 100%; padding: 10px"></div>
				</c:if>
			</c:forEach>
		</div>
	</div>
	<div style="width:80%; margin:0 auto;">
	<h3 style="color:red;">권장 영양소 50% 이상인 영양소</h3>
	<ul id="over">

	</ul>
	</div>
	<div style="width:80%; margin:0 auto;">
	<h3 style="color:blue;">자주 섭취한 식품</h3>
	<ul id="ofteneat">

	</ul>
	</div>
	<!-- 차트 띄우기 -->
	<div id="chartdiv"></div>

	<jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>
</body>
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>

<script>

// 	let alarm = "${alarm}";
// 	if (alarm) {
// 		alert(alarm);
// 	}
am4core.ready(function() {

// Themes begin
am4core.useTheme(am4themes_animated);
// Themes end

var iconPath = "M53.5,476c0,14,6.833,21,20.5,21s20.5-7,20.5-21V287h21v189c0,14,6.834,21,20.5,21 c13.667,0,20.5-7,20.5-21V154h10v116c0,7.334,2.5,12.667,7.5,16s10.167,3.333,15.5,0s8-8.667,8-16V145c0-13.334-4.5-23.667-13.5-31 s-21.5-11-37.5-11h-82c-15.333,0-27.833,3.333-37.5,10s-14.5,17-14.5,31v133c0,6,2.667,10.333,8,13s10.5,2.667,15.5,0s7.5-7,7.5-13 V154h10V476 M61.5,42.5c0,11.667,4.167,21.667,12.5,30S92.333,85,104,85s21.667-4.167,30-12.5S146.5,54,146.5,42 c0-11.335-4.167-21.168-12.5-29.5C125.667,4.167,115.667,0,104,0S82.333,4.167,74,12.5S61.5,30.833,61.5,42.5z"



var chart = am4core.create("chartdiv", am4charts.SlicedChart);
chart.hiddenState.properties.opacity = 0; // this makes initial fade in effect

chart.data = [{
    "name": "칼로리",
    "value": ${eatmorenum.getCalory()}
}, {
    "name": "탄수화물",
    "value": ${eatmorenum.getCarbo()}
}, {
    "name": "단백질",
    "value": ${eatmorenum.getProtein()}
}, {
    "name": "지방",
    "value": ${eatmorenum.getFat()}
}, {
    "name": "당류",
    "value": ${eatmorenum.getSugar()}
}, {
    "name": "나트륨",
    "value": ${eatmorenum.getNatrium()/100}
}, {
    "name": "콜레스테롤",
    "value": ${eatmorenum.getChole()}
}, {
    "name": "포화지방산",
    "value": ${eatmorenum.getFattyacid()}
}, {
    "name": "트렌스지방",
    "value": ${eatmorenum.getTransfat()}
}
];

var overdata=[2600,360,55,100,180,15,300,30,10];
for(var i=0;i<chart.data.length;i++){
	if(chart.data[i].value>overdata[i]){
		console.log(chart.data[i].name);
		var tmp="<li>"+chart.data[i].name+"</li>";
		console.log(tmp)
		$("#over").append(tmp)
	}
	console.log(chart.data[i])
}

<%
List<Food> list= (List<Food>) request.getAttribute("eatmorefoods");

int size=5;
if(list.size()<5){
	size=list.size();
} 
for(int i=0;i<size;i++){
	request.setAttribute("tmpfood",list.get(i));
	%>
	$("#ofteneat").append("<a href='${detail}/?code=${tmpfood.code}'><li>${tmpfood.name}</li></a>")
	<%
}
%>



var series = chart.series.push(new am4charts.PictorialStackedSeries());
series.dataFields.value = "value";
series.dataFields.category = "name";
series.alignLabels = true;

series.maskSprite.path = iconPath;
series.ticks.template.locationX = 1;
series.ticks.template.locationY = 0.5;

series.labelsContainer.width = 200;

chart.legend = new am4charts.Legend();
chart.legend.position = "left";
chart.legend.valign = "bottom";

}); // end am4core.ready()
</script>

</html>