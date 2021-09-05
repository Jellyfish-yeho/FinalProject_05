<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/shuttlecock_main.png" type="image/x-icon" />
<%-- icon, resource include --%>
<jsp:include page="../../include/icon.jsp"></jsp:include>
<jsp:include page="../../include/resource.jsp"></jsp:include>
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

	#ccontainer{
		margin:0 auto; 
		padding:5px; 
		background-color:rgb(255,255,255, 0.9); 
		border-radius: 30px
	}
</style>
</head>
<body>
<%-- navbar include : notice - thisPage --%>
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="notice" name="thisPage"/>
</jsp:include>
<div class="container my-4" id="app">
	<h1 class="fw-bold text-center my-4 ">공지사항</h1>
	<div class="mb-2" style="float:right;">
		
	<c:if test="${id eq 'admin'}">
		<a class="link-success text-decoration-none" href="insertform.do">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
				<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
			</svg>
         	새 글 작성
		</a>
	</c:if>		
	</div>
	<table class="table table-hover text-center">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
	            <th>조회수</th>           
			</tr>
		</thead>
		<tbody>
			<tr v-for="notice in noticeList" :key="notice.num">
	            <td>{{notice.num}}</td>
	            <td>
	               <a class="link-dark text-decoration-none fw-bold" 
	               :href="base_url+'/notice/detail.do?num='+notice.num+'&keyword='+keyword+'&condition='+condition">{{notice.title}}</a>
	            </td>
	            <td>
	            	<svg class="text-success profile-image" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-gear-fill" viewBox="0 0 16 16">
						<path d="M9.405 1.05c-.413-1.4-2.397-1.4-2.81 0l-.1.34a1.464 1.464 0 0 1-2.105.872l-.31-.17c-1.283-.698-2.686.705-1.987 1.987l.169.311c.446.82.023 1.841-.872 2.105l-.34.1c-1.4.413-1.4 2.397 0 2.81l.34.1a1.464 1.464 0 0 1 .872 2.105l-.17.31c-.698 1.283.705 2.686 1.987 1.987l.311-.169a1.464 1.464 0 0 1 2.105.872l.1.34c.413 1.4 2.397 1.4 2.81 0l.1-.34a1.464 1.464 0 0 1 2.105-.872l.31.17c1.283.698 2.686-.705 1.987-1.987l-.169-.311a1.464 1.464 0 0 1 .872-2.105l.34-.1c1.4-.413 1.4-2.397 0-2.81l-.34-.1a1.464 1.464 0 0 1-.872-2.105l.17-.31c.698-1.283-.705-2.686-1.987-1.987l-.311.169a1.464 1.464 0 0 1-2.105-.872l-.1-.34zM8 10.93a2.929 2.929 0 1 1 0-5.86 2.929 2.929 0 0 1 0 5.858z"/>
					</svg>
	            	{{notice.writer}}
	            </td>
	            <td>{{notice.regdate}}</td>
	            <td>{{notice.viewCount}}</td>
	         </tr>	
		</tbody>
	</table>
	<div class="page-ui">
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
	
	<!-- 검색 -->  
	<form @submit.prevent="updateUI" action="${pageContext.request.contextPath}/ajax/notice/list.do" method="get" ref="searchForm"> 
		<div class="row g-3 align-items-center my-4">
			<div class="col-auto">
				<label class="form-label mb-0 fw-bold" for="condition">검색조건</label>
			</div>
			<div class="col-auto">	
				<select v-model="condition" class="form-select form-select-sm" name="condition" id="condition">
					<option value="title_content">제목+내용</option>
					<option value="title">제목</option>
					<option value="writer">작성자</option>
				</select>
			</div>
			<div class="col-auto">
				<input class="form-control form-control-sm" type="text" id="keyword" name="keyword" 
				placeholder="검색어..." v-model="keyword"/>
			</div>
			<div class="col-auto">
				<button class="btn btn-outline-success btn-sm" type="submit">검색</button>
			</div>
		</div>
	</form>    
   
   <c:if test="${not empty condition}">
		<p class="my-3" style="font-size:0.875rem;">
			<strong>${totalRow}</strong> 개의 글이 검색되었습니다.
		</p>
   </c:if>
</div>

<%-- footer --%>
<jsp:include page="../../include/footer.jsp"></jsp:include>
<script src="../resources/js/gura_util.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<script>

const base_url="http://localhost:8888/minton05";

let app=new Vue({
	el:"#app",
	data:{
		condition:"",
		keyword:"",
		firstNotice:{},
		noticeList:[],
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
			//notice 글 목록 요청해서 받아오기
			let self=this;
			//ajax 요청으로 notice 글 목록을 json으로 받아온다.
			ajaxPromise(base_url+"/ajax/notice/list.do","get", "pageNum="+this.pageNum+
					"&keyword="+this.keyword+"&condition="+this.condition)
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 notice글 목록이 들어 있는 array
				//console.log(data);
				//받아온 데이터를 data의 모델에 넣어준다
				self.noticeList=data;
			});
			//하단 페이징 처리 데이터 받아오기
			ajaxPromise(base_url+"/ajax/notice/paging.do","get","pageNum="+this.pageNum+
					"&keyword="+this.keyword+"&condition="+this.condition)
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
	}
});




</script>
</body>
</html>