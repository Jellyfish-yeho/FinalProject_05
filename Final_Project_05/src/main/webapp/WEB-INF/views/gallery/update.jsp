<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dto" class="test.gallery.dto.GalleryDto"></jsp:useBean>   
<jsp:setProperty property="*" name="dto"/> 
<%
boolean isSuccess=GalleryDao.getInstance().update(dto);
System.out.println(isSuccess);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gallery update</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
</head>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
function swalSuccess(seq){
	Swal.fire({
		title:'수정 성공',
		text: '글 수정에 성공하였습니다.',
		icon: 'success',00                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
		confirmButtonColor: '#198754',
		confirmButtonText: '확인'
	}).then((result) => {
		if (result.value) {
		location.href="${pageContext.request.contextPath}/gallery/detail.jsp?num=${dto.num }";
	  }
	})
}
function swalFail(seq){
	Swal.fire({
		title: '수정 실패',
		text: '글 수정에 실패하였습니다.',
		icon: 'error',
		confirmButtonColor: '#198754',
		confirmButtonText: '재시도'
	}).then((result) => {
		if (result.value) {
		location.href="updateform.jsp?num=${dto.num }";
	  }
	})
}
</script>

<c:choose>
	<c:when>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>

   <%if(isSuccess){ %>
 	<script>
		swalSuccess();
	</script>
   <%}else{ %>
	<script>
		swalFail();
	</script>
   <%} %>


</body>
</html>