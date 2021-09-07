<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>소개</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/shuttlecock_main.png" type="image/x-icon" />

<style>
		h1 {
			color: #009647;
			text-shadow:1px 1px 1px #D9D9D9; 
			margin: 0; 
			padding: 8px; 
			font-weight: bold; 
		}
		h2 {
			color: #00EE71 !important;
			font-weight: bold; 
		}
		p {
			color:#111111;
			font-size: 1em; 
			line-height: 2em; 
			font-weight: bold; 
		}
		a{
			color:rgb(0,136,236);
		}
		

</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="club" name="thisPage"/>
</jsp:include>
	<div style="width: 1000px; margin:0 auto; padding:5px;">
	<div class="row">
		<div class="col text-center my-2">
			<img class="img-fluid d-block w-100" src="${pageContext.request.contextPath}/resources/images/bdm1.jpg"/>
			<!-- <img class="img-fluid d-block w-100" src="${pageContext.request.contextPath}/resources/images/Badminton-main.jpg"  /> -->
		</div>
	</div>
	<div class="row">
		<div class="col">
		<h1>하이클리어</h1><br>
		<h2>클럽소개</h2>
			<p>
				할일없으시죠?<br>
				하이클리어 배드민턴 클럽에서 베드민턴 기술을 연마하고<br>
				다른 사람들과 죽음의 듀얼을 즐겨봅시다<br>				
				초보자부터 숙련자까지 모두 환영합니다<br>
				장비를 가지고오지 못한 분은 대여해드립니다<br>
				(수량이 한정 되어 있습니다. 모자르면 싸워서 뺏어쓰세요)<br>
				병걸리면 나오지말고 집에 있어라<br>
				<span class="accent">코비드바이러스</span> 방역 지침 잘지킴 믿어주세요!
			</p>
		<h2>가입하기</h2>
			<p>
				하이클리어는 여러분을 환영합니다!
				<a href="${pageContext.request.contextPath}/users/signupform.do" style="color: red;">가입하기</a>
			</p>
		<h2>정기모임</h2>
			<p>
				언제: 매주 토요일 오후 7:30-9:00<br>
				어디서: 서울 강남 에이콘아카데미 5층 베드민턴실(지도 참고)<br>
				후원: 에이콘아카데미 
			</p>
		</div>
		<div class="col">
		
		<h1>High-Clear</h1><br>
		<h2>About the Club</h2>
			<p>
				High-Clear Badminton Club provides the opportunity for members to play badminton, to develop and improve their skills, and to participate in training and competitive matches in intramural tournaments. Players of all levels are welcome. Equipment can be provided for students who do not have their own (first come, first serve).
				All club members are expected to adhere to <span class="accent">COVID-19</span> provincial restrictions as well as rules in place at the badminton centre.
			</p>
		<h2>HOW TO JOIN?</h2>
			<p>High-Clear is active on Teams!
			<a href="${pageContext.request.contextPath}/users/signupform.do" style="color: red;">click here to join!</a>
			</p>
		<h2>Meetings</h2>
			<p>When: every Saturndays 7:30-9:00 pm<br>
			Where: Acorn Academy, Gangnam, Seoul(Map & Directions)<br>
			Sponsor: Acorn Academy</p>
		</div>
	</div>
	<div class="row">
		<br><br>
		<!--Google map-->
		<div id="map-container" class="z-depth-1-half map-container" style="height: 500px">
		<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1582.694692627578!2d127.02888253103966!3d37.49873336462014!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca159d4b10f83%3A0xc672380e5228aa2e!2z7JeQ7J207L2Y7JWE7Lm0642w66-4IOqwleuCqOygkA!5e0!3m2!1sko!2skr!4v1625732918256!5m2!1sko!2skr" width="1000" height="450" style="border:0;" allowfullscreen="" loading="lazy">
		</iframe>
		</div>
	</div>
	</div>
<jsp:include page="../../include/footer.jsp"></jsp:include>
</body>
</html>