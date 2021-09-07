<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
<jsp:include page="../../include/resource.jsp"></jsp:include>
<jsp:include page="../../include/icon.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/resources/formCss/form.css" rel="stylesheet">
<style>
	#content{
		height: 400px;
		width: 650px;
	}
</style>
</head>
<div class="container my-4">
	<h1 class="fw-bold my-4">글 수정</h1>
	<form action="update.do" method="post">
		<input type="hidden" name="num" value="${dto.num }" />
		<div class="d-flex d-inline-flex flex-column mb-3">		
			<div class="mb-3">
				<div>
					<label class="form-label" for="category">분류</label>
				</div>
				<div>
					<select class="form-select form-select-sm" name="category" id="category">
					<option value="잡담" ${ dto.category ? "잡담" : "" }>잡담</option>
					<option value="후기" ${ dto.category ? "후기" : "" }>후기</option>
					</select>
				</div>
			</div>	
			
			<div class="my-2">
				<label class="form-label" for="title">제목</label>
				<input class="form-control form-control-sm" type="text" name="title" id="title" value="${dto.title }"/>
				<small class="text-muted" style="font-size:0.875rem;">제목은 5글자 이상이어야 합니다.</small>
			</div>
		</div>
		<div class="mb-3">
			<label for="content">내용</label>
			<textarea name="content" id="content">${dto.content}</textarea>
		</div>
		<button class="btn btn-sm btn-outline-success" type="submit" onclick="submitContents(this);">수정</button>
		<button class="btn btn-outline-danger btn-sm" type="reset">원래대로</button>
	</form>
</div>
<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
<script>

	var oEditors = [];
	//추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "${pageContext.request.contextPath}/SmartEditor/SmartEditor2Skin.html",   
	htParams : {
		bUseToolbar : true,            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,      // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,         // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		//aAdditionalFontList : aAdditionalFontSet,      // 추가 글꼴 목록
		fOnBeforeUnload : function(){
 			//alert("완료!");
		}
		}, //boolean
		fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
   
	function pasteHTML() {
		var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
		oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
	}
   
	function showHTML() {
		var sHTML = oEditors.getById["content"].getIR();
		alert(sHTML);
	}
      
	function submitContents(elClickedObj) {
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);   // 에디터의 내용이 textarea에 적용됩니다.
		// 에디터의 내용에 대한 값 검증은 이곳에서 document.getElementById("content").value를 이용해서 처리하면 됩니다.
	try {
		elClickedObj.form.submit();
	}catch(e) {}
	}
   
	function setDefaultFont() {
		var sDefaultFont = '궁서';
		var nFontSize = 24;
		oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
 	}
</script>
</body>
</html>

