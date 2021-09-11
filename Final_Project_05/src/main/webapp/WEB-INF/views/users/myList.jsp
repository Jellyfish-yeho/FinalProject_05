<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
<%-- icon, resource include --%>
<jsp:include page="../../include/icon.jsp"></jsp:include>
<style>


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
	<div style="margin-bottom:100px;"></div>
	<h1 class="fw-bold text-center my-4">작성한 글 목록</h1>
	<div class="alert alert-success alert-dismissible fade show" role="success">
	<h4 class="fw-bold">🏸 회원 전용 페이지입니다.</h4>
	</div>
       	 <table class="table table-hover text-center">
       	 	<thead>
	       	 	<tr>
	       	 		<th>번호</th>
		            <th>카테고리</th>
		            <th>제목</th>
		            <th>작성자</th>
		            <th>날짜</th>
		            <th>조회수</th>
		            <th>
						<svg style="color:#dc3545;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
							<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
						</svg>
		            </th>  
	       	 	</tr>	
       	 	</thead>
       	 	<tbody>
	       	 	<tbody>
					<tr v-if="id === cafe.writer" v-for="(cafe, index) in cafeList" :key="cafe.num">
						<td>{{cafe.num}}</td>
						<td>{{cafe.category}}</td>
						<td>
							<a class="link-dark text-decoration-none fw-bold"
							:href="base_url+'/cafe/detail.do?num='+cafe.num">
								{{cafe.title}}
							</a>
							<%-- 댓글 개수 출력  --%>
							<span v-if="cafe.reply_count != 0" class="mx-2" style="color:#198754;">{{cafe.reply_count}}</span>						              	               
			            	<%-- 이미지가 첨부되어 있을 시 아이콘 출력 --%>
			            	<svg v-if="cafe.content.includes('img')" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-image" viewBox="0 0 16 16">
									<path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
									<path d="M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2h-12zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1h12z"/>
							</svg> 
			            </td>
			            <td v-if="cafe.profile != null">
			           		<img class="listProfile" :src="base_url+cafe.profile"/>
			            	{{cafe.writer}}
			            </td>
			            <td v-else>
							<svg class="profile-image text-success" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-emoji-smile-fill" viewBox="0 0 16 16">
								<path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zM4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM10 8c-.552 0-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5S10.552 8 10 8z"/>
							</svg>	
							{{cafe.writer}}
						</td>        
			            <td>{{cafe.regdate}}</td>
			            <td>{{cafe.viewCount}}</td>
			            <td>{{cafe.likeCount}}</td>			
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
<div style="margin-bottom:100px;"></div>
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
			id:'',
			cafeList:[],
			base_url,
			detailItem:{},
			startPageNum:1,
			endPageNum:5,
			totalPageCount:0,
			pageNum:1, //최초 로딩
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
			movePage(pageNum){
				this.pageNum=pageNum;
				this.updateUI();
			},
			
			updateUI(){
				//cafe 글 목록 요청해서 받아오기
				let self=this;
				//ajax 요청으로 cafe 글 목록을 json으로 받아온다.
				ajaxPromise(base_url+"/ajax/cafe/list.do","get", "pageNum="+this.pageNum
						+"&keyword="+'${id}'+"&condition="+'writer')
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 cafe글 목록이 들어 있는 array
					//console.log(data);
					//받아온 데이터를 data의 모델에 넣어준다
					self.cafeList=data;
				});
				//하단 페이징 처리 데이터 받아오기
				ajaxPromise(base_url+"/ajax/cafe/paging.do","get","pageNum="+this.pageNum
						+"&keyword="+'${id}'+"&condition="+'writer')
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 startPageNum, endPageNum, totalPageCount가 들어 있는 {}
					console.log(data);
					//받아온 데이터를 data의 모델에 넣어준다
					self.startPageNum=data.startPageNum;
					self.endPageNum=data.endPageNum;
					self.totalPageCount=data.totalPageCount;
					//pageNum을 업데이트 => couputed
				});
			}
		},
		created(){
			const self=this;
			this.updateUI();
			//로그인 정보를 얻어와서
			ajaxPromise(base_url+"/ajax/cafe/isLogin.do", "GET")
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 {id:xxx 또는 빈문자열}
				//data에 넣어주기
				self.id=data.id;
				//만약 ID가 로그인한 아이디가 아니면 메인으로 redirect 시키기
				if(data.id != '${id}'){
					location.href="${pageContext.request.contextPath}/";
				}
			})	
		}
	});

</script>
</body>
</html>




