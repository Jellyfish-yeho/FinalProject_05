<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>High-clear</title>
<%-- resource include --%>
<jsp:include page="../include/resource.jsp"></jsp:include>

<link rel="icon" href="${pageContext.request.contextPath}/resources/images/shuttlecock_main.png" type="image/x-icon" />
<style>
   .modal {
   	  margin-top: -200px !important;
      top: 50% !important;	
      margin-left: -120px !important;	
      left: 50% !important;	
   	  position: fixed;
   	  height: 440px !important;
   	  width: 300px !important;
   	  }
    .modal-content {
    	margin-top: -200px !important;
      	top: 50% !important;
      	margin-left: -120px !important;	
      	left: 50% !important;	
     	height: 300px !important;
    	width: 240px !important;
    	}

	/*글자 css*/
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
	th{
		color: rgb(0,136,236); 
	}
	td{
		color:rgb(2,38,94);
		font-size: 1em; 
	}
	a{
		color:rgb(2,38,94);
		text-decoration: none;
	}

	/* 갤러리 carousel css*/
	.col-md-3{
	  display: inline-block;
	}
	.col-md-3 img{
	  width:100%;
	  height:auto;
	}
	
</style>
</head>
<body>

<%-- navbar include --%> 
<jsp:include page="../include/navbar.jsp"></jsp:include>
	
<%-- 쿠키 읽어오기 --%>

<%-- 팝업 띄우기 --%>

<!-- 메인 carousel -->
  
	<div>
		<%--<img src="${pageContext.request.contextPath}/resources/images/baaaaadminton.jpg" class="d-block w-100" alt=mainImage"> --%>
		<img src="${pageContext.request.contextPath}/resources/images/bd.png" class="d-block w-100" alt=mainImage">
	</div>
	<div class="container-fluid mt-5" style="margin:0 auto; padding:5px;">
	<div class="row">
		<div class="col">
			<h2 class="text-center my-3" style="color:rgb(2,38,94);text-shadow:1px 1px 1px rgb(1,148,148);">공지사항</h2>
		    <table class="table table-hover text-center">
		      <thead>
		         <tr>
		            <th style="color: #48a697;">번호</th>
		            <th style="color: #48a697;">제목</th>
		            <th style="color: #48a697;">조회수</th>
		            <th style="color: #48a697;">날짜</th>   
		         </tr>
		      </thead>
		      <tbody>
			      <c:forEach var="tmpN" items="${list1}">
			      	<tr>
			      		<td>${tmpN.num}</td>
			      		<td>
			      			<a class="link-dark text-decoration-none fw-bold" 
			      			href="board/notice/detail.jsp?num=${tmpN.num}">
			      				${tmpN.title}
			      			</a>		      		
			      		</td>
			      		<td>${tmpN.regdate}</td>
			      		<td>${tmpN.viewCount}</td>
			      	</tr>
			      </c:forEach>		
		      </tbody>
		     </table> 
		</div>
		<div class="col">
			<h2 class="text-center my-3" style="color:rgb(2,38,94);text-shadow:1px 1px 1px rgb(1,148,148);">자유게시판</h2>
			<table class="table table-hover text-center">
		      <thead>
		         <tr>
		            <th style="color: #48a697;">번호</th>
		            <th style="color: #48a697;">카테고리</th>
		            <th style="color: #48a697;">제목</th>
		            <th style="color: #48a697;">작성자</th>
		            <th style="color: #48a697;">날짜</th>
		            <th style="color: #48a697;">조회수</th>     
		         </tr>
		      </thead>
		      <tbody>
<%-- cafeDao 반복문 --%>

		      </tbody>
		   </table>
		</div>
	</div>
	
	<div class="row pt-3">
		<h2 class="text-center my-3" style="color:rgb(2,38,94);text-shadow:1px 1px 1px rgb(1,148,148);">참고 영상</h2>
		<div class="col">
			<div class="card text-center">
                 <iframe height="235" src="https://www.youtube.com/embed/TdeBlsehb6g" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                 <div class="card-body">
                   <h5 class="card-title">스텝</h5>
                   <p class="card-text">배드민턴 스텝의 모든것</p>
                 </div>
           </div>	
           </div>		
		<div class="col">
			<div class="card text-center">
                 <iframe height="235" src="https://www.youtube.com/embed/gAl4cW4r3vw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                 <div class="card-body">
                   <h5 class="card-title">드롭샷</h5>
                   <p class="card-text">깎기드롭부터 백드롭까지</p>
                 </div>
            </div>
		</div>
		<div class="col">
			<div class="card text-center">
                 <iframe height="235" src="https://www.youtube.com/embed/oPgFINcuOVQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                 <div class="card-body">
                   <h5 class="card-title">포핸드그립 백핸드그립 준비그립</h5>
                   <p class="card-text">필수로 알고 시작해야하는 3종 그립</p>
                 </div>
            </div>						
		</div>
		<div class="col">
			<div class="card text-center">
                 <iframe height="235" src="https://www.youtube.com/embed/2a2ESf7SN9g" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                 <div class="card-body">
                   <h5 class="card-title">배드민턴꿀팁</h5>
                   <p class="card-text">배드민턴 꿀팁 특별강습</p>
                 </div>
            </div>						
		</div>
	</div>
	
	<%-- 갤러리  --%>
	<div class="row pt-3 text-center vertical">
	<h2 class="text-center my-3" style="color:rgb(2,38,94);text-shadow:1px 1px 1px rgb(1,148,148);">갤러리</h2>
		<div class="col-lg-12 col-xs-12">
			<span class="col-lg-1" style="float:none; margin:0 auto;">		            
				<img class="p-2" src="<%=request.getContextPath()%>/images/shuttlecock_main.png" width="50" height="50"/>
	        </span>
          <%-- Gallery 반복문 --%>  

            <span class="col-lg-1">
           		<img class="p-2" src="${pageContext.request.contextPath}/resources/images/shuttlecock_main.png" width="50" height="50"/>
           	</span>		             
		</div>
	</div>
</div>
<%--footer include --%>
<jsp:include page="../include/footer.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-latest.js"></script> 
<!-- The Modal -->
<div id="myModal" class="modal"> 
<!-- Modal content -->
	<div class="modal-content">
		<p style="text-align: center;">
			<span style="font-size: 14pt;">
				<b>
					<span style="color: green; font-size: 24pt;">*JOIN US~~*</span>
				</b>
			</span>
		</p>
		<a href="http://www.badmintonmart.com/shop/main/index.php"> 
			<img src="${pageContext.request.contextPath}/resources/images/notice.jpg" class="card-img-top" height=300px width=240px; />
		</a>
		<div style="cursor:pointer;background-color:black; color:white; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
			<span class="pop_bt" style="font-size: 12pt;" >
			5초후 자동으로 사라집니다^^
			</span>
		</div>
	</div> 
</div>
<!--End Modal--> 
<script type="text/javascript">      
       jQuery(document).ready(function() {
               $('#myModal').show();
       });
       //팝업 Close 기능
       function close_pop(flag) {
            $('#myModal').hide();             
       };
       //5초후 자동으로 사라지기 
       setTimeout(function() { $('#myModal').hide();}, 5000)
</script>
</body>
</html>