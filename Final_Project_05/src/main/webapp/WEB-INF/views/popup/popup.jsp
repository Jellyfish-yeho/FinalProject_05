<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>High-clear</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<style>
	.item > ul > li{
		list-style:none;
		font-size: 0.8rem;
	}
	.item{
		justify-content: center;
	}
	   	h1 {
		color: rgb(2,38,94); 
		text-shadow:1px 1px 1px rgb(1,148,148); 
	}
</style>
<jsp:include page="../../include/font.jsp"></jsp:include>
<jsp:include page="../../include/icon.jsp"></jsp:include>
<jsp:include page="../../include/resource.jsp"></jsp:include>

</head>
<body>
<div class="container text-center">
	<h1 class="fw-bold mt-1 mb-2 animate__animated animate__flash">cool autumn event</h1>
	<div class="mb-1">
		<img src="${pageContext.request.contextPath}/resources/images/pop.jpg" width=400px />		
	</div>	
	<p class="mt-2">✨회원에게만 제공되는 다양한 혜택을 마음껏 누리세요!✨</p>
	<div class="item d-flex justify-content-cente">
		<ul class="list-group list-group-horizontal-sm">

				<li class="list-group-item list-group-item-success">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-calendar-check-fill" viewBox="0 0 16 16">
						<path d="M4 .5a.5.5 0 0 0-1 0V1H2a2 2 0 0 0-2 2v1h16V3a2 2 0 0 0-2-2h-1V.5a.5.5 0 0 0-1 0V1H4V.5zM16 14V5H0v9a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2zm-5.146-5.146-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 0 1 .708-.708L7.5 10.793l2.646-2.647a.5.5 0 0 1 .708.708z"/>
					</svg>
					출석체크 Event
				</li>

				<li class="list-group-item list-group-item-success">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-cart-plus-fill" viewBox="0 0 16 16">
						<path d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1H.5zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zM9 5.5V7h1.5a.5.5 0 0 1 0 1H9v1.5a.5.5 0 0 1-1 0V8H6.5a.5.5 0 0 1 0-1H8V5.5a.5.5 0 0 1 1 0z"/>
					</svg>
					1+1 할인 특가
				</li>


				<li class="list-group-item list-group-item-success">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-gift-fill" viewBox="0 0 16 16">
						<path d="M3 2.5a2.5 2.5 0 0 1 5 0 2.5 2.5 0 0 1 5 0v.006c0 .07 0 .27-.038.494H15a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1H1a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h2.038A2.968 2.968 0 0 1 3 2.506V2.5zm1.068.5H7v-.5a1.5 1.5 0 1 0-3 0c0 .085.002.274.045.43a.522.522 0 0 0 .023.07zM9 3h2.932a.56.56 0 0 0 .023-.07c.043-.156.045-.345.045-.43a1.5 1.5 0 0 0-3 0V3zm6 4v7.5a1.5 1.5 0 0 1-1.5 1.5H9V7h6zM2.5 16A1.5 1.5 0 0 1 1 14.5V7h6v9H2.5z"/>
					</svg>
					구매 사은품 증정 <span class="badge bg-success rounded-pill">마감임박</span>
				</li>

		</ul>
	</div>
	<div class="mt-2 mb-2 item">
		<a id="purchaseLink" href="javascript: ">
			🏸배드민턴 용품 구매하러 가기
		</a>
	</div>
	<div class="form-check">
		<form action="${pageContext.request.contextPath}/popup/nopopup.do" method="post">
			<label>
			<input class="form-check-input" type="checkbox" name="isPopup" value="no"/>
			<span style="font-size:12px;">1분동안 팝업 띄우지 않기</span>
			</label>
			<button type="submit" class="btn btn-sm btn-outline-success">닫기</button>
		</form>
	</div>
</div>
<script>
	document.querySelector("#purchaseLink").addEventListener("click",function(){
		window.open("http://www.badmintonmart.com/shop/main/index.php","_blank");
	});
	
</script>
</body>
</html>