<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
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
   
   .listProfile{
   		width:15px;
   		height:15px;
   		border-radius:50%;
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
<%-- navbar include : cafe - thisPage --%>
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="cafe" name="thisPage"/>
</jsp:include>
<div class="container my-4" id="ccontainer">
   <h1 class="fw-bold text-center my-4">자유게시판</h1> 
	<%-- 새 글 작성 링크 --%>
	<div class="mb-2" style="float:right;">
		<a class="link-success text-decoration-none" href="private/insertform.jsp">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
				<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
			</svg>
			새 글 작성
		</a>
	</div>
	<%-- 자유게시판 글 목록 --%>
   <table class="table table-hover text-center">
      <thead>
         <tr>
            <th>번호</th>
            <th>카테고리</th>
            <th>제목</th>
            <th>작성자</th>
            <th>날짜</th>
            <th>조회수</th>
            <th>
				<svg style="color:#dc3545;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
					<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
				</svg>
            </th>  
         </tr>
      </thead>
		<tbody>
	      	<!-- 공지 글 출력 -->
			<tr class="table-success">
				<th></th>
				<th>공지</th>
				<th>
					<a class="link-dark text-decoration-none fw-bold" 
      				href="${pageContext.request.contextPath}/notice/detail.do?num=${firstNotice.num}&keyword=${encodedK}&condition=${condition}">${firstNotice.title}</a>
      			</th>
				<th>${firstNotice.writer}</th>
				<th>${firstNotice.regdate}</th>
				<th>${firstNotice.viewCount}</th>
				<th></th>  
			</tr>
      </tbody>
      <tbody>
	      <c:forEach var="tmp" items="${list}">
				<tr>
		            <td>${tmp.num}</td>
		            <td>${tmp.category}</td>
					<td>
						<a class="link-dark text-decoration-none fw-bold" 
							href="detail.do?num=${tmp.num}&keyword=${encodedK}&condition=${condition}">${tmp.title}</a>
						<%-- 댓글 개수 출력  --%>
						<c:if test="${tmp.reply_count ne 0}">
							<span class="mx-2" style="color:#198754;">${tmp.reply_count}</span>
						</c:if>			              	               
		            	<%-- 이미지가 첨부되어 있을 시 아이콘 출력 --%>
		            	<c:set var="content" value="${tmp.content }"/>
		            	<c:if test="${fn:contains(content, 'img')}">
			            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-image" viewBox="0 0 16 16">
								<path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
								<path d="M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2h-12zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1h12z"/>
							</svg>
		            	</c:if>
		            </td>
		            <td>
		            <c:choose>
			            <c:when test="${not empty tmp.profile}">
							<img class="listProfile" src="${pageContext.request.contextPath}${tmp.profile}"/>
			            </c:when>
			            <c:otherwise>		            
				            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="listProfile bi bi-person-circle" viewBox="0 0 16 16">
								<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
								<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
							</svg>
			            </c:otherwise>
		            </c:choose>
		            <c:if test="">
		            </c:if>
		            ${tmp.writer}
		            </td>
		            <td>${tmp.regdate}</td>
		            <td>${tmp.viewCount}</td>
		            <td>${tmp.likeCount}</td>
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

<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script>
	




</script>
</body>
</html>













