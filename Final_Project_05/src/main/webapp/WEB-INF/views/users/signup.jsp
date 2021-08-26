<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup.jsp</title>
</head>
<body>
<div class="container">
	<p> 
		<strong>${param.id }</strong> 님, 회원가입 되었습니다.
		<a href="${pageContext.request.contextPath}/users/loginform.do">로그인 하러가기</a>
	</p>
</div>
</body>
</html>