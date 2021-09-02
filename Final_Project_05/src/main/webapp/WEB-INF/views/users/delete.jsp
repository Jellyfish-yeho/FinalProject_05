<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<link href="${pageContext.request.contextPath}../../resources/formCss/form.css" rel="stylesheet">
<jsp:include page="../../include/resource.jsp"></jsp:include>
<jsp:include page="../../include/icon.jsp"></jsp:include>
<jsp:include page="../../include/font.jsp"></jsp:include>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function swalSuccess(seq){
	Swal.fire({
		title:'회원 탈퇴 성공',
		text: '${id }님, 회원 탈퇴 되었습니다.',
		icon: 'success',
		confirmButtonColor: '#198754',
		confirmButtonText: '확인'
	}).then((result) => {
		if (result.value) {
		<%-- 원래 페이지로 넘겨주기 : url 값  --%>
		location.href="${pageContext.request.contextPath}/home.do";
	  }
	})
}
</script>
<c:if test="${requestScope.id }"></c:if>
	<script>
		swalSuccess();
	</script>
</body>
</html>