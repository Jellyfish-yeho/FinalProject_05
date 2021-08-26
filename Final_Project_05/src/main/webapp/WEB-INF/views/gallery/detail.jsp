<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gallery detail</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
<jsp:include page="../../include/resource.jsp"></jsp:include>
<style>
	.card{
		width:80%;
	}
   .img-wrapper img{
   		width: 90%;
   		height: 90%;
   		object-fit: contain;
   }
    a{
   		cursor:pointer !important;
   }
      .listProfile{
      width: 1rem;
      height: 1rem;
      border: 1px solid #cecece;
      border-radius: 50%;
   }
</style>
</head>
<body>
<%--인클루드 <jsp:include page="../include/navbar.jsp">
   <jsp:param value="gallery" name="thisPage"/>
</jsp:include>--%>
<div class="container">
	<div class="d-flex justify-content-center align-items-center flex-column my-4">
	   <div class="card text-center mb-3">
		   <div class="img-wrapper d-flex justify-content-center align-items-center">
		      <img class="card-img-top" src="${pageContext.request.contextPath}${dto.imagePath}"
		      onerror="this.src='${pageContext.request.contextPath}/resources/images/frown-face.png'"/>	      
		    </div>
			<div class="card-body">
				<p class="card-text fs-3 fw-bold">${dto.title }</p>
				<p class="card-text">${dto.content }</p>
				<div class="my-2 align-items-center">
					<span>
						by
						<%--<c:choose>
         					<c:when test="${dto.getProfile() not empty">
         						<img class="listProfile" width="16" height="16" src="${pageContext.request.contextPath}/${dto.profile}"/>
         					</c:when>
         					<c:otherwise> --%>
         						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="listProfile bi bi-person-circle" viewBox="0 0 16 16">
									<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
									<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
								</svg>
         					<%--</c:otherwise>
         				</c:choose> --%>
					</span>
					<span class="card-text"><strong>${dto.writer }</strong></span>
				</div>
		         <p><small class="text-muted" style="font-size:0.875rem;">${dto.regdate }</small></p>
		         <div>
		         	<%-- 북마크 --%>	
					<input type="text" id="urlInput" class="form-control form-control-sm"
					style="display:block; position:absolute; left:-100000px"/>

					<a id="bookmark" class="text-decoration-none link-dark mx-2"
					onclick="javascript:urlClipCopy();">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmark-fill" viewBox="0 0 16 16">
							<path d="M2 2v13.5a.5.5 0 0 0 .74.439L8 13.069l5.26 2.87A.5.5 0 0 0 14 15.5V2a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2z"/>
						</svg>
					</a>	
										
					<%-- 좋아요 : 클릭 시 숫자 증가 
						<a id="like" class="text-decoration-none link-danger">
							<svg style="color:#dc3545;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
								<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
							</svg>
						</a>
						<span id="likeCounter" class="text-muted mx-1">
							${dto.likeCount() }
						</span>--%>
		         </div>
		         
		<ul class="d-flex flex-row ps-0 mt-3 justify-content-end" style="list-style:none;">	
			<c:if test="${id eq dto.writer }">
				<li>
					<a class="link-dark text-decoration-none mx-1" href="private/updateform.do?num=${dto.getNum() }">수정</a>
				</li>
				<li>
					<a class="link-dark text-decoration-none mx-1" href="private/delete.do?num=${dto.getNum() }">삭제</a>
				</li>
			</c:if>
		</ul>		         
		</div>
		</div>
	</div>
	<nav>	   
	
		<ul class="mb-5 d-flex flex-row ps-0 justify-content-center" style="list-style:none;">
		<c:choose>
         	<c:when test="${dto.prevNum ne 0 }">
	         	<li>
					<a class="link-success text-decoration-none" href="detail.do?num=${dto.prevNum }">
					&lt이전글
					</a>
				</li>
         	</c:when>
         	<c:otherwise>
	         	<li class="mx-3">
					<a class="fw-bold link-success text-decoration-none" href="list.do">목록보기</a>
				</li>
         	</c:otherwise>
       	</c:choose>
       	<c:choose>
       		<c:when test="${dto.nextNum ne 0 }">
	       		<li>			   
					<a class="link-success text-decoration-none" href="detail.do?num=${dto.nextNum }">
					다음글&gt	     	
			      </a>
				</li>
       		</c:when>
       		<c:otherwise>
       			<li class="page-item disabled">
               		<a class="page-link" href="javascript:">Next</a>
            	</li>
       		</c:otherwise>
       	</c:choose> 
		</ul>
		
	 </nav> 

<script>
	//url 클립보드에 복사하기
	var currentUrl = document.getElementById("urlInput");
	currentUrl.value = window.document.location.href;  // 현재 URL 을 세팅해 줍니다.
	function urlClipCopy(){
		currentUrl.select();  // 해당 값이 선택되도록 select() 합니다
		document.execCommand("copy"); // 클립보드에 복사합니다.
		currentUrl.blur();
		alert("URL이 클립보드에 복사되었습니다."); 
	}
	
	//클라이언트가 로그인 했는지 여부
	let isLogin=${ not empty id };
	
	//하트를 누르면 좋아요 1씩 증가
	$("#like").on("click",function(){
		if(isLogin){
			let likeCounter = Number($("#likeCounter").text());
			$("#likeCounter").text(likeCounter+1);
			//좋아요 개수를 서버로 전송한다
			$.ajax({	
				url:"${pageContext.request.contextPath}/gallery/private/like_insert.do",
				type:"get",
				data: "likeCounter="+likeCounter+"&num=${num }",
				success:function(data){
					if(data.isSuccess){
						$("#likeCounter1").text(${dto.getLikeCount() });
					}
				}
			});
		}else{
			alert("로그인 후 좋아요를 누를 수 있습니다.");
		};	
	})

</script>  
  
</div>
<%--인클루드 <jsp:include page="../include/footer.jsp"></jsp:include>--%>
</body>
</html>