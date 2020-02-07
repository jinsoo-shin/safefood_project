<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link href="https://fonts.googleapis.com/css?family=Poor+Story"
	rel="stylesheet">
<style>
.pt-page-scaleUpDown {
	animation: scaleUpDown .5s ease both;
}
</style>
<c:url var="css" value="/static/css" />
<link rel="stylesheet" href="${css}/all.css">

<!-- <link rel="stylesheet" type="text/css" href="/WEB-INF/static/css/all.css" /> -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<body>
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>

	<div style="margin: 40px 40px">
		<h1>관련기사</h1>
	</div>
	<div id="app">
		<notice-comp></notice-comp>
	</div>
	<div style="text-align: center; clear: both"></div>
	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>
</body>
<script type="text/x-template" id="notice-temp">
<div>
	

		<div v-if="show" @click="showList" style="float:right;margin-right:50px;
color:blue;">기사접기</div>

		<div v-if="show" v-html="content" style="margin:10px 50px;padding:0 60px">

		</div><hr>

			<template v-for="(info, index) in notices">
			<div style="float:left;margin-left: 50px;">
				<span><img  v-bind:src ="info.img"></span>
				<div style="width: 500px; float: right;margin-left: 30px;">
						<a href="#" @click="showDetail(index)">{{info.title}}</a><br><br>
						<span>{{info.text}}</span>
				</div>
				<hr>
			</div>	
			<br>
			</template>
<div style="text-align: center;clear:both"></div>
<div class="pagebox">
				<span @click="changepage(1)" class="page glyphicon glyphicon-backward"></span>
				<span v-show="pagelist[0]!=1" @click="rowpagelist(-5)" class="page glyphicon glyphicon-chevron-left"></span>
				<span @click="changepage(page)" class="page" v-for="page in pagelist" v-bind:class="{curpage:page===curpage}">{{page}}</span>
				<span v-show="pagelist[0]+5<maxpage" @click="rowpagelist(5)" class="page glyphicon glyphicon-chevron-right"></span>
				<span @click="changepage(maxpage)" class="page glyphicon glyphicon glyphicon-forward"></span>
			</div>
	
			
</div>
</script>

<script src="https://unpkg.com/vue"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.min.js"></script>
<script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>
<script type="text/javascript">
let eventBus = new Vue();
	Vue.component("notice-comp",{
		template : "#notice-temp",
		data(){
			return {
				notices:[],
				notice:[],
				show : false,
				title : "",
				content : "",
				maxpage:30,curpage:1,pagelist:[],iscurpage:false,isshow:null
				
			}
		},
		mounted(){
			this.func();
			this.maxpage=30; 
	    	  this.curpage=1;
		},
		methods:{
			//클릭했을때 기사 내용 보여주기
			showDetail(index){
				console.log("index",index);
				axios.get('http://localhost:7070/api/noticedetail/'+this.curpage+'/'+index)
				.then(res=>{
// 					console.log(res.data.data);
					this.title = res.data.data.title;
					this.content = '<h1>'+this.title+'</h1><br>'+res.data.data.content;
					
				}).catch(error => {
			        console.log(error)
			      })
			      .finally(() =>{ 
			    	  this.show = true;
			     });	
				
			},
			showList(){ //목록으로 가기
				console.log("show",this.show)
				return this.func();
			},
			change1(){
				this.func();
			},
			func(){
				axios
				.get('http://localhost:7070/api/notice/'+this.curpage)
				.then(response=>{
					this.notices=response.data.data;
					
					
				}).catch(error => {
			        console.log(error)
			      })
			      .finally(() =>{ 
			    	  this.show=false;
			    	  this.changepagelist();
			     });
			},
			//페이지 버튼 만들기
			rowpagelist(interval){
				var startpage=this.pagelist[0]+interval;
				var endpage=this.pagelist[4]+interval;
	 			console.log(startpage,endpage)
				for(var ii=startpage;ii<=endpage;ii++){
					if(ii<=0){
						endpage++;
					}else if(ii>this.maxpage){
						startpage--;
					}
				}
				this.pagelist=[];
				for(var i=startpage;i<=endpage;i++){
					if(i>0 && i<=this.maxpage){
					this.pagelist.push(i);
					} 
				}
			},
			 changepagelist(){
				this.pagelist=[];
				var startpage=this.curpage-2;
				var endpage=this.curpage+2;
				
				for(var ii=startpage;ii<=endpage;ii++){
					if(ii<=0){
						endpage++;
					}else if(ii>this.maxpage){
						startpage--;
					}
				}
				
				for(var i=startpage;i<=endpage;i++){
					if(i>0 && i<=this.maxpage){
					this.pagelist.push(i);
					} 
				}
// 				console.log(this.pagelist)
				console.log("페이지끝",this.pagelist[4])
			},
			changepage(page){
				console.log("누른페이지",page)
				axios
			      .get('http://localhost:7070/api/notice/'+page)
			      .then(response => {
			    this.notices = response.data.data; 
			    	console.log("response",response)
			      this.maxpage=30; 
			      this.curpage=page;
			    }).catch(error => {
			        console.log(error)
			      })
			      .finally(() =>{ 
				this.changepagelist();
			     });
			},
			change(notices){
				this.notices=notices;
				this.clickbutton();
			},
			clickbutton(){
				if(this.isshow==null){
					this.isshow=false;
				}
				this.isshow=!this.isshow;
			},
			update(){
				axios
			      .put('http://localhost:7070/api/notice/'+this.curpage)
			      .then(response => {
			    }).catch(error => {
			        console.log(error)
			      })
			      .finally(() =>{ 
			    	  this.clickbutton();
			     });
			}
		} 
	});
	let vi = new Vue({
		el:"#app"
			
	})



</script>
</html>