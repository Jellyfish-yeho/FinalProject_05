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
	<c:choose>
		<c:when test="${isSuccess }">
	<p> 
		<strong>${param.id }</strong> 님, 회원가입 되었습니다. </p>
		<a href="${pageContext.request.contextPath}/users/loginform.do">로그인 하러가기</a>
		</c:when>
		
		<c:otherwise>
			<p>회원가입에 실패하였습니다.</p>
			<a href="${pageContext.request.contextPath}/users/signupform.do">다시 시도하기</a>
		</c:otherwise>
	</c:choose>
</div>
</body>
</html>