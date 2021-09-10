<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 목록보기</title>
<%-- icon, resource include --%>
<jsp:include page="../../include/icon.jsp"></jsp:include>
<style>

.colored-toast.swal2-icon-success {
  background-color: #a5dc86 !important;
}
   .page-ui a{
      text-decoration: none;
      color: rgb(2,38,94);
   }
   
   .page-ui a:hover{
      text-decoration: underline;
   }
   
   .page-ui a.active{
      color: rgb(2,38,94);
      font-weight: bold;
      text-decoration: underline;
   }
   .page-ui ul{
      list-style-type: none;
      padding: 0;
   }
   
   .listProfile{
   		width:15px;
   		height:15px;
   		border-radius:50%;
   }
   	h1 {
		color: rgb(2,38,94); 
		text-shadow:1px 1px 1px rgb(1,148,148); 
		margin: 0; 
		padding: 10px; 
		font-weight: bold; 
	}
	th{
		color: #198754; 
	}

	a{
		color:rgb(2,38,94);
		text-decoration: none;
	}
	html {
	  	height: 100%;
	}

	#app{
		margin:0 auto; 
		padding:20px; 
		background-color:rgb(255,255,255, 0.9); 
		border-radius: 30px
	}
</style>
</head>
<body>
<%-- navbar--%>
<jsp:include page="../../include/navbar.jsp"></jsp:include>
<div class="container my-4" id="app">
	<h1 class="fw-bold text-center my-4">문의글 목록</h1>
	<div class="alert alert-warning alert-dismissible fade show" role="alert">
	<h4 class="fw-bold">🏸 관리자 전용 페이지입니다.</h4>
	<br />
	<p class="text-muted">해결된 문의만 체크하십시오.</p>
	</div>
       	 <table class="table table-hover text-center">
       	 	<thead>
	       	 	<tr>
	       	 		<th>번호</th>
	       	 		<th>ID</th>
	       	 		<th>제목</th>
	       	 		<th>내용</th>
	       	 		<th>연락처</th>
	       	 		<th>해결 여부</th>
	       	 	</tr>	
       	 	</thead>
       	 	<tbody>
	       	 	<tr v-for="(inquiry, index) in inquiryList" :key="inquiry.num"
	       	 	ref="row+inquiry.num">
		       	 	<td>{{inquiry.num}}</td>
		       	 	<td>{{inquiry.id}}</td>
		       	 	<td>{{inquiry.title}}</td>
	       	 		<td>{{inquiry.content}}</td>
	       	 		<td>{{inquiry.phone}}</td>
	       	 		<td>
	       	 			<input class="form-check-input me-1" type="checkbox" 
	       	 			@change="confirmAsk(inquiry.num)" ref="checkbox+inquiry.num"
	       	 			:checked="inquiry.solved==='yes'?true:false"
	       	 			:disabled="inquiry.solved==='yes'?true:false">
					</td>
				</tr>	
			</tbody>	
		</table>
		<div class="page-ui my-4">
			<!-- 페이징 -->
			<ul class="pagination justify-content-center">
				<li v-if="startPageNum != 1" class="page-item">
					<a v-on:click.prevent="movePage(startPageNum-1)" class="page-link" href="">&lt;</a>
				</li> 
				<li v-else class="page-item disabled">
					<a href="javascript:" class="page-link">&lt;</a>
				</li> 
				
				<li v-for="i in pageNums" class="page-item" :class="{active:i==pageNum}">
					<a v-on:click.prevent="movePage(i)" class="page-link" href="">{{i}}</a>
				</li> 
				
				<li v-if="endPageNum < totalPageCount" class="page-item">
					<a v-on:click.prevent="movePage(endPageNum+1)" class="page-link" href="">&gt;</a>
				</li> 
				<li v-else class="page-item disabled">
					<a class="page-link" href="javascript:">&gt;</a>
				</li>
			</ul>	
		</div>
	</div>

<%-- footer --%>
<jsp:include page="../../include/footer.jsp"></jsp:include>

<script src="../resources/js/gura_util.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	let app=new Vue({
		el:"#app",
		data:{
			inquiryList:[],
			base_url,
			pageNum:1,
			startPageNum:1,
			endPageNum:5,
			totalPageCount:0,
		},
		computed:{
			pageNums(){
				const nums=[];
				for(i=this.startPageNum; i<=this.endPageNum; i++){
					nums.push(i);
				}
				return nums;
			}
		},
		methods:{
			confirmAsk(num){
				const self=this;
				const Toast = Swal.mixin({
					toast: true,
					position: 'top-right',
					iconColor: 'white',
					customClass: {
						popup: 'colored-toast'
					},
					showConfirmButton: false,
				})
				Swal.fire({
					title:'문의 해결 처리 여부',
					text:'해당 문의를 해결 처리하시겠습니까?',
					icon:'warning',
					confirmButtonColor: '#198754',
					confirmButtonText:"예",
					showCancelButton:true,
					cancelButtonText:"아니오",
				}).then((result)=>{
					if(result.isConfirmed){
						ajaxPromise(base_url+"/ajax/inquiry/solved.do","post","num="+num)
						.then(function(response){
							return response.json();
						})
						.then(function(data){
							console.log(data);
							self.updateUI();
						});
					}else{
						location.href="${pageContext.request.contextPath}/users/inquiryList.do";
					}
				})
				
			},
			movePage(pageNum){
				this.pageNum=pageNum;
				this.updateUI();
			},
			updateUI(){
				//inquiry 글 목록 요청해서 받아오기
				let self=this;
				//ajax 요청으로 inquiry 목록을 json으로 받아온다.
				ajaxPromise(base_url+"/ajax/inquiry/list.do","get", "pageNum="+this.pageNum)
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 inquiry 목록이 들어 있는 array
					//console.log(data);
					//받아온 데이터를 data의 모델에 넣어준다
					self.inquiryList=data;
				});
				//하단 페이징 처리 데이터 받아오기
				ajaxPromise(base_url+"/ajax/inquiry/paging.do","get","pageNum="+this.pageNum)
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 startPageNum, endPageNum, totalPageCount가 들어 있는 {}
					//console.log(data);
					//받아온 데이터를 data의 모델에 넣어준다
					self.startPageNum=data.startPageNum;
					self.endPageNum=data.endPageNum;
					self.totalPageCount=data.totalPageCount;
					//pageNum을 업데이트 => couputed
				});
			}
		},
		created(){
			this.updateUI();
			//로그인 정보를 얻어와서
			ajaxPromise(base_url+"/ajax/cafe/isLogin.do", "GET")
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 {id:xxx 또는 빈문자열}
				//만약 ID가 admin이 아니면 메인으로 redirect 시키기
				if(data.id != 'admin'){
					location.href="${pageContext.request.contextPath}/";
				}
			})	
		}
	});

</script>
</body>
</html>




