<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<jsp:include page="../../include/icon.jsp"></jsp:include>
<jsp:include page="../../include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<style>
    .content{
      border: 1px dotted gray;
   }
   
   /* 댓글 프로필 이미지를 작은 원형으로 만든다. */
   .profile-image{
      width: 50px;
      height: 50px;
      border: 1px solid #cecece;
      border-radius: 50%;
      margin-right: 10px;
      margin-bottom: 10px;
   }
   /* ul 요소의 기본 스타일 제거 */
   .comments ul{
      padding: 0;
      margin: 0;
      list-style-type: none;
   }
   .comments dt{
      margin-top: 5px;
   }
   .comments dd{
      margin-left: 50px;
   }

   .comments li{
      clear: left;
   }

   .comment-form textarea{
      width: 100%;
      height: 80px;
      border: 1px solid #b8b8b8;
      resize: none;
   }

   /* 댓글에 댓글을 다는 폼과 수정폼은 일단 숨긴다. */
   .comments .comment-form{
      display: none;
   }
   /* .reply_icon 을 li 요소를 기준으로 배치 하기 */
   .comments li{
      position: relative;
   }
   .comments .reply-icon{
      position: absolute;
      top: 1em;
      left: 1em;
      color: gray;
   }
   pre {
     display: block;
     padding: 9.5px;
     margin: 0 0 10px;
     line-height: 1.42857143;
     font-size: 1rem !important;
   }   
   
   .loader{
      /* 로딩 이미지를 가운데 정렬하기 위해 */
      text-align: center;
      /* 일단 숨겨 놓기 */
      display: none;
   }   
   .loader svg{
      animation: sizeAni 1s ease-out infinite;
      color: #198754;
   }
   
   @keyframes sizeAni{
      0%{
         transform: scale(0);
      }
      100%{
         transform: scale(1);
      }
   }
   a{
   		cursor:pointer !important;
   }
</style>
</head>
<body>
<!-- navbar -->
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="cafe" name="thisPage"/>
</jsp:include>
<div class="container my-4 py-4" id="app">
<c:if test="${ not empty param.keyword }">
	<p>	
		<strong>${param.condition }</strong> 조건, 
		<strong>${param.keyword }</strong> 검색어로 검색된 내용 자세히 보기 
	</p>
