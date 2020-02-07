<%@page import="java.util.List"%>
<%@page import="com.ssafy.model.dto.nation"%>
<%@page import="com.ssafy.model.dto.User"%>
<%@page import="com.ssafy.model.dto.Food"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제 품 상세 정보 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua"
	rel="stylesheet">
<style>
#chartdiv {
	width: 100%;
	height: 500px;
}

.text-center {
	padding-top: 150px;
}

.imgs {
	padding-top: 50px;
	width: 250px;
}

.container {
	
}

.titles {
	width: 200px;
	font-family: 'Jua', sans-serif;
}

td {
	
}

h1 {
	font-family: 'Do Hyeon', sans-serif;
	font-size: -webkit-xxx-large;
}
</style>
<!-- 그래프 -->
<style>
@import url(https://fonts.googleapis.com/css?family=Open+Sans:400,700);

@
keyframes bake-pie {from { transform:rotate(0deg)translate3d(0, 0, 0);
	
}

}
body {
	font-family: "Open Sans", Arial;
	background: #ffffff;
}

main {
	width: 400px;
	margin: 30px auto;
}

section {
	margin-top: 30px;
}

.pieID {
	display: inline-block;
}

.pie {
	height: 200px;
	width: 200px;
	position: relative;
	margin: 0 30px 30px 0;
}

.pie::before {
	content: "";
	display: block;
	position: absolute;
	z-index: 1;
	width: 100px;
	height: 100px;
	background: #EEE;
	border-radius: 50%;
	top: 50px;
	left: 50px;
}

.pie::after {
	content: "";
	display: block;
	width: 120px;
	height: 2px;
	background: rgba(0, 0, 0, 0.1);
	border-radius: 50%;
	box-shadow: 0 0 3px 4px rgba(0, 0, 0, 0.1);
	margin: 220px auto;
}

.slice {
	position: absolute;
	width: 200px;
	height: 200px;
	clip: rect(0px, 200px, 200px, 100px);
	animation: bake-pie 1s;
}

.slice span {
	display: block;
	position: absolute;
	top: 0;
	left: 0;
	background-color: black;
	width: 200px;
	height: 200px;
	border-radius: 50%;
	clip: rect(0px, 200px, 200px, 100px);
}

.legend {
	list-style-type: none;
	padding: 0;
	margin: 0;
	background: #FFF;
	padding: 15px;
	font-size: 13px;
	box-shadow: 1px 1px 0 #DDD, 2px 2px 0 #BBB;
	width: 180px;
}

.legend li {
	height: 1.25em;
	margin-bottom: 0.7em;
	padding-left: 0.5em;
	border-left: 1.25em solid black;
}

.legend em {
	font-style: normal;
}

.legend span {
	float: right;
}

footer {
	position: fixed;
	bottom: 0;
	right: 0;
	font-size: 13px;
	background: #DDD;
	padding: 5px 10px;
	margin: 5px;
}

.ss {
	/* 	width:30px;
	padding-right: 30px; */
	
}

#graph {
	padding-top: 70px;
}

#prdt {
	width: 100px;
	height: 50%;
}

