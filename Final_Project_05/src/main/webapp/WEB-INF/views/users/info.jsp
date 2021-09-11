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
<style>
	.bd-placeholder-img{
		font-size : 1.125rem;
		text-anchor : middle;
		-webkit-user-select : none;
		-moz-user-select:none;
		user-select:none;
	}

@media ( min-width :768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
	/* 프로필 이미지를 작은 원형으로 만든다 */
	#profileImage{
		width: 100px;
		height: 100px;
		border: 1px solid gray;
		border-radius: 80%
	}
	
	.form-control{
		border:1px solid #198754 !important;
	}
</style>
</head>
<body class="text-center">
<%-- navbar include --%>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
	<div class="container form-signin my-4" id="app">
		<div style="margin-bottom:100px;"></div>
		<h1 class="fw-bold my-4">회원 정보</h1>
		<div class="d-flex d-inline-flex flex-column justify-content-center" style="margin-bottom:100px;">
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
			
			<div class="btn-group" role="group">			
				<a v-if="id === 'admin'" class="btn btn-outline-warning btn-sm my-2" href="${pageContext.request.contextPath}/users/inquiryList.do">문의 목록</a>
				<a class="btn btn-outline-success btn-sm my-2" href="${pageContext.request.contextPath}/users/myList.do">작성한 글 보기</a>
				<a class="btn btn-outline-success btn-sm my-2" href="${pageContext.request.contextPath}/users/updateform.do">회원 정보 수정하기</a>
			</div>

			<div>
				<a class="btn btn-outline-danger btn-sm my-2" href="javascript:swalSuccess()">회원 탈퇴하기</a>
			</div>
		</div>
	</div>
<%-- footer --%>
<jsp:include page="../../include/footer.jsp"></jsp:include>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>

<script>
	let app=new Vue({
		el:"#app",
		data:{
			id:"",
		},
		created(){
           	const self=this; 
            //로그인 정보를 얻어와서
  			ajaxPromise(base_url+"/ajax/cafe/isLogin.do", "GET")
  			.then(function(response){
  				return response.json();
  			})
  			.then(function(data){
  				//data는 {id:xxx 또는 빈문자열}
  				//얻어온 정보를 model에 넣기
  				self.id=data.id;
  			})	
		},
		methods:{
			
		}
	});


	function swalSuccess(seq){
		Swal.fire({
			title: '회원 탈퇴',
			text: '${id}님, 정말 탈퇴하시겠습니까?',
			icon: 'warning',
			confirmButtonColor: '#198754',
			confirmButtonText:"예",
			showCancelButton:true,
			cancelButtonText:"아니오",
		}).then((result) => {
			if (result.isConfirmed) {
				location.href="delete.do";
		  }
		})
	}
	</script>
</body>
</html>
