<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
<link href="${pageContext.request.contextPath}/resources/formCss/form.css" rel="stylesheet">
<jsp:include page="../../include/resource.jsp"></jsp:include>
<jsp:include page="../../include/icon.jsp"></jsp:include>
<jsp:include page="../../include/font.jsp"></jsp:include>
<style>
	/* 프로필 이미지 표시 */
	#profileImage{
		width: 100px;
		height: 100px;
		border: 1px solid gray;
		border-radius: 80%
	}
	#image{
		display: none;
	}
	.form-control{
		text-align: center;
	}
	.profileText{
		font-size: 0.875rem;
	}
</style>
</head>
<body class="text-center">
	<div class="container my-4">
		<h1 class="fw-bold my-4">회원 정보 수정</h1>
		<div class="profile my-3">
			<a id="profileLink" href="javascript:">
				<%-- 저장된 profile이 있으면 value 가져오기, 없으면 "empty" --%>
		<c:choose>
			<c:when test="${empty dto.profile }">
				<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
					  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
					  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
				</svg>
			</c:when>
			<c:otherwise>
				<img id="profileImage" 
					src="${pageContext.request.contextPath}${dto.profile}" />
			</c:otherwise>
		</c:choose>
	</a>
	<p class="profileText text-muted my-2">프로필 사진을 누르면 변경할 수 있습니다.</p>
	</div>
	<form action="${pageContext.request.contextPath}/users/update.do" method="post">
		<input type="hidden" name="profile" 
			value="${ empty dto.profile ? '' : dto.profile}"/>
			<div class="d-flex d-inline-flex flex-column justify-content-center">
			<div style="margin:7px;">
				<label class="form-label" for="id">아이디</label>
				<input class="form-control form-control-sm" type="text" id="id" value="${id }" disabled/>
				</div>
			<div style="margin:7px;">  
				<label class="form-label" for="pwd">비밀번호</label>
				<a href="${pageContext.request.contextPath}/users/pwd_updateform.do">
				<svg class="text-decoration-none" style="color:#198754" "padding: 5px 1px 2px 3px;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
				<path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
				</svg>
				</a>
			</div>
		<div style = "margin: -2px;">
			<label class="form-label" for="email" >이메일</label>
			<input class="form-control form-control-sm" type="text" name="email" id="email" value="${dto.email }"/>
		</div>
		<div style = "margin: 8px;">  
			<button class="btn w-50 btn-outline-success btn-sm" type="submit">적용 </button>
			<a class="mt-2 mb-4 w-50 btn btn-sm btn-outline-danger" href="javascript:history.back();">뒤로가기</a>
		</div>
	</form>

	<form action="${pageContext.request.contextPath}/users/ajax_profile_upload.do" method="post" 
				id="imageForm" enctype="multipart/form-data">
		<input type="file" name="image" id="image" 
			accept=".jpg, .jpeg, .png, .JPG, .JPEG, .gif"/>
	</form>
</div>
<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script>
	//프로필 이미지 링크를 클릭하면 
	document.querySelector("#profileLink").addEventListener("click", function(){
		// input type="file" 을 강제 클릭 시킨다. 
		document.querySelector("#image").click();
	});
	//이미지를 선택했을때 실행할 함수 등록 
	document.querySelector("#image").addEventListener("change", function(){
		
		let form=document.querySelector("#imageForm");
		
		// gura_util.js 에 정의된 함수를 호출하면서 ajax 전송할 폼의 참조값을 전달하면 된다. 
		ajaxFormPromise(form)
		.then(function(response){
			return response.json();
		})
		.then(function(data){
			// data 는 {imagePath:"/upload/xxx.jpg"} 형식의 object 이다.
			console.log(data);
			let img=`<img id="profileImage" src="${pageContext.request.contextPath}\${data.imagePath}"/>`;
			document.querySelector("#profileLink").innerHTML=img;
			// input name="profile" 요소의 value 값으로 이미지 경로 넣어주기
			document.querySelector("input[name=profile]").value=data.imagePath;
		});
	});
</script>
</body>
</html>
