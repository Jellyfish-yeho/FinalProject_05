<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<link href="${request.getContextPath()}../../resources/formCss/form.css" rel="stylesheet">
<jsp:include page="../../include/resource.jsp"></jsp:include>
<jsp:include page="../../include/icon.jsp"></jsp:include>
<jsp:include page="../../include/font.jsp"></jsp:include>
<style>
	.bd-placeholder-img{
		font-size : 1.125rem;
		text-anchor : middle;
		-webkit-user-select : none;
		-moz-user-select:none;
		user-select:none;
	}
	@media (min-width:768px){
		.bd-placeholder-img-lg{
			font-size:3.5rem;
		}
	}
	.form-control{
		border:1px solid #198754 !important;
	}
</style>
</head>
<body class="text-center">
<div class="container form-signin my-4">
	<form action="${pageContext.request.contextPath}/users/pwd_update.do" method="post" id="myForm">
	<img class="mb-4" src="${pageContext.request.contextPath}/resources/images/shuttlecock_main.png" width="100" height="100"/>
		<h1 class="fw-bold my-4">비밀번호 수정</h1>		
		<div class="form-floating" style="padding: 5px 1px 2px 3px;">
			<input class="form-control" type="password" name="pwd" id="pwd"/>
			<label class="control-label" for="pwd">기존 비밀번호</label>	
		</div>
		<div class="form-floating" style="padding: 5px 1px 2px 3px;">	
			<input class="form-control" type="password" name="newPwd" id="newPwd"/>		
			<label class="control-label" for="newPwd">새 비밀번호</label>
			<small>비밀번호는 5~10자 이내여야 합니다.</small>	
			<div class="invalid-feedback">이 비밀번호는 사용할 수 없습니다.</div>
		</div>
		<div class="form-floating" style="padding: 5px 1px 2px 3px;">	
			<input class="form-control" type="password" id="newPwd2"/>		
			<label class="control-label" for="newPwd2">새 비밀번호 확인</label>
			
		</div>
		<div class="mt-4" style="padding: 5px 1px 2px 3px;">
		<button class="me-2 btn btn-outline-success btn-sm" type="submit">수정</button>
		<button class="btn btn-outline-danger btn-sm" type="reset">내용 지우기</button>
		</div>
	</form>
</div>
<%-- footer --%>
<jsp:include page="../../include/footer.jsp"></jsp:include>
<script>
	//폼에 submit 이벤트가 일어났을때 실행할 함수를 등록하고 
	document.querySelector("#myForm").addEventListener("submit", function(e){
		let pwd1=document.querySelector("#newPwd").value;
		let pwd2=document.querySelector("#newPwd2").value;
		//새 비밀번호와 비밀번호 확인이 일치하지 않으면 폼 전송을 막는다.
		if(pwd1 != pwd2){
			alert("비밀번호를 확인 하세요!");
			e.preventDefault();//폼 전송 막기 
		}
	});
</script>
</body>
</html>