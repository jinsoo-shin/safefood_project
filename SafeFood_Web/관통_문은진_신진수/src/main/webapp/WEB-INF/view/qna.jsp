<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
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
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Jua"
	rel="stylesheet">

<c:url var="css" value="/static/css" />
<link rel="stylesheet" href="${css}/all.css">
<link rel="stylesheet" href="${css}/table.css">
<style>
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/include/header.jsp"></jsp:include>
	<div style="margin: 40px">
		<h2>공지사항</h2>
		<hr>
	</div>
	<div id="app">
		<list-comp></list-comp>
		<br>
		<div v-show="dowhat">
			<write-comp></write-comp>
		</div>
		<div v-show="!dowhat">
			<!-- 		<div v-else> -->
			<update-comp></update-comp>
		</div>
	</div>
	<jsp:include page="/WEB-INF/include/footer.jsp"></jsp:include>

</body>
<script type="text/x-template" id="write-temp">
<div v-if="showwrite">
<div class="form-horizontal"
		style="width: 90%; background: lightsteelblue; padding: 20px; margin-left: 5%;">
		<span class="glyphicon glyphicon-remove" style="font-size:20px;" @click="doreset"></span>
		<div class="form-group" style="margin-left: 4%;">
			<div >
				제목
				<input type="text" class="form-control" style="width: 500px;" v-model="post.title" >
			</div>
		</div>
		<div class="form-group" style="margin-left: 4%;">
			<div >
				작성자
				<input class="form-control" type="text" style="width: 10%;" v-model="post.writer" readonly>
			</div>
		</div>
		<div class="form-group">
			<!-- 		<textarea rows="40" cols="40"> -->
			<textarea class="form-control"
				style="width: 90%; height: 300px; margin-left: 5%; margin-top: 30px;" v-model="post.content" ></textarea>
		</div>
<div class="form-group form-inline" style="text-align:right; margin-right: 5%;">
				<label class="" for="pass">
					패스워드
				</label>
				<input id="pass" class="form-control" style="width: 10%;" type="password" v-model="post.password">
 </div>
 <div class="form-group" style="text-align:right; margin-right: 5%;">
				<button class="btn btn-default" @click="doinsert">게시하기</button>
				<button class="btn btn-default" @click="doreset">닫기</button>
</div>
		</div>
		</div>



</script>
<script type="text/x-template" id="update-temp">
<div v-if="post">
<c:if test="${!empty loginUser && loginUser.name=='test'}">
	<div class="form-horizontal"
		style="width: 90%; background: lightsteelblue; padding: 20px; margin-left: 5%;">
		<span class="glyphicon glyphicon-remove" style="font-size:20px;" @click="doreset"></span>
		<div class="form-group" style="margin-left: 4%;">
			<div >
				제목
				<input type="text" class="form-control" style="width: 500px;" v-model="post.title">
			</div>
		</div>
		<div class="form-group" style="margin-left: 4%;">
			<div >
				작성자
				<input class="form-control" type="text" style="width: 10%;" v-model="post.writer" readonly>
			</div>
		</div>
		<div class="form-group">
			<!-- 		<textarea rows="40" cols="40"> -->
			<textarea class="form-control"
				style="width: 90%; height: 300px; margin-left: 5%; margin-top: 30px;" v-model="post.content"></textarea>
		</div>
<div class="form-group form-inline" style="text-align:right; margin-right: 5%;">
				<label class="" for="pass">
					패스워드
				</label>
				<input id="pass" class="form-control" style="width: 10%;" type="password" v-model="post.password">
 </div>

 <div class="form-group" style="text-align:right; margin-right: 5%;">
				<button class="btn btn-default" @click="doupdate">수정완료</button>
				<button class="btn btn-default"  @click="dodelete">삭제</button>
				<button class="btn btn-default" @click="doreset">닫기</button>
</div>
		</div>
		</div>



</c:if>


<c:if test="${!empty loginUser && loginUser.name!='test'}">
		<div class="form-horizontal"
		style="width: 90%; background: lightsteelblue; padding: 20px; margin-left: 5%;">
		<span class="glyphicon glyphicon-remove" style="font-size:20px;" @click="doreset"></span>
		<div class="form-group" style="margin-left: 4%;">
			<div >
				제목
				<input type="text" class="form-control" style="width: 500px;" v-model="post.title" readonly>
			</div>
		</div>
		<div class="form-group" style="margin-left: 4%;">
			<div >
				작성자
				<input class="form-control" type="text" style="width: 10%;" v-model="post.writer" readonly>
			</div>
		</div>
		<div class="form-group">
			<!-- 		<textarea rows="40" cols="40"> -->
			<textarea class="form-control"
				style="width: 90%; height: 300px; margin-left: 5%; margin-top: 30px;" v-model="post.content" readonly></textarea>
		</div>

 <div class="form-group" style="text-align:right; margin-right: 5%;">
				<button class="btn btn-default" @click="doreset">닫기</button>