</c:if>
	<div class="article-head mt-4">
		<div v-bind="detail" class="d-flex flex-column mb-4">
			<div class="profile d-inline-flex me-2">			
					<img v-if="detail.profile != null" class="profile-image" :src="base_url+detail.profile"/>
					<svg v-else class="profile-image text-success" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-emoji-smile-fill" viewBox="0 0 16 16">
						<path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zM7 6.5C7 7.328 6.552 8 6 8s-1-.672-1-1.5S5.448 5 6 5s1 .672 1 1.5zM4.285 9.567a.5.5 0 0 1 .683.183A3.498 3.498 0 0 0 8 11.5a3.498 3.498 0 0 0 3.032-1.75.5.5 0 1 1 .866.5A4.498 4.498 0 0 1 8 12.5a4.498 4.498 0 0 1-3.898-2.25.5.5 0 0 1 .183-.683zM10 8c-.552 0-1-.672-1-1.5S9.448 5 10 5s1 .672 1 1.5S10.552 8 10 8z"/>
					</svg>					
			<div class="writerInfo2 d-flex flex-column">
				<p class="writer fw-bold mb-0"> 
					{{detail.writer}}
				</p>				
				<p class="date text-muted mb-0">
					{{detail.regdate}}
				</p>
			</div>
		</div>
		<div class="category">
			{{detail.category}}
		</div>
		<div class="title my-4 py-2">
			<h2 class="fw-bold">
				{{detail.title}}
			</h2>
		</div>
		<div class="view my-4 pb-4">
			<span class="me-1 text-muted">조회수</span>
			<span class="fw-bold me-3">{{detail.viewCount}}</span>
		</div>
		<div v-html="detail.content" class="mainContent my-5"></div>
	</div>
	
	<ul class="d-flex flex-row ps-0 justify-content-end" style="list-style:none;">	
		<li v-if="detail.writer === id">
			<a class="link-dark text-decoration-none mx-1" :href="'updateform.do?num='+detail.num">수정</a>
		</li>
		<li v-if="detail.writer === id">
			<a class="link-dark text-decoration-none mx-1" :href="'delete.do?num='+detail.num">삭제</a>
		</li>
	</ul>
	
	<ul class="mb-5 d-flex flex-row ps-0 justify-content-center" style="list-style:none;">
	   	<li v-if="detail.prevNum != 0">
			<a class="link-success text-decoration-none" 
			v-on:click.prevent="movePagePrev">
			&lt이전글
			</a>
		</li>
		<li class="mx-3">
			<a class="fw-bold link-success text-decoration-none" href="list.do">목록보기</a>
		</li>
		<li v-if="detail.nextNum != 0">			   
			<a class="link-success text-decoration-none" 
			v-on:click.prevent="movePageNext">
			다음글&gt	     	
	      </a>
		</li>   	    
	</ul>
	<!-- 북마크 -->
	<input type="text" id="urlInput" class="form-control form-control-sm"
	style="display:block; position:absolute; left:-100000px"/>		
	<a id="liveToastBtn" class="text-decoration-none link-success mx-2"
	@click.prevent="urlClipCopy">
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmark-fill" viewBox="0 0 16 16">
			<path d="M2 2v13.5a.5.5 0 0 0 .74.439L8 13.069l5.26 2.87A.5.5 0 0 0 14 15.5V2a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2z"/>
		</svg>
	</a>
	<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
		<div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
			<div class="toast-header">
				<img src="${pageContext.request.contextPath}/resources/images/logo2.png" class="rounded me-2" width="16" height="16" >
				<strong class="me-auto">High-clear!</strong>
	 			<small v-bind:data="today">{{today}}</small>
				<button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
  			<div class="toast-body">
 			URL이 클립보드에 복사되었습니다.
			</div>
		</div>
	</div>
	
	<!-- 좋아요 -->
	<a v-if="isLiked === true" @click.prevent="offLike" class="text-decoration-none link-danger">
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
			<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
		</svg>
	</a>
	<a v-else @click.prevent="onLike" class="text-decoration-none link-danger">
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
			<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
		</svg>
	</a>
	<span v-bind="detail" class="text-muted mx-1">
		{{detail.likeCount}}
	</span>	

	
	<!-- 댓글 -->
	<hr class="mb-3" style="border: solid 1px gray;">
	<p v-bind:value="totalRow" class="fs-5 mb-3"><strong>{{totalRow}}</strong> 개의 댓글</p>
		<!-- 원글에 다는 댓글 제출 폼 -->
		<form @submit.prevent="insertComment" class="comment-form insert-form" 
		action="${pageContext.request.contextPath}/ajax/cafe/commentInsert.do" method="post">
			<!-- 원글의 글번호가 댓글의 ref_group 번호가 된다. -->
			<input type="hidden" name="ref_group" v-bind:value="detail.num"/>
			<!-- 원글의 작성자가 댓글의 대상자가 된다. -->
			<input type="hidden" name="target_id" v-bind:value="detail.writer"/>	      
			<textarea v-if="id!=''" name="content" placeholder="새 댓글 작성하기"></textarea>
			<textarea v-else name="content" style="text-align:center;">댓글 작성을 위해 로그인이 필요합니다.</textarea>			
			<div align="right">
				<button class="btn btn-sm btn-outline-success" type="submit">등록</button>
			</div>		
		</form>

		<div class="comments">
	   		<ul v-for="comment in commentList" :key="comment.num">
	   			<!-- 삭제된 댓글 표시 -->
	   			<li v-if="comment.deleted === 'yes'">삭제된 댓글입니다.</li> 
	   			<!-- 원글에 단 댓글 표시 -->
	   			<li v-else-if="comment.num === comment.comment_group" id="reli+comment.num">
					<dl>
						<dt>
							<svg v-if="comment.profile === null" class="profile-image me-2" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
								<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
								<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
							</svg>
							<img v-else class="profile-image me-2" :src="base_url+comment.profile"/>
							<span class="fw-bold">{{comment.writer}}</span>
							<span class="fw-light text-muted mx-1">{{comment.regdate}}</span>
						</dt>
						<dd>
							<span v-if="comment.num != comment.comment_group" class="p-1 m-1 text-muted" style="font-size:.875rem;">
								<i>@{{comment.target_id}}</i>
							</span>
							<pre id="pre+comment.num">{{comment.content}}</pre>
							<!-- 댓글에 댓글 다는 링크 : reInsertForm 과 연결-->
							<a data-num="comment.num" href="javascript:" class="reply-link text-decoration-none"
								id="'reComment'+comment.num" ref="'reComment'+comment.num"
								:key="'reComment'+comment.num"
								@click="activeReForm(comment.num)"
								style="padding-left:9.5px; color:#198754;">댓글</a>
							<!-- 원글에 단 댓글 수정하는 링크 : updateForm 연결 연결-->
							<a v-if="id !=null && comment.writer===id" data-num="comment.num" v-bind:key="'commentModify'+comment.num"
								class="update-link text-decoration-none link-dark px-2" href="javascript:">수정</a>
							<!-- 원글에 단 댓글 삭제하는 링크 -->
							<a v-if="id !=null && comment.writer===id" data-num="comment.num" v-bind:key="'commentDelete'+comment.num"
								class="delete-link text-decoration-none link-dark" href="javascript:">삭제</a>									
						</dd>	
						<dd>
							<!-- 댓글에 댓글 다는 제출 폼 -->
							<transition enter-active-class="animate__animated animate__fadeIn"
                  						leave-active-class="animate__animated animate__fadeOut">
								<form @submit.prevent="insertComment" id="reInsertForm+comment.num" 
									class="comment-form re-insert-form" 
									:key="'reInsertForm'+comment.num"
									action="${pageContext.request.contextPath}/ajax/cafe/commentInsert.do" method="post">
									<input type="hidden" name="ref_group" value="detail.num"/>
									<input type="hidden" name="target_id" value="comment.writer"/>
				 					<input type="hidden" name="comment_group" value="comment.comment_group"/>
									<textarea name="content"></textarea>
									<div align="right">
										<button class="btn btn-sm btn-outline-success" type="submit">등록</button>
									</div>
								</form>  
							</transition>
						</dd>	
						<dd>
							<!-- 원글에 단 댓글 수정 제출 폼 -->
							<form id="updateForm+comment.num" class="comment-form update-form" 
								action="comment_update.do" method="post">
								<input type="hidden" name="num" value="detail.num" />
				 				<textarea name="content">{{comment.content}}</textarea>
								<div align="right">
									<button class="btn btn-sm btn-outline-success" type="submit">수정</button>
								</div>
							</form>					
						</dd>							
					</dl>	
	   			</li> 
	   			<!--  댓글에 단 댓글 표시 -->
	   			<li v-else="comment.num != comment.comment_group" id="reli+comment.num" style="padding-left:50px;">
	   				<svg class="reply-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">
						<path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>
					</svg>				
					<dl>
						<dt>
							<svg v-if="comment.profile === null" class="profile-image me-2" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
								<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
								<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
							</svg>
							<img v-else class="profile-image me-2" :src="base_url+comment.profile"/>
							<span class="fw-bold">{{comment.writer}}</span>
							<span class="fw-light text-muted mx-1">{{comment.regdate}}</span>
						</dt>
						<dd>
							<span v-if="comment.num != comment.comment_group" class="p-1 m-1 text-muted" style="font-size:.875rem;">
								<i>@{{comment.target_id}}</i>
							</span>
							<pre id="pre+comment.num">{{comment.content}}</pre>
							<!-- 댓글에 댓글 다는 링크 : reInsertForm 과 연결-->
							<a data-num="comment.num" href="javascript:" class="reply-link text-decoration-none"
								style="padding-left:9.5px; color:#198754;">댓글</a>
							<!-- 댓글에 단 댓글 수정하는 링크 -->
							<a v-if="id !=null && comment.writer===id" data-num="comment.num" 
								class="update-link text-decoration-none link-dark px-2" href="javascript:">수정</a>
							<!-- 댓글에 단 댓글 삭제하는 링크 -->	
							<a v-if="id !=null && comment.writer===id" data-num="comment.num" 
								class="delete-link text-decoration-none link-dark" href="javascript:">삭제</a>									
						</dd>	
						<dd>
							<!-- 댓글에 댓글 다는 제출 폼 -->
							<form id="reForm+comment.num" class="animate__animated comment-form re-insert-form" 
								action="comment_insert.do" method="post">
								<input type="hidden" name="ref_group" value="detail.num"/>
								<input type="hidden" name="target_id" value="comment.writer"/>
			 					<input type="hidden" name="comment_group" value="comment.comment_group"/>
								<textarea name="content"></textarea>
								<div align="right">
									<button class="btn btn-sm btn-outline-success" type="submit">등록</button>
								</div>
							</form>  
						</dd>	
						<dd>
							<!-- 댓글에 단 댓글 수정 제출 폼 -->
							<form id="updateForm+comment.num" class="comment-form update-form" 
								action="comment_update.do" method="post">
								<input type="hidden" name="num" value="detail.num" />
				 				<textarea name="content">{{comment.content}}</textarea>
								<div align="right">
									<button class="btn btn-sm btn-outline-success" type="submit">수정</button>
								</div>
							</form>					
						</dd>							
					</dl>				
	   			</li>  			
	   		</ul>
	   		<transition enter-active-class="animate__animated animate__fadeIn"
				leave-active-class="animate__animated animate__fadeOut">
				<div v-if="isLoading" class="d-flex justify-content-center my-3">
					<div class="spinner-border text-success" role="status"></div>
				</div>
			</transition>
			<div @click="moreComment" v-if="isMoreButtonShow" class="d-grid gap-2 my-2">
				<button class="btn btn-outline-success">댓글 더보기</button>
			</div>

		</div>		
	</div>
