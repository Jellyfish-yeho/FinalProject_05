<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<jsp:include page="../../include/icon.jsp"></jsp:include>
<jsp:include page="../../include/font.jsp"></jsp:include>
<style>
	/* 프로필 이미지를 작은 원형으로 만든다 */
	#profileImage{
		width: 50px;
		height: 50px;
		border: 1px solid #cecece;
		border-radius: 50%;
	}
</style>
</head>
<body class="text-center">
	<div class="container my-4 form-signin">
		<h1 class="fw-bold my-4">회원 정보</h1>
		
		<div class="profile my-3">
		
		<c:choose>
			<c:when test="${empty dto.profile }">
				<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
					<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
					<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
				</svg>
			</c:when>
			<c:otherwise>
				<img id="profileImage" src="${pageContext.request.contextPath}${dto.profile}"/>
			</c:otherwise>
			</c:choose>
		</div>
		<div class="id">
			<p class="fw-bold">${id}</p>
		</div>
		<div class="date">
			<p class="text-muted">${dto.getRegdate()}</p>
		</div>
		
		<div>
			<a class="btn me-2 btn-outline-success btn-sm" href="${pageContext.request.contextPath}/users/updateform.do">회원 정보 수정</a>
			<a class="btn btn-outline-danger btn-sm" href="javascript:swalSuccess()">회원 탈퇴</a>
		</div>
		<div>
			<a class="mt-2 mb-4 w-50 btn btn-sm btn-outline-success" href="${pageContext.request.contextPath }/home.do">메인으로</a>
		</div>
		</div>
		
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
	function swalSuccess(seq){
		Swal.fire({
			title: '회원 탈퇴',
			text: '${id}님, 정말 탈퇴하시겠습니까?',
			icon: 'warning',
			confirmButtonColor: '#198754',
			confirmButtonText: '탈퇴'
		}).then((result) => {
			if (result.value) {
				location.href="delete.do";
		  }
		})
	}
	</script>
</body>
</html>
