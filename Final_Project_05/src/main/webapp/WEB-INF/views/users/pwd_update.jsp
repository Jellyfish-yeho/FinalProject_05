<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<link href="${pageContext.request.contextPath}/resources/formCss/form.css" rel="stylesheet">
<jsp:include page="../../include/resource.jsp"></jsp:include>
<jsp:include page="../../include/icon.jsp"></jsp:include>
<jsp:include page="../../include/font.jsp"></jsp:include>
</head>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function swalSuccess(seq){
	Swal.fire({
		title:'수정 성공',
		text: '${id }님, 비밀번호를 변경하였습니다. 다시 로그인해 주세요.',
		icon: 'success',
		confirmButtonColor: '#198754',
		confirmButtonText: '확인'
	}).then((result) => {
		if (result.value) {
			location.href="${pageContext.request.contextPath}/users/loginform.do";
	  }
	})
}
function swalFail(seq){
	Swal.fire({
		title: '수정 실패',
		text: '기존 비밀번호가 맞지 않습니다.',
		icon: 'error',
		confirmButtonColor: '#198754',
		confirmButtonText: '재시도'
	}).then((result) => {
		if (result.value) {
			location.href="${pageContext.request.contextPath}/users/pwd_updateform.do";
	  }
	})
}
</script>
<c:choose>
		<c:when test="${isSuccess }">
		<script>
		swalSuccess();
		</script>
		</c:when>
		<c:otherwise>
		<script>
		swalFail();
		</script>	
		</c:otherwise>
	</c:choose>
</body>
</html>