</div>
<jsp:include page="../../include/footer.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
	//const base_url="http://localhost:8888/minton05";	

	//Vue 객체
	let app = new Vue({
		el:'#app',	
		data:{
			today:'',
			isLoading:false,
			keyword:'',
			encodedK:'',
			condition:'',
			totalRow:0,
			isMoreButtonShow:false,
			totalPageCount:0,//댓글 총 페이지
			pageNum:1,//댓글 페이지 - 초기값1
			commentList:[],
			detail:{},
			id:"",
			isLiked:"",
			base_url,
		},
		computed:{
			
		},
		methods:{

			insertComment(e){
				const self=this;
				//제출할 폼의 참조값
				const form = e.target;
				console.log(form);
				ajaxFormPromise(form)
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 {isSuccess:true}
					console.log(data);
					//댓글을 다시 불러온다. 
					//댓글 정보 읽어오기
					ajaxPromise(base_url+"/ajax/cafe/commentList.do","GET",
							"pageNum="+self.pageNum+"&num="+self.detail.num)	
					.then(function(response){
						return response.json();
					})
					.then(function(data){
						//data는 {num:xx, writer:xx, content: xx . . . . }
						//얻어온 정보를 model에 넣기
						self.commentList=data;
						//만약 댓글 총 페이지가 1개 이하이면 더보기 버튼 숨기기
					})
					//댓글 더보기 처리를 위해 totalPageCount가져오기
					ajaxPromise(base_url+"/ajax/cafe/commentPaging.do","GET",
							"pageNum="+self.pageNum+"&num="+self.detail.num)	
					.then(function(response){
						return response.json();
					})
					.then(function(data){
						//data는 {totalPageCount:x, totalRow:x}
						//얻어온 정보를 model에 넣기
						self.totalRow=data.totalRow;
						self.totalPageCount=data.totalPageCount;
						//만약 댓글 총 페이지가 2 이상이면 더보기버튼 보이기
						if(data.totalPageCount>=2){
							self.isMoreButtonShow=true;
						}
					})
				});
			},
			movePageNext(){ //다음 페이지
				const self=this;	
				//댓글 페이지를 1로 리셋한다
				this.pageNum = 1;
				//글 정보 읽어오기
				ajaxPromise(base_url+"/ajax/cafe/detail.do","GET",
						"num="+self.detail.nextNum+"&keyword="+self.encodedK+"&condition="+self.condition)	
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 {num:xx, writer:xx, content: xx . . . . }
					//얻어온 정보를 model에 넣기
					self.detail=data;
				})
				//댓글 정보 읽어오기
				ajaxPromise(base_url+"/ajax/cafe/commentList.do","GET",
						"pageNum="+self.pageNum+"&num="+self.detail.nextNum)	
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 {num:xx, writer:xx, content: xx . . . . }
					//얻어온 정보를 model에 넣기
					self.commentList=data;
					//만약 댓글 총 페이지가 1개 이하이면 더보기 버튼 숨기기
				})
								
				//로그인한 유저가 좋아요를 눌렀는지 확인
				ajaxPromise(base_url+"/ajax/cafe/isLiked.do",
						"get","liked_user="+self.id+"&cafe_num="+self.detail.nextNum)
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 {isLiked:true/false}
					//console.log(data);
					if(data.isLiked == true){
						//data가 true이면 꽉찬하트 표시
						self.isLiked=true;
					}else{
						//data가 false이면 빈하트 표시
						self.isLiked=false;
					}				
				});	
				
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
				
				//댓글 더보기 처리를 위해 totalPageCount가져오기
				ajaxPromise(base_url+"/ajax/cafe/commentPaging.do","GET",
						"pageNum="+self.pageNum+"&num="+self.detail.nextNum)	
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 {totalPageCount:x, totalRow:x}
					//얻어온 정보를 model에 넣기
					self.totalRow=data.totalRow;
					self.totalPageCount=data.totalPageCount;
					//만약 댓글 총 페이지가 2 이상이면 더보기버튼 보이기
					if(data.totalPageCount>=2){
						self.isMoreButtonShow=true;
					}else{
						self.isMoreButtonShow=false;
					}
				})			
			},			
			movePagePrev(){ //이전 페이지
				const self=this;	
				//댓글 페이지를 1로 리셋한다
				this.pageNum = 1;
				//글 정보 읽어오기
				ajaxPromise(base_url+"/ajax/cafe/detail.do","GET",
						"num="+self.detail.prevNum+"&keyword="+self.encodedK+"&condition="+self.condition)	
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 {num:xx, writer:xx, content: xx . . . . }
					//얻어온 정보를 model에 넣기
					self.detail=data;
				})
				//댓글 정보 읽어오기
				ajaxPromise(base_url+"/ajax/cafe/commentList.do","GET",
						"pageNum="+self.pageNum+"&num="+self.detail.prevNum)	
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 {num:xx, writer:xx, content: xx . . . . }
					//얻어온 정보를 model에 넣기
					self.commentList=data;
					//만약 댓글 총 페이지가 1개 이하이면 더보기 버튼 숨기기
				})
				
				//로그인한 유저가 좋아요를 눌렀는지 확인
				ajaxPromise(base_url+"/ajax/cafe/isLiked.do",
						"get","liked_user="+self.id+"&cafe_num="+self.detail.prevNum)
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 {isLiked:true/false}
					//console.log(data);
					if(data.isLiked == true){
						//data가 true이면 꽉찬하트 표시
						self.isLiked=true;
					}else{
						//data가 false이면 빈하트 표시
						self.isLiked=false;
					}				
				});	
				
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
				
				//댓글 더보기 처리를 위해 totalPageCount가져오기
				ajaxPromise(base_url+"/ajax/cafe/commentPaging.do","GET",
						"pageNum="+self.pageNum+"&num="+self.detail.prevNum)	
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 {totalPageCount:x, totalRow:x}
					//얻어온 정보를 model에 넣기
					self.totalRow=data.totalRow;
					self.totalPageCount=data.totalPageCount;
					//만약 댓글 총 페이지가 2 이상이면 더보기버튼 보이기
					if(data.totalPageCount>=2){
						self.isMoreButtonShow=true;
					}else{
						self.isMoreButtonShow=false;
					}
				})				
			},
			urlClipCopy(){
				//url 클립보드에 복사하기
				var currentUrl = document.getElementById("urlInput");
				currentUrl.value = window.document.location.href;  // 현재 URL				
				currentUrl.select();  // url 값을 select()로 선택
				document.execCommand("copy"); // 클립보드에 복사
				currentUrl.blur();	
				let toastLiveExample = document.getElementById("liveToast");
				let toast=new bootstrap.Toast(toastLiveExample);
				toast.show();
			},
			moreComment(){ //댓글 더 가져오기
				const self=this;
				//마지막 페이지는 totalPageCount 이다. 			
				//현재 페이지가 마지막 페이지인지 여부 알아내기 : 현재페이지 = 마지막페이지, 마지막페이지=0
				let isLast = self.pageNum == self.totalPageCount;
				let isLastNone= self.totalPageCount==0;
				//마지막 페이지가 아니라면 
				if(!isLast && !isLastNone){		         
					//현재 댓글 페이지를 1 증가 시키고 
					self.pageNum++;
					//2초 후 댓글 목록 업데이트
					//로딩바 띄우기
					self.isLoading = true;
					setTimeout(function(){
						ajaxPromise(base_url+"/ajax/cafe/commentList.do","GET",
							"pageNum="+self.pageNum+"&num="+self.detail.num)
						.then(function(response){
							return response.json();
						})
						.then(function(data){
							//console.log(data);
							//데이터를 모델에 추가하고 댓글 다시 불러와서 표시하기
							self.commentList=[...self.commentList, ...data];	
							//console.log(self.commentList);
							//현재 페이지가 마지막 페이지보다 작으면 댓글 더보기 버튼이 나와야 한다. 
							if(self.pageNum < self.totalPageCount){
								self.isMoreButtonShow=true;
							}else{
								self.isMoreButtonShow=false;
							}
							/*
				            //새로 추가된 댓글 li 요소 안에 있는 a 요소를 찾아서 이벤트 리스너 등록 하기 
				            addUpdateListener(".page-"+currentPage+" .update-link");
				            addDeleteListener(".page-"+currentPage+" .delete-link");
				            addReplyListener(".page-"+currentPage+" .reply-link");
				            //새로 추가된 댓글 li 요소 안에 있는 댓글 수정폼에 이벤트 리스너 등록하기
				            addUpdateFormListener(".page-"+currentPage+" .update-form");
				            */
						});
						//로딩바 끄기
						self.isLoading=false;
					}, 2000);
				}					
			},
			offLike(){
				const self=this;
				//likeCount -1, liketo table에서 좋아요 정보 삭제하는 요청
				ajaxPromise(base_url+"/ajax/cafe/offLike.do", "POST", 
						"liked_user="+self.id+"&cafe_num="+self.detail.num)
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 {isSuccess:true}
					if(data.isSuccess){
						//결과를 모델에 반영하기 - 빈하트 표시, counter-1
						self.isLiked=false;
						self.detail.likeCount --;
					}
				})
				
			},
			onLike(){
				const self=this;
				//로그인을 해야 좋아요를 누를 수 있도록 함
				let isExist=false;
				if(self.id === ""){
					Swal.fire({
						title:'',
						text: '로그인을 해야 좋아요를 누를 수 있습니다.',
						icon: 'info',
						confirmButtonColor: '#198754',
						confirmButtonText: '확인'
					}).then((result) => {
						if (result.value) {
							//location.href="${pageContext.request.contextPath}/cafe/list.do";
					  }
					})
				}else{
					//likeCount +1, liketo table에서 좋아요 정보 추가하는 요청
					ajaxPromise(base_url+"/ajax/cafe/onLike.do", "POST", 
							"liked_user="+self.id+"&cafe_num="+self.detail.num)
					.then(function(response){
						return response.json();
					})
					.then(function(data){
						//data는 {isSuccess:true / false}
						//console.log(data);
						if(data.isSuccess){ //isSuccess가 true일 경우에 하트 추가
							//결과를 모델에 반영하기 - 찬하트 표시, counter+1
							self.isLiked=true;
							self.detail.likeCount ++;
						}
					})					
				}				
			},
		},
		created(){			
			const self=this;			
			
			let today=new Date();
			let date=today.toLocaleString();
			self.today=date.toLocaleString('ko-KR');	
			
			let toastTrigger = document.getElementById("liveToastBtn");
			let toastLiveExample = document.getElementById("liveToast");
			if(toastTrigger){
				toastTrigger.addEventListener('click',function(){
					let toast=new bootstrap.Toast(toastLiveExample)
					toast.show();
				})
			}
			
			let condition='${param.condition}';
			let keyword='${param.keyword}';
			let encodedK=encodeURI('${param.keyword}');			
			//키워드와 조건이 존재하면 모델에 넣어주기
			if(!condition){
				self.condition=condition;
			}
			if(!keyword){
				self.keyword=keyword;
				self.encodedK=encodedK;	
			}
			
			//글 정보 읽어오기
			ajaxPromise(base_url+"/ajax/cafe/detail.do","GET",
					"num="+${param.num}+"&keyword="+encodedK+"&condition="+condition)	
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 {num:xx, writer:xx, content: xx . . . . }
				//얻어온 정보를 model에 넣기
				self.detail=data;
			})
			
			//댓글 정보 읽어오기
			ajaxPromise(base_url+"/ajax/cafe/commentList.do","GET",
					"pageNum="+this.pageNum+"&num="+${param.num})	
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 {num:xx, writer:xx, content: xx . . . . }
				//얻어온 정보를 model에 넣기
				self.commentList=data;
				//만약 댓글 총 페이지가 1개 이하이면 더보기 버튼 숨기기
			})
			
			//댓글 정보 읽어오기
			ajaxPromise(base_url+"/ajax/cafe/commentList.do","GET",
					"pageNum="+this.pageNum+"&num="+${param.num})	
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 {num:xx, writer:xx, content: xx . . . . }
				//얻어온 정보를 model에 넣기
				self.commentList=data;
				//만약 댓글 총 페이지가 1개 이하이면 더보기 버튼 숨기기
			})
			
			//로그인한 유저가 좋아요를 눌렀는지 확인
			ajaxPromise(base_url+"/ajax/cafe/isLiked.do",
					"get","liked_user="+'${id}'+"&cafe_num="+${param.num})
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 {isLiked:true/false}
				//console.log(data);
				if(data.isLiked == true){
					//data가 true이면 꽉찬하트 표시
					self.isLiked=true;
				}else{
					//data가 false이면 빈하트 표시
					self.isLiked=false;
				}				
			});	
			
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
			
			//댓글 더보기 처리를 위해 totalPageCount가져오기
			ajaxPromise(base_url+"/ajax/cafe/commentPaging.do","GET",
					"pageNum="+this.pageNum+"&num="+${param.num})	
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 {totalPageCount:x, totalRow:x}
				//얻어온 정보를 model에 넣기
				self.totalRow=data.totalRow;
				self.totalPageCount=data.totalPageCount;
				//만약 댓글 총 페이지가 2 이상이면 더보기버튼 보이기
				if(data.totalPageCount>=2){
					self.isMoreButtonShow=true;
				}
			})
		}
	});

   document.querySelector(".insert-form")
      .addEventListener("submit", function(e){
         //만일 로그인 하지 않았으면 
         if(!${isLogin}){
            //폼 전송을 막고 
            e.preventDefault();
            //로그인 폼으로 이동 시킨다.
            location.href="${pageContext.request.contextPath}/users/loginform.do?url=${pageContext.request.contextPath}/cafe/detail.do?num=${dto.num}";
         }
      });
    
   
   /*
      detail.jsp 페이지 로딩 시점에 만들어진 1 페이지에 해당하는 
      댓글에 이벤트 리스너 등록 하기 
 */
   addUpdateFormListener(".update-form");
   addUpdateListener(".update-link");
   addDeleteListener(".delete-link");
   addReplyListener(".reply-link");
   
   
   //인자로 전달되는 선택자를 이용해서 이벤트 리스너를 등록하는 함수 
   function addUpdateListener(sel){
      //댓글 수정 링크의 참조값을 배열에 담아오기 
      // sel 은  ".page-xxx  .update-link" 형식의 내용이다 
      let updateLinks=document.querySelectorAll(sel);
      for(let i=0; i<updateLinks.length; i++){
         updateLinks[i].addEventListener("click", function(){
            //click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
            const num=this.getAttribute("data-num"); //댓글의 글번호
            document.querySelector("#updateForm"+num).style.display="block";
            
         });
      }
   }
   function addDeleteListener(sel){
      //댓글 삭제 링크의 참조값을 배열에 담아오기 
      let deleteLinks=document.querySelectorAll(sel);
      for(let i=0; i<deleteLinks.length; i++){
         deleteLinks[i].addEventListener("click", function(){
            //click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
            const num=this.getAttribute("data-num"); //댓글의 글번호
            const isDelete=confirm("댓글을 삭제하시겠습니까?");
            if(isDelete){
               // gura_util.js 에 있는 함수들 이용해서 ajax 요청
               ajaxPromise("comment_delete.do", "post", "num="+num)
               .then(function(response){
                  return response.json();
               })
               .then(function(data){
                  //만일 삭제 성공이면 
                  if(data.isSuccess){
                     //댓글이 있는 곳에 삭제된 댓글입니다를 출력해 준다. 
                     document.querySelector("#reli"+num).innerText="삭제된 댓글입니다.";
                  }
               });
            }
         });
      }
   }
   function addReplyListener(sel){
      //댓글 링크의 참조값을 배열에 담아오기 
      let replyLinks=document.querySelectorAll(sel);
      //반복문 돌면서 모든 링크에 이벤트 리스너 함수 등록하기
      for(let i=0; i<replyLinks.length; i++){
         replyLinks[i].addEventListener("click", function(){
            
            if(!${isLogin}){
               const isMove=confirm("로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?");
               if(isMove){
                  location.href=
                     "${pageContext.request.contextPath}/users/loginform.do?url=${pageContext.request.contextPath}/cafe/detail.do?num=${dto.num}";
               }
               return;
            }
            
            //click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
            const num=this.getAttribute("data-num"); //댓글의 글번호
            
            const form=document.querySelector("#reForm"+num);
            
            //현재 문자열을 읽어온다 ( "댓글" or "취소" )
            let current = this.innerText;
            
            if(current == "댓글"){
               //번호를 이용해서 댓글의 댓글폼을 선택해서 보이게 한다. 
               form.style.display="block";
               form.classList.add("animate__fadeIn");
               this.innerText="취소";   
               form.addEventListener("animationend", function(){
                  form.classList.remove("animate__fadeIn");
               }, {once:true});
            }else if(current == "취소"){
               form.classList.add("animate__fadeOut");
               this.innerText="댓글";
               form.addEventListener("animationend", function(){
                  form.classList.remove("animate__fadeOut");
                  form.style.display="none";
               },{once:true});
            }
         });
      }
   }
   
   function addUpdateFormListener(sel){
      //댓글 수정 폼의 참조값을 배열에 담아오기
      let updateForms=document.querySelectorAll(sel);
      for(let i=0; i<updateForms.length; i++){
         //폼에 submit 이벤트가 일어 났을때 호출되는 함수 등록 
         updateForms[i].addEventListener("submit", function(e){
            //submit 이벤트가 일어난 form 의 참조값을 form 이라는 변수에 담기 
            const form=this;
            //폼 제출을 막은 다음 
            e.preventDefault();
            //이벤트가 일어난 폼을 ajax 전송하도록 한다.
            ajaxFormPromise(form)
            .then(function(response){
               return response.json();
            })
            .then(function(data){
               if(data.isSuccess){
                  const num=form.querySelector("input[name=num]").value;
                  const content=form.querySelector("textarea[name=content]").value;
                  //수정폼에 입력한 value 값을 pre 요소에도 출력하기 
                  document.querySelector("#pre"+num).innerText=content;
                  form.style.display="none";
               }
            });
         });
      }

   }

	</script>
</body>
</html>
