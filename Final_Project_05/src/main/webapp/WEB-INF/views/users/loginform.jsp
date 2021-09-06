<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<link rel="icon" href="${request.getContextPath()}../../resources/images/shuttlecock_main.png" type="image/x-icon" />
<link href="${pageContext.request.contextPath}/resources/formCss/form2.css" rel="stylesheet">
<link href="../resources/formCss/form2.css" rel="stylesheet">
<jsp:include page="../../include/resource.jsp"></jsp:include>
<jsp:include page="../../include/icon.jsp"></jsp:include>
<jsp:include page="../../include/font.jsp"></jsp:include>
<jsp:include page="../../include/footer2.jsp"></jsp:include>
<style>
	/* footer 하단 고정 [S] */ 
	html, body { 
		margin: 0; 
		padding: 0; 
		height: 100%; 
	} 
	#body-wrapper {
		 min-height: 100%; 
		 position: relative; 
	 } 
	 #body-content { 
		 margin-top: 10px; 
		 padding-bottom: 200px; 
	 /* footer의 높이 */ 
	 } 
	 footer { 
		 width: 100%; 
		 height: 200px; 
		 /* footer의 높이 */ 
		 position: absolute; 
		 bottom: 0; 
		 left: 0; 
	 } 
	 /* footer 하단 고정 [E] */

	.bd-placeholder-img{
		font-size : 1.125rem;
		text-anchor : middle;
		-webkit-user-select : none;
		-moz-user-select:none;
		user-select:none;
	}

@media ( min-width :768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
</style>
</head>
<div id="body-wrapper" class="text-center container form-signin">
	<div id="body-content">
	<form action="${pageContext.request.contextPath}/users/login.do" method="post">
	<img class="mb-4" src="${pageContext.request.contextPath}/resources/images/shuttlecock_main.png" width="100" height="100"/>
		<c:choose>
			<c:when test="${ empty param.url }">
				<input type="hidden" name="url" value="${pageContext.request.contextPath}/"/>
			</c:when>
			<c:otherwise>
				<input type="hidden" name="url" value="${param.url }"/>
			</c:otherwise>
		</c:choose>
		
		<h1 class="h3 mb-3 fw-normal">로그인</h1>				
			<%-- url 값 전달 --%>
			<input type="hidden" name="url" value="${url}"/>
			<div class="form-floating mb-2">
				<%-- id 값 전달 --%>
				<input class="form-control" type="text" name="id" id="id" />
				<label class="control-label" for="id">아이디</label>
			</div>
			<div class="form-floating">
				<%-- pwd 값 전달 --%>
				<input class="form-control" type="password" name="pwd" id="pwd"/>
				<label class="control-label" for="pwd">비밀번호</label>
			</div>
			<%-- login.jsp로 요청하는 버튼 --%>
			<button class="mt-4 w-50 btn btn-sm btn-outline-success" type="submit">로그인</button>
			<a class="mt-2 my-4 w-50 btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/">메인으로</a>
		</form>	
	</div>
	</div>
</body>
</html> 