<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css" />
</head>
<body>
	<div class="container">
		<h1>Oops!</h1>
		<p class="alert alert-danger">
		<%--
			예외 컨트롤러에서
			ModelAndView mView=new ModelAndView();
			mView.addObject("exception", nde);
			exception이라는 key값으로 예외객체를 담았기 때문에
			예외 메시지는
			${exception.message}
		 --%>
			<strong>${exception.message }</strong>
			<a href="${pageContext.request.contextPath}/">back to index</a>			
		</p>
	</div>
</body>
</html>