#ddd {
	padding-top: 10px;
	padding-bottom: 80px;
}
</style>
<c:url var="css" value="/static/css" />
<link rel="stylesheet" href="${css}/indexcss.css">
<link rel="stylesheet" href="${css}/card.css">
<link href="https://fonts.googleapis.com/css?family=Poor+Story"
	rel="stylesheet">
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>
	<div class="container">
		<div class="text-center" style="font-family: 'Poor Story', cursive;">
			<h1>제품 정보</h1>
		</div>
		<div class="container-fluid row">
			<div class="col-md-3" id="main_img">
				<c:url var="imgsource" value="/static/${food.img}"></c:url>
				<img src="${imgsource}" class='imgs'>
			</div>
			<div class="col-md-9">
				<table class="table">
					<tr>
						<td class="titles text-center">제품명</td>
						<td id="name">${food.name}</td>
					</tr>
					<tr>
						<td class="titles text-center">제조사</td>
						<td id="maker">${food.maker}</td>
					</tr>
					<tr>
						<td class="titles text-center">원재료</td>
						<td id="material">${food.material}</td>
					</tr>
					<tr>
						<td class="titles text-center">알레르기 성분</td>
						<td id="al">${food.allergy}</td>
					</tr>
				</table>
				<br>
				<c:url var="eat" value="/eat"></c:url>
				<c:url var="moreeat" value="/moreeat"></c:url>
				<a class='btn btn-primary'
					href='${moreeat}?code=${food.code}&count=1' id='cartinsert'>
					섭취추가 <span class='glyphicon glyphicon-plus'></span>
				</a> <a class='btn btn-primary eat' id='${food.code}'
					href='${eat}?code=${food.code}'> 찜 추가 <span
					class='glyphicon glyphicon-shopping-cart'></span>
				</a>

			</div>
		</div>
		<br>
		<hr>
		<br>
		<div class="container-fluid row">
			<h3>영양 정보</h3>
			<div class="col-sm-6" id="graph">
				<div class="pieID pie"></div>

				<!--  도넛차트 -->
				<ul class="pieID legend">
					<li><em class="ss">칼로리</em> <span class="kcal"></span></li>
					<li><em class="ss">탄수화물</em> <span class="tan"></span></li>
					<li><em class="ss">단백질</em> <span class="dan"></span></li>
					<li><em class="ss">지방</em> <span class="gi"></span></li>
					<li><em class="ss">당류</em> <span class="dang"></span></li>
					<li><em class="ss">나트륨</em> <span class="na"></span></li>
					<li><em class="ss">콜레스테론</em> <span class="col"></span></li>
					<li><em class="ss">포화 지방산</em> <span class="fat"></span></li>
					<li><em class="ss">트랜스지방</em> <span class="trans"></span></li>
				</ul>
			</div>

			<!--  도넛차트 옆 테이블 -->
			<div class="col-sm-6" id="detail">
				<table class="table text-center">
					<tr>
						<td>일일 제공량</td>
						<td class="daily"></td>
					</tr>
					<tr>
						<td>칼로리</td>
						<td class="kcal">{food.calory}</td>
					</tr>
					<tr>
						<td>탄수화물</td>
						<td class="tan">{food.carbo}</td>
					</tr>
					<tr>
						<td>단백질</td>
						<td class="dan">{food.protein}</td>
					</tr>
					<tr>
						<td>지방</td>
						<td class="gi">{food.fat}</td>
					</tr>
					<tr>
						<td>당류</td>
						<td class="dang">{food.sugar}</td>
					</tr>
					<tr>
						<td>나트륨</td>
						<td class="na">{food.natrium}</td>
					</tr>
					<tr>
						<td>콜레스테롤</td>
						<td class="col">{food.chole}</td>
					</tr>
					<tr>
						<td>포화 지방산</td>
						<td class="fat">{food.fattyacid}</td>
					</tr>
					<tr>
						<td>트랜스지방</td>
						<td class="trans">{food.transfat}</td>
					</tr>
				</table>
			</div>
		</div>
		<div id="chartdiv"></div>
		<br> <br> <br> <br> <br> <br> <br>
		<br> <br> <br> <br>
	</div>
