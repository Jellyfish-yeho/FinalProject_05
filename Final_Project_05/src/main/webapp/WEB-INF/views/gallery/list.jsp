<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gallery</title>
<%--이미지 주소 어딘지 확인하기<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
--%>
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
   
   .img-wrapper{
      height: 300px;
      transition: transform 0.3s ease-out;
   }
   .img-wrapper:hover{
      transform: scale(1.05);
   }   
   .card .card-text{
      /* 한줄만 text가 나오고  한줄 넘는 길이에 대해서는 ... 처리하는 css */
      display:block;
      white-space : nowrap;
      text-overflow: ellipsis;
      overflow: hidden;
   }
   .img-wrapper img{
   		width: 90%;
   		height: 90%;
   		object-fit: contain; 
   }
     h1 {
		color: rgb(2,38,94); 
		text-shadow:1px 1px 1px rgb(1,148,148); 
		margin: 0; 
		padding: 10px; 
		font-weight: bold; 
	}
	html {
	  	height: 100% !important;
	}

	#ccontainer{
		margin:0 auto; 
		padding:5px; 
		background-color:rgb(255,255,255, 0.9); 
		border-radius: 30px;
	}
</style>
</head>
<body>
<%--인클루드 <jsp:include page="../include/navbar.jsp">
	<jsp:param value="gallery" name="thisPage"/>
</jsp:include> --%>
<div class="container my-4" id="ccontainer">
	<h1 class="fw-bold my-4 text-center">갤러리</h1>

   	<%-- 새 글 작성 링크 --%>
	<div class="mb-2 d-flex justify-content-end">
		<a class="link-success text-decoration-none" href="${pageContext.request.contextPath}/gallery/ajax_form.do">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
				<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
			</svg>
			새 사진 올리기
		</a>
	</div>
	<div class="row row-cols-1 row-cols-md-3 g-4">
	
		<c:forEach var="tmp" items="{list}">
		<div class="col align-middle">
			<div class="card text-center mb-3 h-100">
				<a href="${pageContext.request.contextPath}/gallery/detail.do?num=${tmp.num}">
					<div class="img-wrapper d-flex justify-content-center align-items-center">
						<img class="card-img-top" src="${pageContext.request.contextPath }${tmp.imagePath}" 
						onerror="this.src='${pageContext.request.contextPath}/images/frown-face.png'"/>
	               </div>
				</a>
				<div class="card-body">
					<p class="card-text fs-3 fw-bold">${tmp.getTitle() }</p>
					<p class="card-text">by <strong>${tmp.getWriter() }</strong></p>
					<p><small class="text-muted" style="font-size:0.875rem;">${tmp.getRegdate() }</small></p>
					<p>
						<svg style="color:#dc3545;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="me-2 bi bi-heart-fill" viewBox="0 0 16 16">
							<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
						</svg>
						<span class="text-muted">${tmp.getLikeCount()}</span>
					</p>
				</div>
			</div>
		</div>
		</c:forEach>
	</div>
   <div class="page-ui my-4">
      <ul class="pagination justify-content-center">
      	<c:choose>
      		<c:when test=${startPageNum ne 1 }>
	      		<li class="page-item">
	               <a class="page-link" href="${pageContext.request.contextPath}/gallery/list.do?pageNum=${startPageNum - 1}">&lt;</a>
	            </li>   
      		</c:when>
      		<c:otherwise>
      			<li class="page-item disabled">
               		<a class="page-link" href="${pageContext.request.contextPath}/gallery/list.do?pageNum=${startPageNum - 1}">&lt;</a>
            	</li> 
      		</c:otherwise>
      	</c:choose>
      	<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
      		<li class="page-item">
	      		<c:choose>
	      			<c:when test=${i eq pageNum }>
	      				<a class="page-link active" href="${pageContext.request.contextPath}/gallery/list.do?pageNum=${i}">${i }</a>
	      			</c:when>
	      			<c:otherwise>
	      				<a class="page-link" href="${pageContext.request.contextPath}/gallery/list.do?pageNum=${i}">${i}</a>
	      			</c:otherwise>   
	      		</c:choose>
      		</li>	
      	</c:forEach>
      	<c:choose>
      		<c:when test="${endPageNum lt totalPageCount }">
	      		<li class="page-item">
	               <a class="page-link" href="${pageContext.request.contextPath}/gallery/list.do?pageNum=${endPageNum+1 }">&gt;</a>
	            </li>
      		</c:when>
      		<c:otherwise>
	      		<li class="page-item disabled">
	               <a class="page-link" href="${pageContext.request.contextPath}/gallery/list.do?pageNum=${endPageNum+1 }">&gt;</a>
	            </li>
      		</c:otherwise>      	
      	</c:choose>
      </ul>
   </div>
</div>
<%-- 인클루드 <jsp:include page="../include/footer.jsp"></jsp:include> --%>
</body>
</html>