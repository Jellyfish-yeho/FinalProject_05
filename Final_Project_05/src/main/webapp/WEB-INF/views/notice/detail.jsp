<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/shuttlecock_main.png" type="image/x-icon" />

<%-- icon, resource include --%>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<jsp:include page="../../include/icon.jsp"></jsp:include>
<style>
	.profile-image{
		width: 50px;
		height: 50px;
		border: 1px solid #cecece;
		border-radius: 50%;
	}
	a{
		cursor:pointer !important;
	}
</style>

</head>
<body>
<%-- navbar include : notice - thisPage --%>
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="notice" name="thisPage"/>
</jsp:include>
<div id="app" class="container my-4 py-4">
	<c:if test="${not empty keyword}">
		<p>   
			<strong>${condition}</strong> 조건, 
			<strong>${keyword}</strong> 검색어로 검색된 내용 자세히 보기 
		</p>
	</c:if>

	<div class="article-head mt-4">
		<div v-bind="detail" class="writerInfo1 d-flex mb-4">
			<div class="profile d-inline-flex me-2">
				<img v-if="detail.profile != null" class="profile-image" :src="base_url+detail.profile"/>
			 	<svg v-else lass="profile-image" xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
					<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
					<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
				</svg>				
			</div>
			<div class="writerInfo2 d-flex flex-column">
				<p class="writer fw-bold mb-0"> 
					{{detail.writer}}
				</p>				
				<p class="date text-muted mb-0">
					{{detail.regdate}}
				</p>
			</div>
		</div>

		<div class="title my-4 py-2">
			<h2 class="fw-bold">
				{{detail.title}}
			</h2>
		</div>
		<div class="view mb-4 pb-4">
			<span class="mr-1 text-muted">조회수</span>
			<span class="fw-bold">{{detail.viewCount}}</span>
		</div>
		<div v-html="detail.content" class="mainContent my-5"></div>
	</div>	
	
	<ul class="d-flex flex-row ps-0 justify-content-end" style="list-style:none;">	
		<li v-if="detail.writer === id">
			<a class="link-dark text-decoration-none mx-1" :href="'updateform.do?num='+detail.num">수정</a>
		</li>
		<li v-if="detail.writer === id">
			<a class="link-dark text-decoration-none mx-1" href="'delete.do?num='+detail.num">삭제</a>
		</li>
	</ul>
	
	<ul class="mb-5 d-flex flex-row ps-0 justify-content-center" style="list-style:none;">
	   	<li v-if="detail.prevNum != 0">
			<a class="link-success text-decoration-none" 
			v-on:click.prevent="movePagePrev">
			&lt이전글
			</a>
		</li>
		<li class="mx-3">
			<a class="fw-bold link-success text-decoration-none" href="list.do">목록보기</a>
		</li>
		<li v-if="detail.nextNum != 0">			   
			<a class="link-success text-decoration-none" 
			v-on:click.prevent="movePageNext">
			다음글&gt	     	
	      </a>
		</li>   	    
	</ul>
	
	<!-- 북마크 -->
	<input type="text" id="urlInput" class="form-control form-control-sm"
	style="display:block; position:absolute; left:-100000px"/>		
	<a id="bookmark" class="text-decoration-none link-dark mx-2"
	@click="urlClipCopy">
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmark-fill" viewBox="0 0 16 16">
			<path d="M2 2v13.5a.5.5 0 0 0 .74.439L8 13.069l5.26 2.87A.5.5 0 0 0 14 15.5V2a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2z"/>
		</svg>
	</a>
	
</div>
<jsp:include page="../../include/footer.jsp"></jsp:include>

<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<script>
	//const base_url="http://localhost:8888/minton05";	
	let app = new Vue({
		el:'#app',
		data:{
			keyword:'',
			encodedK:'',
			condition:'',
			detail:{},
			id:'',
			base_url
		},
		methods:{			
			urlClipCopy(){
			//url 클립보드에 복사하기
			var currentUrl = document.getElementById("urlInput");
			currentUrl.value = window.document.location.href;  // 현재 URL
			function urlClipCopy(){
				currentUrl.select();  // url 값을 select()로 선택
				document.execCommand("copy"); // 클립보드에 복사
				currentUrl.blur();
				alert("URL이 클립보드에 복사되었습니다."); 
				}
			},
			movePageNext(){ //다음페이지
				const self=this;				
				//글 정보 읽어오기
				ajaxPromise(base_url+"/ajax/notice/detail.do","GET",
						"num="+self.detail.nextNum+"&keyword="+self.encodedK+"&condition="+self.condition)	
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 {num:xx, writer:xx, content: xx . . . . }
					//얻어온 정보를 model에 넣기
					self.detail=data;
				})
			},
			movePagePrev(){//이전페이지
				const self=this;				
				//글 정보 읽어오기
				ajaxPromise(base_url+"/ajax/notice/detail.do","GET",
						"num="+self.detail.prevNum+"&keyword="+self.encodedK+"&condition="+self.condition)	
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 {num:xx, writer:xx, content: xx . . . . }
					//얻어온 정보를 model에 넣기
					self.detail=data;
				})
			}
		},
		created(){
			const self=this;
			
			let condition='${param.condition}';
			let keyword='${param.keyword}';
			let encodedK=encodeURI('${param.keyword}');			
			//키워드와 조건이 존재하면 모델에 넣어주기
			if(!condition){
				self.condition=condition;
			}
			if(!keyword){
				self.keyword=keyword;
				self.encodedK=encodedK;	
			}
			//글 정보 읽어오기
			ajaxPromise(base_url+"/ajax/notice/detail.do","GET",
					"num="+${param.num}+"&keyword="+encodedK+"&condition="+condition)	
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 {num:xx, writer:xx, content: xx . . . . }
				//얻어온 정보를 model에 넣기
				self.detail=data;
			})
			
			//로그인 정보를 얻어와서
			ajaxPromise(base_url+"/ajax/cafe/isLogin.do", "GET")
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 {id:xxx 또는 빈문자열}
				//얻어온 정보를 model에 넣기
				self.id=data.id;
			})	
			
			
		}	
	});
</script>
</body>
</html>