</body>
<!--  데이터 스크립트 -->
<script src="https://www.amcharts.com/lib/4/core.js"></script>
<script src="https://www.amcharts.com/lib/4/charts.js"></script>
<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
<script>
	function sliceSize(dataNum, dataTotal) {
		return (dataNum / dataTotal) * 360;
	}
	function addSlice(sliceSize, pieElement, offset, sliceID, color) {
		$(pieElement).append(
				"<div class='slice "+sliceID+"'><span></span></div>");
		var offset = offset - 1;
		var sizeRotation = -179 + sliceSize;
		$("." + sliceID).css({
			"transform" : "rotate(" + offset + "deg) translate3d(0,0,0)"
		});
		$("." + sliceID + " span").css({
			"transform" : "rotate(" + sizeRotation + "deg) translate3d(0,0,0)",
			"background-color" : color
		});
	}
	function iterateSlices(sliceSize, pieElement, offset, dataCount,
			sliceCount, color) {
		var sliceID = "s" + dataCount + "-" + sliceCount;
		var maxSize = 179;
		if (sliceSize <= maxSize) {
			addSlice(sliceSize, pieElement, offset, sliceID, color);
		} else {
			addSlice(maxSize, pieElement, offset, sliceID, color);
			iterateSlices(sliceSize - maxSize, pieElement, offset + maxSize,
					dataCount, sliceCount + 1, color);
		}
	}
	function createPie(dataElement, pieElement) {
		var listData = [];
		$(dataElement + " span").each(function() {
			listData.push(Number($(this).html()));
		});
		var listTotal = 0;
		for (var i = 0; i < listData.length; i++) {
			listTotal += listData[i];
		}
		var offset = 0;
		var color = [ "cornflowerblue", "olivedrab", "orange", "tomato",
				"crimson", "purple", "turquoise", "forestgreen", "navy", "gray" ];
		for (var i = 0; i < listData.length; i++) {
			var size = sliceSize(listData[i], listTotal);
			iterateSlices(size, pieElement, offset, i, 0, color[i]);
			$(dataElement + " li:nth-child(" + (i + 1) + ")").css(
					"border-color", color[i]);
			offset += size;
		}
	}

	function loadNutrition() {

		$(".daily").text('${food.supportpereat}');

		$(".kcal").text('${food.calory}');
		$(".tan").text('${food.carbo}');
		$(".dan").text('${food.protein}');
		$(".gi").text('${food.fat}');
		$(".dang").text('${food.sugar}');
		$(".na").text('${food.natrium}');
		$(".col").text('${food.chole}');
		$(".fat").text('${food.fattyacid}');
		$(".trans").text('${food.transfat}');

		createPie(".pieID.legend", ".pieID.pie");

	};

	loadNutrition();

	<!--도넛차트-->
	console.log('${nation}');
	// 	국가별 표시하기
	am4core
			.ready(function() {

				// Themes begin
				am4core.useTheme(am4themes_animated);
				// Themes end

				var chart = am4core.create("chartdiv", am4charts.XYChart);
				chart.hiddenState.properties.opacity = 0; // this creates initial fade-in

				chart.data = [
				];
<%String[] con = (String[]) request.getAttribute("cont");
			int[] num = (int[]) request.getAttribute("numb");
			for (int i = 0; i < con.length; i++) {
				request.setAttribute("tmpcon", con[i]);
				request.setAttribute("tmpNum", num[i]);%>
	var tmp = new Object();
				tmp.country = "${tmpcon}";
				tmp.visits = "${tmpNum}";
				console.log('${tmpNum}');
				chart.data.push(tmp);
<%}%>
	var categoryAxis = chart.xAxes
						.push(new am4charts.CategoryAxis());
				categoryAxis.renderer.grid.template.location = 0;
				categoryAxis.dataFields.category = "country";
				categoryAxis.renderer.minGridDistance = 40;
				categoryAxis.fontSize = 11;

				var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
				valueAxis.min = 0;
				valueAxis.max = 5;
				valueAxis.strictMinMax = true;
				valueAxis.renderer.minGridDistance = 50;
				// axis break
				var axisBreak = valueAxis.axisBreaks.create();
				axisBreak.startValue = 2100;
				axisBreak.endValue = 150;
				axisBreak.breakSize = 0.005;

				// make break expand on hover
				var hoverState = axisBreak.states.create("hover");
				hoverState.properties.breakSize = 1;
				hoverState.properties.opacity = 0.1;
				hoverState.transitionDuration = 1500;

				axisBreak.defaultState.transitionDuration = 1000;

				var series = chart.series.push(new am4charts.ColumnSeries());
				series.dataFields.categoryX = "country";
				series.dataFields.valueY = "visits";
				series.columns.template.tooltipText = "{valueY.value}";
				series.columns.template.tooltipY = 0;
				series.columns.template.strokeOpacity = 0;

				// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
				series.columns.template.adapter.add("fill", function(fill,
						target) {
					return chart.colors.getIndex(target.dataItem.index);
				});

			}); // end am4core.ready()
</script>
</html>