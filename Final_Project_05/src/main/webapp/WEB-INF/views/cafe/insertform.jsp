<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/shuttlecock_main.png" type="image/x-icon" />
<jsp:include page="../../include/resource.jsp"></jsp:include>
<jsp:include page="../../include/icon.jsp"></jsp:include>
<link href="${pageContext.request.contextPath}/resources/formCss/form.css" rel="stylesheet">
<style> 
   html,body{
      margin: 0;
      padding:0;
      height: 100%;
   }
   .body-wrapper{
      min-height:100%;
      position: relative;
   }
   .body-content{
      margin-top: 100px;
      top:50%;
      left:50%;
   }
   
</style>
</head>
<body>
<%-- navbar include : cafe - thisPage --%>
<jsp:include page="../../include/navbar.jsp">
   <jsp:param value="cafe" name="thisPage"/>
</jsp:include>
<div class="body-wrapper ">
   <div class="body-content container my-4 text-center">
      <h1 class="fw-bold my-4">새 글 작성하기</h1>
      <form action="insert.do" method="post" id="insertForm">
         <div class="row mb-3 align-items-center">
            <label class="col-form-label col-form-label-sm col-sm-1" for="category">분류</label>   
            <div class="col">
               <select class="form-control form-select form-select-sm" name="category" id="category">
                  <option value="잡담">잡담</option>
                  <option value="후기">후기</option>
               </select>
            </div>
         </div>    
         <div class="row my-2">   
            <label class="col-form-label col-form-label-sm col-sm-1" for="title">제목</label>
            <div class="col">
               <input class="form-control form-control-sm" type="text" name="title" id="title"/>   
               <small class="text-muted" style="font-size:0.875rem;">제목은 5글자 이상이어야 합니다.</small>
            </div>         
         </div>
         <div class="row my-2">
            <label class="col-form-label col-form-label-sm col-sm-1" for="content">내용</label>
            <div class="col align-self-start">
               <textarea class="form-control" name="content" id="content"></textarea>
            </div>
         </div>
         <button class="btn btn-sm btn-outline-success" type="submit">작성</button>
      </form>      
   </div>
<%-- footer --%>
<jsp:include page="../../include/footer.jsp"></jsp:include>
</div>
<script src="${pageContext.request.contextPath }/ckeditor/ckeditor.js"></script>
<script>
window.onload = function(){
    ck = CKEDITOR.replace("content", {
       height: 400,
       filebrowserUploadUrl:'${pageContext.request.contextPath }/cafe/fileupload.do'
    });
 };
   
   //폼에 submit 이벤트가 일어났을때 실행할 함수 등록
   document.querySelector("#insertForm")
      .addEventListener("submit", function(e){
         const title=document.querySelector("#title").value;
         if(title.length < 5){
            alert("제목을 5글자 이상 입력하세요!");
            e.preventDefault();
         }
         
      });
</script>
</body>
</html>


