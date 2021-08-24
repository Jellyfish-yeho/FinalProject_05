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
</style>
<%-- homeController에서 모든 요청에 대해 
	thisPage읽어오기, 로그인된 아이디 읽어와서 request에 저장, url 경로 구성 request에 저장--%>
	<div class="container2 d-flex justify-content-end align-items-center" style="background-color: #014618;">
		
		<c:choose>
			<c:when test="${empty id}">
				<a class="btn btn-outline-light btn-sm m-1" 
				href="${pageContext.request.contextPath}/users/signupform.do">
					회원가입
				</a>
				<a class="btn btn-outline-warning btn-sm m-1" 
				href="${pageContext.request.contextPath}/users/loginform.do">
					로그인
				</a>
			</c:when>
			<c:otherwise>
				<div>
					<%-- 
						users에서 profile 구해오기 - homeController에 usersDao 연결해서 처리해야 함. 일단 기본 이미지 출력		
						<c:choose>
							<c:when test="${empty dto.profile}">
								<svg class="me-2 profileImage" xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-person-circle me-2" viewBox="0 0 16 16">
									<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
									<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
								</svg>
							</c:when>
							<c:otherwise>
								<img class="me-2 profileImage" 
								src="${pageContext.request.contextPath}${dto.profile}" />
							</c:otherwise>
						</c:choose>									
					 --%>
					<svg class="me-2 profileImage" xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-person-circle me-2" viewBox="0 0 16 16">
						<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
						<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
					</svg>
				</div>
				<span class="navbar-text me-2" style="color:#ffffff;">
					<a class="text-decoration-none" href="${pageContext.request.contextPath}/users/private/info.do" >
						${id}
					</a>님 로그인 중 
				</span>
					<a class="btn btn-danger btn-sm m-2" href="${pageContext.request.contextPath}/users/logout.do">
					로그아웃
				</a>
			</c:otherwise>
		</c:choose>
		
		</div>
	<nav class="navbar navbar-light navbar-expand-sm " style="background-color: #ffffff;">
		<div class="container">
			<a class="navbar-brand me-5 " href="${pageContext.request.contextPath}/">
				<img src="${pageContext.request.contextPath}/images/shuttlecock_main.png" width="30" height="30"/>
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
