<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<title>/navbar.do</title>
<jsp:include page="font.jsp"></jsp:include>
<jsp:include page="resource.jsp"></jsp:include>
<style>
	.profileImage{
		border-radius: 50%;
		width:30px;
		height:30px;
	}
	.ima{
		transform:scale(1.8);
	}
</style>
<nav class="navbar navbar-dark navbar-expand-lg " style="background-color: #014618;">
	<div id="app1" class="container" style="background-color: #014618;">
		<a class="navbar-brand me-5 " href="${pageContext.request.contextPath}/">
			<img src="${pageContext.request.contextPath}/resources/images/logo2.png" class="me-3 mb-1 ima" width="30" height="30" />
			High-clear!
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse me-5" id="navbarNav">
			<ul class="navbar-nav me-auto">
				<li class="nav-item me-5">
					<a class="nav-link ${empty thisPage?'active':''}" href="${pageContext.request.contextPath}/">홈</a>
				</li>
				<li class="nav-item me-5">
					<a class="nav-link ${thisPage eq 'club'?'active':''}" href="${pageContext.request.contextPath}/info/aboutClub.do">소개</a>
				</li>
				<li class="nav-item">
					<a class="nav-link me-5 ${thisPage eq 'notice'?'active':''}" href="${pageContext.request.contextPath}/notice/list.do">공지사항</a>
				</li>
				<li class="nav-item">
					<a class="nav-link me-5 ${thisPage eq 'cafe'?'active':''}" href="${pageContext.request.contextPath}/cafe/list.do">자유게시판</a>
				</li>
				<li class="nav-item">
					<a class="nav-link me-5 ${thisPage eq 'gallery'?'active':''}" href="${pageContext.request.contextPath}/gallery/list.do">갤러리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link me-5 ${thisPage eq 'faq'?'active':''}" href="${pageContext.request.contextPath}/faq/faq.do">FAQ</a>
				</li>
			</ul>
		</div>
		<div v-if="id != ''" class="container2 d-flex justify-content-end align-items-center">
			<img v-if="userInfo.profile!=''" class="profileImage" 
				:src="base_url+userInfo.profile" />
			<svg v-else class="profileImage me-2 text-success" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-emoji-smile-fill" viewBox="0 0 16 16">
				<path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zM4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM10 8c-.552 0-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5S10.552 8 10 8z"/>
			</svg>	
			<span class="navbar-text align-middle me-2" style="color:#ffffff;">
				<a class="text-decoration-none" href="${pageContext.request.contextPath}/users/info.do" >
					{{id}}
				</a>님 로그인 중 
			</span>
				<a class="btn btn-danger btn-sm m-2" href="${pageContext.request.contextPath}/users/logout.do">
				로그아웃
			</a>
		</div>
		<div v-else>
			<a class="btn btn-outline-light btn-sm m-1" 
			href="${pageContext.request.contextPath}/users/signup_form.do">
				회원가입
			</a>
			<a class="btn btn-outline-warning btn-sm m-1" 
			href="${pageContext.request.contextPath}/users/loginform.do">
				로그인
			</a>
		</div>
	</div>		
</nav>
<a class="text-decoration-none" href="javascript: window.scrollTo(0,0);"
	style="cursor:pointer;
	position:fixed;
	right: 2%;
	bottom: 5px;
	z-index: 9999;
	color:#198754;">
	<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-arrow-up-circle" viewBox="0 0 16 16">
		<path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
	</svg>
</a>
   
<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script>
	const base_url="http://localhost:8888/minton05";
	let app1=new Vue({
		el:"#app1",
		data:{
			base_url,
			id:"",
			userInfo:{}
		},
		
		created(){
			let self=this;
			if('${id}'!=null){
				self.id = '${id}';
			}			
			//회원 정보 가져오기
			ajaxPromise(base_url+"/ajax/users/getUser.do","get")
			.then(function(response){
				if(response != null){
					return response.json();
				}				
			})
			.then(function(data){
				//data는 {id:xxx, pwd:xxx, profile:xxx...}
				//console.log(data);
				//가져온 data를 model에 넣어주기
				self.userInfo = data;
			})
		}
	});

</script>