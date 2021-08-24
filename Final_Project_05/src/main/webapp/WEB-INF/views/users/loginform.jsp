<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/loginform.jsp</title>
</head>
<body>
<div class="container">
	<form action="${pageContext.request.contextPath}/users/login.do" method="post">
		<c:choose>
			<c:when test="${ empty param.url }">
				<input type="hidden" name="url" value="${pageContext.request.contextPath}/"/>
			</c:when>
			<c:otherwise>
				<input type="hidden" name="url" value="${param.url }"/>
			</c:otherwise>
		</c:choose>
		<div>
			<label for="id">ID</label>
			<input type="text" name="id" id="id"/>
		</div>
		<div>
			<label for="pwd">Password</label>
			<input type="password" name="pwd" id="pwd"/>
		</div>
		<button type="submit">Log-in</button>
	</form>
</div>
</body>
</html> 