</div>
		</div>
		</div>
</c:if>


<c:if test="${empty loginUser}">
		<div class="form-horizontal"
		style="width: 90%; background: lightsteelblue; padding: 20px; margin-left: 5%;">
		<span class="glyphicon glyphicon-remove" style="font-size:20px;" @click="doreset"></span>
		<div class="form-group" style="margin-left: 4%;">
			<div >
				제목
				<input type="text" class="form-control" style="width: 500px;" v-model="post.title" readonly>
			</div>
		</div>
		<div class="form-group" style="margin-left: 4%;">
			<div >
				작성자
				<input class="form-control" type="text" style="width: 10%;" v-model="post.writer" readonly>
			</div>
		</div>
		<div class="form-group">
			<!-- 		<textarea rows="40" cols="40"> -->
			<textarea class="form-control"
				style="width: 90%; height: 300px; margin-left: 5%; margin-top: 30px;" v-model="post.content" readonly></textarea>
		</div>

 <div class="form-group" style="text-align:right; margin-right: 5%;">
				<button class="btn btn-default" @click="doreset">닫기</button>
</div>
		</div>
		</div>
</c:if>

</div>
</script>
<script type="text/x-template" id="list-temp">
<div v-if="showmain" style="width: 90%;" class="center-block" >
	<div class="form-inline" style="margin:10px">
		<form id="form"  style="float:left; margin-left:1%;" @submit.prevent="searchclick">
			<label>검색</label>
			<select v-model="bean.key" class="form-control">
				<option value="" selected>-- 선택 --</option>
				<option value="num">번호</option>
				<option value="title">제목</option>
				<option value="writer">작성자</option>
			</select>
			<input type="text" v-model="bean.word" class="form-control">
			<input type="submit" value="검색" class="form-control"> 
		</form>	
		<div style="text-align:right; margin-right:1%;">
		<select v-model="page" @change="pagechange" class="form-control">
			<option v-for="page in pagelist">{{page}}</option>
		</select>
		선택한 페이지 : {{page}}
		</div>
	</div>

	<table class='list_table table table-hover table-bordered'>
			<col width="10%">
			<col width="30%">
			<col width="20%">
			<col width="20%">
			<col width="20%">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="post in postviewlist">
					<td>{{post.num}}</td>
					<td @click="updatepost(post)">{{post.title}}</td>
					<td>{{post.writer}}</td>
					<td>{{post.postdate}}</td>
					<td>{{post.count}}</td>
				</tr>

			</tbody>
