<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertFormFrame</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
</head>
<body>
		<form action="insert.jsp" method="post" id="insertForm">
			<div class="d-flex d-inline-flex flex-column mb-3">
				<div>
					<label class="form-label" for="category">분류</label>
				</div>
				<div>	
					<select class="form-select form-select-sm" name="category" id="category">
					<option value="잡담">잡담</option>
					<option value="후기">후기</option>
					</select>
				</div>
				
			<div class="my-2">	
				<label class="form-label" for="title">제목</label>
				<input class="form-control form-control-sm" type="text" name="title" id="title"/>	
				<small class="text-muted" style="font-size:0.875rem;">제목은 5글자 이상이어야 합니다.</small>
			</div>	
			</div>
			<div>
				<label for="content">내용</label>
				<div id="summernote"></div> 
			</div>
			<button class="btn btn-sm btn-outline-success" type="submit">작성</button>
		</form>  
<script>
$(document).ready(function() {
	  $('#summernote').summernote();
});
</script>				
</body>
</html>