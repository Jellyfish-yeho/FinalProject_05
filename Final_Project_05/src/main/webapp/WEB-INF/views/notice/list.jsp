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
<jsp:include page="../../include/icon.jsp"></jsp:include>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
   .page-ui a{
      text-decoration: none;
      color: rgb(2,38,94);
   }
   
   .page-ui a:hover{
      text-decoration: underline;
   }
   
   .page-ui a.active{
      color: rgb(2,38,94);
      font-weight: bold;
      text-decoration: underline;
   }
   .page-ui ul{
      list-style-type: none;
      padding: 0;
   }
	h1 {
		color: rgb(2,38,94); 
		text-shadow:1px 1px 1px rgb(1,148,148); 
		margin: 0; 
		padding: 10px; 
		font-weight: bold; 
	}
	th{
		color: #198754; 
	}

	a{
		color:rgb(2,38,94);
		text-decoration: none;
	}
	html {
	  	height: 100%;
	}

	#ccontainer{
		margin:0 auto; 
		padding:5px; 
		background-color:rgb(255,255,255, 0.9); 
		border-radius: 30px
	}
</style>
</head>
<body>
<%-- navbar include : notice - thisPage --%>
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="notice" name="thisPage"/>
</jsp:include>
<div class="container my-4" id="ccontainer">
	<h1 class="fw-bold text-center my-4 ">공지사항</h1>
	<div class="mb-2" style="float:right;">
		
	<c:if test="${id eq 'admin'}">
		<a class="link-success text-decoration-none" href="insertform.do">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
				<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
			</svg>
         	새 글 작성
		</a>
	</c:if>	
		
	
	
	</div>
	<table class="table table-hover text-center">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
	            <th>조회수</th>
	            <th>날짜</th>     
			</tr>
		</thead>
		<tbody>
			<c:forEach var="tmp" items="${list}">
				<tr>
		            <td>${tmp.num}</td>
		            <td>
		               <a class="link-dark text-decoration-none fw-bold" 
		               href="detail.do?num=${tmp.num}&keyword=${encodedK}&condition=${condition}">${tmp.title}</a>
		            </td>
		            <td>${tmp.viewCount}</td>
		            <td>${tmp.regdate}</td>
		         </tr>		
			</c:forEach>
		</tbody>
	</table>
	<div class="page-ui">
		<%-- 페이지 앞으로 가기 --%>
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${startPageNum ne 1}">
					<li class="page-item">
						<a class="page-link" href="list.do?pageNum=${startPageNum-1}&condition=${condition}&keyword=${encodedK}">&lt;</a>
					</li> 
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="list.do?pageNum=${startPageNum-1}&condition=${condition}&keyword=${encodedK}">&lt;</a>
					</li> 
				</c:otherwise>
			</c:choose>
			
			<%-- 페이지 이동 --%>
			<c:forEach begin="${startPageNum}" end="${endPageNum}" var="i">
				<li class="page-item">
					<c:choose>
						<c:when test="${pageNum eq i}">
							<a class="page-link active" href="list.do?pageNum=${i}&condition=${condition}&keyword=${encodedK}">${i}</a>
						</c:when>
						<c:otherwise>
							<a class="page-link" href="list.do?pageNum=${i}&condition=${condition}&keyword=${encodedK}">${i}</a>
						</c:otherwise>
					</c:choose>
				</li> 
			</c:forEach>
	   
			<%-- 페이지 뒤로가기 --%>
			<c:choose>
				<c:when test="${endPageNum lt totalPageCount}">
					<li class="page-item">
						<a class="page-link" href="list.do?pageNum=${endPageNum+1}&condition=${condition}&keyword=${encodedK}">&gt;</a>
					</li> 
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="list.do?pageNum=${endPageNum+1}&condition=${condition}&keyword=${encodedK}">&gt;</a>
					</li> 
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
	<form action="list.do" method="get"> 
		<div class="row g-3 align-items-center my-4">
			<div class="col-auto">
				<label class="form-label mb-0 fw-bold" for="condition">검색조건</label>
			</div>
			<div class="col-auto">
				<select class="form-select form-select-sm" name="condition" id="condition">
					<option value="title_content" ${condition eq 'title_content'?'selected':''}>제목+내용</option>
					<option value="title" ${condition eq 'title'?'selected':''}>제목</option>
				</select>
			</div>
			<div class="col-auto">
				<input class="form-control form-control-sm" type="text" id="keyword" name="keyword" placeholder="검색어..." value="${keyword}"/>
			</div>
			<div class="col-auto">
				<button class="btn btn-sm btn-outline-success" type="submit">검색</button>
			</div>
	   </div>
   </form>   
   
   <c:if test="${not empty condition}">
		<p class="my-3" style="font-size:0.875rem;">
			<strong>${totalRow}</strong> 개의 글이 검색되었습니다.
		</p>
   </c:if>
</div>

<%-- footer --%>
<jsp:include page="../../include/footer.jsp"></jsp:include>
</body>
</html>