</table>
<hr>
<c:if test="${!empty loginUser && loginUser.name=='test'}">
<div class="row"  >
<button @click="writepost" class="btn btn-primary" style="float: right;margin-right: 2%;">글쓰기</button>
</div>
</c:if>
</div>
</script>
<script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>
<script src="https://unpkg.com/vue"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.js"></script>
<script type="text/javascript">
	let eventBus=new Vue();
	
	Vue.component("write-comp",{
		template:"#write-temp",
		data(){
			return {showwrite:false,
			post:{
			title:"",writer:"${loginUser.name}",password:"",content:""
			}	
			}
		},
		created(){
			eventBus.$on("truewrite",this.truewrite)
		},
		methods:{//취소버튼,게시하기 누르면 !ㄴshowwrite로 바뀌게
			truewrite(bool){
				this.showwrite=bool;
			},
			doinsert(){
				console.log("추가한다")
				axios
			      .post('http://localhost:7070/api/insert',this.post)
			      .then(response => { 
			    	  this.post={
			  			title:"",writer:"${loginUser.name}",password:"",content:""
			  			}
			    }).catch(error => {
			        console.log(error)
			      })
			      .finally(() =>{ 
				 eventBus.$emit("reload");
				 this.showwrite=false;
				 alert("글쓰기 완료")
			     });
			},
			doreset(){
				this.showwrite=false;
			} 
		}
	})
	Vue.component("update-comp",{
		template:"#update-temp",
		data(){
			return{post:null }
		},
		created(){
			eventBus.$on("trueupdate",this.trueupdate)
		},
		methods:{
			trueupdate(post){
				this.post=post
			},
			doupdate(){
				console.log("수정한다")
				axios
			      .put('http://localhost:7070/api/update',this.post)
			      .then(response => {this.post = response.data.data; 
			    }).catch(error => {
			        console.log(error)
			      })
			      .finally(() =>{ 
			    	  eventBus.$emit("reload");
			    	  this.post=null;
			    	  alert("글 수정완료")
			     });
			},
			dodelete(){
				console.log("삭제한다")
				axios
			      .delete('http://localhost:7070/api/delete/'+this.post.num)
			      .then(response => {this.post = response.data.data; 
			    }).catch(error => {
			        console.log(error)
			      })
			      .finally(() =>{ 
			    	  eventBus.$emit("reload")
			    	  this.post=null;
			    	  alert("글 삭제완료")
			     });
			},
			doreset(){
				this.post=null;
			}
		}
	})
	
	Vue.component("list-comp",{
		template:"#list-temp",
		props:["dowhat"],
		data(){
			return{
				bean:{
					key:"",word:""
				},postall:[],//모든 정보
				postviewlist:[],// 10개씩 잘라서 보여주는것
				page:1,//선택한 페이지 default 1이요
				maxpage:1,
				pagelist:[],
				showmain:true
			}
		},
		created(){
			eventBus.$on("reload",this.reload)
		},
		mounted(){//전체 데이터를 받아온다 10개씩 보여주는 view를 실행하기
			axios
		      .get('http://localhost:7070/api/search')
		      .then(response => {this.postall = response.data.data; 
		    }).catch(error => {
		        console.log(error)
		      })
		      .finally(() =>{ 
// 		    	  console.log("전체글",this.postall)
				this.makepagelist();//페이지 select만들기
		    	 this.targetpage();//게시글 보여줄것 만들기 
		     });
		},
		methods:{
			reload(){
				axios
			      .get('http://localhost:7070/api/search')
			      .then(response => {this.postall = response.data.data; 
			    }).catch(error => {
			        console.log(error)
			      })
			      .finally(() =>{ 
// 			    	  console.log("전체글",this.postall)
					this.makepagelist();//페이지 select만들기
			    	 this.targetpage();//게시글 보여줄것 만들기 
			     });
			},
			searchclick(){//검색 버튼클릭했을때입니다
				axios
			      .get('http://localhost:7070/api/search?key='+this.bean.key+"&word="+this.bean.word)
			      .then(response => {this.postall = response.data.data; 
			    }).catch(error => {
			        console.log(error)
			      })
			      .finally(() =>{ 
			    	  console.log("검색했어",this.postall)
			    	  this.makepagelist();//페이지 select만들기
				    	 this.targetpage();//게시글 보여줄것 만들기 
			     });
			},
			 targetpage(){//게시글 보여줄것 만들기 
				this.postviewlist=[]//초기화한다
				var tmppage=this.page-1;//0부터 시작이니깐!
				for(var i=0+tmppage*10;i<tmppage*10+10;i++){
					if(i>=this.postall.length){//뽑으려는게 데이터보다 많으면 멈춰
// 						console.log("데이터 범위 넘어갔어요");
						break;
					}
					this.postviewlist.push(this.postall[i])
				}
// 				console.log(this.postviewlist)
			},
			makepagelist(){//페이지 select만들기
				this.pagelist=[]
				this.maxpage=(this.postall.length/10)+1;//최대페이지를 구하고
				for(var i=1;i<=this.maxpage;i++){
					this.pagelist.push(i);
				}
				console.log(this.pagelist)
			},
			pagechange(){
				console.log("페이지",this.page)
				this.targetpage();
			},
			test(post){
				console.log("눌렀대",post);
				this.isshow=true;
			},
			writepost(){
				eventBus.$emit("truewrite",true);
				eventBus.$emit("whatchoice",true);
			},
			updatepost(post){
				post.count+=1;
				this.countup(post);
				eventBus.$emit("whatchoice",false);
				eventBus.$emit("trueupdate",post);
			},
			countup(post){
				axios
			      .put('http://localhost:7070/api/update',post)
			      .then(response => {this.post = response.data.data; 
			    }).catch(error => {
			        console.log(error)
			      })
			      .finally(() =>{ 
			     });
			}
		}
	})
	
	let vi= new Vue({
		el:"#app",
		data(){
			return{dowhat:true}//true면 write false면 update인것
		},
		created(){
			eventBus.$on("whatchoice",this.whatchoice)
		},
		methods:{
			whatchoice(bool){
				this.dowhat=bool;
				console.log(this.dowhat);
			}
		}
	})

</script>


</html>