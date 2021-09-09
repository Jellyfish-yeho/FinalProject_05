<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러 페이지</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/shuttlecock_main.png" type="image/x-icon" />
<style>
		h1 {
			color: #009647;
			text-shadow:1px 1px 1px #D9D9D9; 
			margin: 0; 
			padding: 8px; 
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
<jsp:include page="../../include/navbar.jsp"></jsp:include>
	<div class="container">
		<h1 class="fw-bold text-center my-4">에러 발생</h1>
		<p class="alert alert-danger">
		<%--
			예외 컨트롤러에서
			ModelAndView mView=new ModelAndView();
			mView.addObject("exception", nde);
			exception이라는 key값으로 예외객체를 담았기 때문에
			예외 메시지는
			${exception.message}
		 --%>
			<strong>${exception.message}</strong>
			<br />
			<a href="${pageContext.request.contextPath}/">메인으로 돌아가기</a>			
		</p>
	</div>
<jsp:include page="../../include/footer.jsp"></jsp:include>
</body>
</html>