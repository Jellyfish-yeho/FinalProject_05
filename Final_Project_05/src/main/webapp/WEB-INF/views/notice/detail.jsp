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
<style>
   .profile-image{
      width: 50px;
      height: 50px;
      border: 1px solid #cecece;
      border-radius: 50%;
   }
</style>

</head>
<body>
<%-- navbar include : notice - thisPage --%>
<div class="container my-4 py-4">
	<c:if test="${not empty keyword}">
		<p>   
			<strong>${condition}</strong> 조건, 
			<strong>${keyword}</strong> 검색어로 검색된 내용 자세히 보기 
		</p>
	</c:if>

	<div class="article-head mt-4">
		<div class="writerInfo1 d-flex mb-4">
			<div class="profile d-inline-flex me-2">
			
			<%-- dto의 writer로 users에 profile 이미지를 가져온다. 없을 경우 기본 이미지 출력 --%>
			<%--
				UsersDto usersDto = UsersDao.getInstance().getData(dto.getWriter());
				if(usersDto.getProfile()==null){
			--%>	
		
			<%--
				<svg class="profile-image" xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
					<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
					<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
				</svg>	
				<img class="profile-image" src="<%=request.getContextPath() %><%=usersDto.getProfile()%>"/>
			 --%>
			
			</div>
			<div class="writerInfo2 d-flex flex-column">
				<p class="writer fw-bold mb-0"> 
					${dto.writer}
				</p>				
				<p class="date text-muted mb-0">
					${dto.regdate}
				</p>
			</div>
		</div>

		<div class="title my-4 py-2">
			<h2 class="fw-bold">
				${dto.title}
			</h2>
		</div>
		<div class="view mb-4 pb-4">
			<span class="mr-1 text-muted">조회수</span>
			<span class="fw-bold">${dto.viewCount}</span>
		</div>
		<div class="mainContent my-5">
			${dto.content}
		</div>
	</div>
	
	
	<ul class="d-flex flex-row ps-0 justify-content-end" style="list-style:none;">
		<c:if test="${dto.writer eq id}">
			<li>
				<a class="link-dark text-decoration-none mx-1" href="private/updateform.do?num=${dto.num}">
	        		 수정
				</a>
	         </li>
			<li>
				<a class="link-dark text-decoration-none mx-1" href="private/delete.do?num=${dto.num}">
					삭제
				</a>
			</li>
		</c:if>
	</ul> 
	
	<ul class="mb-5 d-flex flex-row ps-0 justify-content-center" style="list-style:none;">
		<c:if test="${dto.prevNum ne 0}">
			<li>
				<a class="link-success text-decoration-none" href="detail.do?num=${dto.prevNum}&keyword=${encodedK}&condition=${condition}">
				&lt이전글
				</a>
			</li> 
		</c:if>

		<li class="mx-3">
			<a class="fw-bold link-success text-decoration-none" href="list.do">목록보기</a>
		</li>
		
		<c:if test="${dto.nextNum ne 0}">
			<li>			   
				<a class="link-success text-decoration-none" href="detail.do?num=${dto.nextNum}&keyword=${encodedK}&condition=${condition}">
				다음글&gt	     	
		      </a>
			</li>	
		</c:if>	    
	</ul>
	
</div>
</body>
</html>


