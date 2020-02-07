<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
<c:url var="css" value="/static/css" />
<link rel="stylesheet" href="${css}/all.css">
<link rel="stylesheet" href="${css}/animate.css">
<style>
th {
	text-align: center;
}
</style>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>
	<div style="margin: 40px 40px">
		<div id="app">
			<list-comp></list-comp>
		</div>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>
</body>
<script type="text/x-template" id="list-temp">
<div>
<div class="pt-page animated" v-bind:class="{show:isshow,notshow:!isshow &&isshow!=null,firstload:isshow==null}" >
	<span class="glyphicon glyphicon-remove-circle" @click="closepost" style="font-size:50px"></span>
	<div style="width:90%; margin:0 auto; background: white;" >

<div id="todayprice">
				<div class="row">
					<h3 class="text-center">{{curposttitle}}</h3>
				</div>
				<div class="row" style="margin: 0 auto; width: 80%;">
					<table
						class="table table-bordered col-md-5 text-center" style="width: 48%; margin-right:2%;">
<tbody>
						<tr class="info">
							<th colspan="3"><span class="glyphicon glyphicon-bullhorn" style="font-size:20px; margin-right:10px;"></span>전통시장이 싸요!</th>
						</tr>
						<tr class="info">
							<th>품목</th>
							<th>전통시장 가격</th>
							<th>대형마트 가격</th>
						</tr>
						<tr v-for="trad in posthtml.traditional">
							<td>{{trad.item}}</td>
							<td>{{trad.tdprice}}</td>
							<td>{{trad.bmprice}}</td>
						</tr>
</tbody>
					</table>
					<table class="table table-bordered col-md-5 text-center" style="width: 48%; margin-left:2%">
<tbody>
						<tr class="info">
							<th colspan="3"><span class="glyphicon glyphicon-shopping-cart"style="font-size:20px; margin-right:10px;" ></span>대형마트가 싸요!</th>
						</tr>
						<tr class="info">
							<th>품목</th>
							<th>대형마트 가격</th>
							<th>전통시장 가격</th>
						</tr>
						<tr v-for="big in posthtml.bigmart">
							<td>{{big.item}}</td>
							<td>{{big.bmprice}}</td>
							<td>{{big.tdprice}}</td>
						</tr>
</tbody>
					</table>
				</div>
			</div>









	</div>
</div>
<h2>알뜰장보기 게시판</h2>
		<hr>

			<div id="todayprice">
				<div class="row">
					<h3 class="text-center">{{title}}</h3>
				</div>
				<div class="row" style="margin: 0 auto; width: 50%;">
					<table
						class="table table-bordered col-md-5 text-center" style="width: 48%; margin-right:2%;">
<tbody>
						<tr class="info">
							<th colspan="2"><span class="glyphicon glyphicon-bullhorn" style="font-size:20px; margin-right:10px;"></span>전통시장이 싸요!</th>
						</tr>
						<tr class="info">
							<th>품목</th>
							<th>가격</th>
						</tr>
						<tr v-for="tdp in tdprice">
							<td>{{tdp.item}}</td>
							<td>{{tdp.price}}</td>
						</tr>
</tbody>
					</table>
					<table class="table table-bordered col-md-5 text-center" style="width: 48%; margin-left:2%">
<tbody>
						<tr class="info">
							<th colspan="2"><span class="glyphicon glyphicon-shopping-cart"style="font-size:20px; margin-right:10px;" ></span>대형마트가 싸요!</th>
						</tr>
						<tr class="info">
							<th>품목</th>
							<th>가격</th>
						</tr>
						<tr v-for="bmp in bmprice">
							<td>{{bmp.item}}</td>
							<td>{{bmp.price}}</td>
						</tr>
</tbody>
					</table>
				</div>
			</div>








<div style="width: 80%; margin: 0 auto; text-align:right;">
	<form id="form" v-on:submit.prevent="searchclick" class="form-inline" >
	 <div class="form-group" >
			<input type="text" v-model="key" class="form-control" placeholder="검색명">
			<input type="submit" value="검색" class="form-control">
	</div>
	</form>
</div>
	<table class="table table-striped table-hover"
			style="width: 80%; margin: 0 auto;">
			<thead>
				<tr>
					<th class="center">번호</th>
					<th class="center">제목</th>
				</tr>
			</thead>
			<tbody >
				<tr v-for="post in posts">
					<td class="center">{{post.index}}</td>
					<td @click="clickpost(post)">{{post.title}}</td>
				</tr>
			</tbody>
		</table>
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
	src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.js"></script>
<script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>

<script>
let model={
		maxpage:[],curpage:1,pagelist:[],iscurpage:"",isshow:null,
		posts:[],post:[],key:"",posthtml:[],tdprice:[],bmprice:[],title:"",curposttitle:""
}
	let eventBus = new Vue();
	Vue.component("list-comp",{
		template:"#list-temp",
		data(){
			return model
		},
		mounted(){
			axios
		      .get('http://localhost:7070/api/parse/price')
		      .then(response => {
		    this.posts = response.data.data; 
		      this.maxpage=response.data.maxpage; 
		      console.log(this.maxpage);
		    }).catch(error => {
		        console.log(error)
		      })
		      .finally(() =>{ 
		   	this.gettodayprice();
			this.changepagelist();
		     });
			
		},
		methods:{
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
				console.log(this.pagelist)
				console.log("페이지끝",this.pagelist[4])
			},
			changepage(page){
				axios
			      .get('http://localhost:7070/api/parse/price?page='+page+"&key="+this.key)
			      .then(response => {
			    this.posts = response.data.data; 
			      this.maxpage=response.data.maxpage; 
			      console.log("최대페이지",this.maxpage);
			      this.curpage=page;
//	 		      console.log(this.posts);
			    }).catch(error => {
			        console.log(error)
			      })
			      .finally(() =>{ 
				this.changepagelist();
			     });
			},
			clickpost(post){
				axios
			      .get('http://localhost:7070/api/parse/pricehtml?url='+post.url)
			      .then(response => {
			    	  console.log("클릭한포스트의 데이터",response.data);
			    	  this.posthtml=response.data;
			    }).catch(error => {
			        console.log(error)
			      })
			      .finally(() =>{ 
			    	  this.curposttitle=post.title;
			     });
				this.clickbutton();
			},
			clickbutton(){
				if(this.isshow==null){
					this.isshow=false;
				}
				this.isshow=!this.isshow;
			},
			closepost(){
				this.posthtml=[];
				this.clickbutton();
			},
			rowpagelist(interval){
				var startpage=this.pagelist[0]+interval;
				var endpage=this.pagelist[4]+interval;
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
			searchclick(){
				axios
			      .get('http://localhost:7070/api/parse/price?key='+this.key)
			      .then(response => {
			    	  this.posts = response.data.data; 
			    	  this.maxpage=response.data.maxpage; 
			    	  this.curpage=1;
			    }).catch(error => {
			        console.log(error)
			      })
			      .finally(() =>{ 
	 		    	  this.changepagelist();
			     });
			},gettodayprice(){
				axios
			      .get('http://localhost:7070/api/parse/getprice')
			      .then(response => {
			    	  this.title=response.data.title;
			   		this.tdprice = response.data.traditional; 
			      this.bmprice=response.data.bigmart; 
			      console.log(response.data);
			    }).catch(error => {
			        console.log(error)
			      })
			      .finally(() =>{ 
			     });
			}
		}
	})
	let vi= new Vue({
		el:"#app" 
	})

</script>
</html>