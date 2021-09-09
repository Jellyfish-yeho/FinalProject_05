<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<link href="${pageContext.request.contextPath}resources/formCss/form.css" rel="stylesheet">
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
	@media (min-width:768px){
		.bd-placeholder-img-lg{
			font-size:3.5rem;
		}
	}
	.form-control{
		border:1px solid #198754 !important;
	}
</style>
</head>
<body class="text-center">
<%-- navbar include --%>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="container form-signin my-4">
<div class="d-flex d-inline-flex flex-column justify-content-center">
	<form action="${pageContext.request.contextPath}/users/signup.do" method="post" id="myForm">
		<div style="margin-bottom:100px;"></div>
		<img class="mb-4" src="${pageContext.request.contextPath}/resources/images/shuttlecock_main.png" width="100" height="100"/>
		<h1 class="fw-bold my-4">회원가입</h1>	
			<div class="form-floating">
				<input class="form-control" type="text" name="id" id="id" />
				<label class="control-label" for="id">아이디</label>				
				<small>아이디는 5~10자 이내의 영문 소문자여야 합니다. </small>
				<div class="invalid-feedback">이 아이디는 사용 할 수 없습니다.</div>
			</div>
			<div class="form-floating">
				<input class="form-control" type="password" name="pwd" id="pwd" />	
				<label class="control-label" for="pwd">비밀번호</label>				
				<small>비밀번호는 5~10자 이내여야 합니다. </small>	
				<div class="invalid-feedback">이 비밀번호는 사용 할 수 없습니다.</div>
			</div>
			<div class="form-floating">
				<input class="form-control" type="password" name="pwd2" id="pwd2" />
				<label class="control-label" for="pwd2">비밀번호 확인</label>	
				<small> </small>				
			</div>
			<div class="form-floating" style="top:15px;">
				<input class="form-control" type="email" name="email" id="email" />
				<label class="control-label" for="email">이메일</label>
				<small>이메일 형식에 맞게 입력해주세요. </small>
				<div class="invalid-feedback">이 이메일은 사용 할 수 없습니다.</div>					
			</div>
			<div class="mt-4" style="padding: 5px 1px 2px 3px;">
			<button class="mt-4 w-50 btn btn-sm btn-outline-success" type="submit">가입하기</button>	
			<a class="mt-1 w-50 btn btn-sm btn-outline-success" href="${pageContext.request.contextPath}/">메인으로</a>	
			</div>
		</form>
</div>
</div>
<%-- footer --%>
<jsp:include page="../../include/footer.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script>
	//아이디, 비밀번호, 이메일의 유효성 여부를 관리한 변수 만들고 초기값 대입
	let isIdValid=false;
	let isPwdValid=false;
	let isEmailValid=false;
	//아이디를 입력했을때(input) 실행할 함수 등록 
	document.querySelector("#id").addEventListener("input", function(){
		//일단 is-valid,  is-invalid 클래스를 제거한다.
		document.querySelector("#id").classList.remove("is-valid");
		document.querySelector("#id").classList.remove("is-invalid");
		
		//1. 입력한 아이디 value 값 읽어오기  
		let inputId=this.value;
		//입력한 아이디를 검증할 정규 표현식
		const reg_id=/^[a-z].{4,9}$/;
		//만일 입력한 아이디가 정규표현식과 매칭되지 않는다면
		if(!reg_id.test(inputId)){
			isIdValid=false; //아이디가 매칭되지 않는다고 표시하고 
			// is-invalid 클래스를 추가한다. 
			document.querySelector("#id").classList.add("is-invalid");
			return; //함수를 여기서 끝낸다 (ajax 전송 되지 않도록)
		}
		
		//2. util 에 있는 함수를 이용해서 ajax 요청하기
		ajaxPromise("checkid.jsp", "get", "inputId="+inputId)
		ajaxPromise("${pageContext.request.contextPath}/users/checkid.do", "get", "inputId="+inputId)
		.then(function(response){
			return response.json();
		})
		.then(function(data){
			console.log(data);
			//data 는 {isExist:true} or {isExist:false} 형태의 object 이다.
			if(data.isExist){//만일 존재한다면
				//사용할수 없는 아이디라는 피드백을 보이게 한다. 
				isIdValid=false;
				// is-invalid 클래스를 추가한다. 
				document.querySelector("#id").classList.add("is-invalid");
			}else{
				isIdValid=true;
				document.querySelector("#id").classList.add("is-valid");
			}
		});
	});
	
	//비밀 번호를 확인 하는 함수 
	function checkPwd(){
		document.querySelector("#pwd").classList.remove("is-valid");
		document.querySelector("#pwd").classList.remove("is-invalid");
		
		const pwd=document.querySelector("#pwd").value;
		const pwd2=document.querySelector("#pwd2").value;
		
		// 최소5글자 최대 10글자인지를 검증할 정규표현식
		const reg_pwd=/^.{5,10}$/;
		if(!reg_pwd.test(pwd)){
			isPwdValid=false;
			document.querySelector("#pwd").classList.add("is-invalid");
			return; //함수를 여기서 종료
		}
		
		if(pwd != pwd2){//비밀번호와 비밀번호 확인란이 다르면
			//비밀번호를 잘못 입력한것이다.
			isPwdValid=false;
			document.querySelector("#pwd").classList.add("is-invalid");
		}else{
			isPwdValid=true;
			document.querySelector("#pwd").classList.add("is-valid");
		}
	}
	
	//비밀번호 입력란에 input 이벤트가 일어 났을때 실행할 함수 등록
	document.querySelector("#pwd").addEventListener("input", checkPwd);
	document.querySelector("#pwd2").addEventListener("input", checkPwd);
	
	//이메일을 입력했을때 실행할 함수 등록
	document.querySelector("#email").addEventListener("input", function(){
		document.querySelector("#email").classList.remove("is-valid");
		document.querySelector("#email").classList.remove("is-invalid");
		
		//1. 입력한 이메일을 읽어와서
		const inputEmail=this.value;
		//2. 이메일을 검증할 정규 표현식 객체를 만들어서
		const reg_email=/@/;
		//3. 정규표현식 매칭 여부에 따라 분기하기
		if(reg_email.test(inputEmail)){//만일 매칭된다면
			isEmailValid=true;
			document.querySelector("#email").classList.add("is-valid");
		}else{
			isEmailValid=false;
			document.querySelector("#email").classList.add("is-invalid");
		}
	});
	
	
	//폼에 submit 이벤트가 발생했을때 실행할 함수 등록
	document.querySelector("#myForm").addEventListener("submit", function(e){
		//console.log(e);
		/*
			입력한 아이디, 비밀번호, 이메일의 유효성 여부를 확인해서 하나라도 유효 하지 않으면
			e.preventDefault(); 
			가 수행 되도록 해서 폼의 제출을 막아야 한다. 
		*/
		//폼 전체의 유효성 여부 알아내기 
		let isFormValid = isIdValid && isPwdValid && isEmailValid;
		if(!isFormValid){//폼이 유효하지 않으면
			//폼 전송 막기 
			e.preventDefault();
		}	
	});
</script>
</body>
</html>