<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gallery</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
</head>
<body>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
		alert("사진 업로드에 성공했습니다.");
		location.href = "${pageContext.request.contextPath}/gallery/list.do";
	</script>
</body>
</html>