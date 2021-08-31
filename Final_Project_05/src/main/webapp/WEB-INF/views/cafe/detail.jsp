<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/shuttlecock_main.png" type="image/x-icon" />
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
<div class="container my-4 py-4" id="ccontainer">
<!-- 
	<c:if test="${ not empty keyword }">
			<p>	
				<strong>${condition }</strong> 조건, 
				<strong>${keyword }</strong> 검색어로 검색된 내용 자세히 보기 
			</p>
		</c:if>
 -->
	
	<div class="article-head mt-4">
		<div v-bind="detail" class="d-flex flex-column mb-4">
			<div class="profile d-inline-flex me-2">			
					<img v-if="detail.num != null" class="profile-image" :src="base_url+detail.profile"/>
					<svg v-else class="profile-image" xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
						<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
						<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
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
		<div class="mainContent my-5">
			{{detail.content}}
		</div>
	</div>
	
	<ul class="d-flex flex-row ps-0 justify-content-end" style="list-style:none;">	
		<c:if test="${dto.writer eq id }">
			<li>
				<a class="link-dark text-decoration-none mx-1" href="updateform.do?num=${dto.num }">수정</a>
			</li>
			<li>
				<a class="link-dark text-decoration-none mx-1" href="delete.do?num=${dto.num }">삭제</a>
			</li>
		</c:if> 
	</ul>
	
	<ul class="mb-5 d-flex flex-row ps-0 justify-content-center" style="list-style:none;">
	   
	    <c:if test="${dto.prevNum ne 0 }">
	   	<li>
			<a class="link-success text-decoration-none" href="detail.do?num=${dto.prevNum }&keyword=${encodedK }&condition=${condition }">
			&lt이전글
			</a>
		</li>
		</c:if>
		<li class="mx-3">
			<a class="fw-bold link-success text-decoration-none" href="list.do">목록보기</a>
		</li>
		<c:if test="${dto.nextNum ne 0 }">
		<li>			   
			<a class="link-success text-decoration-none" href="detail.do?num=${dto.nextNum }&keyword=${encodedK }&condition=${condition }">
			다음글&gt	     	
	      </a>
		</li>
		</c:if>    	    
	</ul>
	<%-- 북마크 --%>	
	<input type="text" id="urlInput" class="form-control form-control-sm"
	style="display:block; position:absolute; left:-100000px"/>
		
	<a id="bookmark" class="text-decoration-none link-dark mx-2"
	onclick="javascript:urlClipCopy();">
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmark-fill" viewBox="0 0 16 16">
			<path d="M2 2v13.5a.5.5 0 0 0 .74.439L8 13.069l5.26 2.87A.5.5 0 0 0 14 15.5V2a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2z"/>
		</svg>
	</a>
	<%-- 좋아요 / 임시 --%>
	
	<a v-if="isLiked" @click.prevent="offLike" id="like" class="text-decoration-none link-danger">
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
			<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
		</svg>
	</a>
	<a v-else @click.prevent="onLike" id="like" class="text-decoration-none link-danger">
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
			<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
		</svg>
	</a>
	<span id="likeCounter" class="text-muted mx-1">
		{{likeCounter}}
	</span>

	
   <%-- 댓글 목록 --%>
	<hr class="mb-3" style="border: solid 1px gray;">
	<p class="fs-5 mb-3"><strong>${totalRow }</strong> 개의 댓글</p>
	
	<!-- 원글에 댓글을 작성할 폼 -->
	   <form class="comment-form insert-form" action="private/comment_insert.jsp" method="post">
	      <!-- 원글의 글번호가 댓글의 ref_group 번호가 된다. -->
	      <input type="hidden" name="ref_group" value="${num }"/>
	      <!-- 원글의 작성자가 댓글의 대상자가 된다. -->
	      <input type="hidden" name="target_id" value="${dto.writer }"/>
	      
	      <textarea name="content" placeholder="새 댓글 작성하기">
	      <c:if test="${id ==null }">
				댓글 작성을 위해 로그인이 필요합니다.
	      </c:if>
	      </textarea>
	      <div align="right">
	      	<button class="btn btn-sm btn-outline-success" type="submit">등록</button>
	      </div>		
	   </form>
	
   <div class="comments">
		<ul>
			<c:forEach var="tmp" items="${commentList }">
				<c:choose>
					<c:when test="${tmp.deleted eq 'yes' }">
						<li>삭제된 댓글입니다.</li>
					</c:when>
					<c:otherwise>
					<c:if test="${tmp.num eq tmp.comment_group }">
						<li id="reli${tmp.num }">
					</c:if>
					<c:if test="${tmp.num ne tmp.comment_group }">
						<li id="reli${tmp.num }" style="padding-left:50px;">
							<svg class="reply-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">
								<path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>
							</svg>
					</c:if>
							<dl>
								<dt>
									<c:if test="${ empty tmp.profile }">
										<svg class="profile-image me-2" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
					                          <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
					                          <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
					                     </svg>
									</c:if>
									<c:if test="${not empty tmp.profile }">
										<img class="profile-image me-2" src="${pageContext.request.contextPath}${tmp.profile }"/>
									</c:if>
									<span class="fw-bold">${tmp.writer }</span>
									<span class="fw-light text-muted mx-1">${tmp.regdate }</span>
								</dt>
								<dd>
									<c:if test="${tmp.num ne tmp.comment_group }">
										<span class="p-1 m-1 text-muted" style="font-size:.875rem;">
					                     	<i>@${tmp.target_id }</i>
					                    </span>
					                    <pre id="pre${tmp.num }">${tmp.content }</pre>
					                    <a data-num="${tmp.num }" href="javascript:" class="reply-link text-decoration-none"
	                     				style="padding-left:9.5px; color:#198754;">댓글</a>
									</c:if>
									<c:if test="${id ne null && tmp.writer eq id }">
										<a data-num="${tmp.num }" class="update-link text-decoration-none link-dark px-2" href="javascript:">수정</a>
										<a data-num="${tmp.num }" class="delete-link text-decoration-none link-dark" href="javascript:">삭제</a>
									</c:if>
								</dd>
								<dd>
								<%--대댓글 폼 --%>
								<form id="reForm${tmp.num }" class="animate__animated comment-form re-insert-form" 
								action="comment_insert.do" method="post">
									<input type="hidden" name="ref_group"
									value="${dto.num }"/>
									<input type="hidden" name="target_id"
				 					value="${tmp.writer }"/>
				 					<input type="hidden" name="comment_group"
									value="${tmp.comment_group }"/>
									<textarea name="content"></textarea>
									<div align="right">
									<button class="btn btn-sm btn-outline-success" type="submit">등록</button>
									</div>
								</form>  
								</dd>
								<dd>
								<%--대댓글 수정 폼 --%>
								<c:if test="${tmp.writer eq id }">
									<form id="updateForm${tmp.num }" class="comment-form update-form" 
									action="comment_update.jsp" method="post">
										<input type="hidden" name="num" value="${tmp.num }" />
						 				<textarea name="content">${tmp.content }</textarea>
										<div align="right">
										<button class="btn btn-sm btn-outline-success" type="submit">수정</button>
										</div>
									</form>
								</c:if>
								</dd>
							</dl>
						</li>
				</c:otherwise>					
			</c:choose>				
		</c:forEach>
	</ul>
	</div>
		<div class="loader my-4">
			<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-circle-fill" viewBox="0 0 16 16">
				<circle cx="8" cy="8" r="8"/>
			</svg>
		</div>
	</div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script>
	const base_url="http://localhost8888/minton05";	

	//Vue 객체
	let app = new Vue({
		el:'#ccontainer',
		data:{
			detail:{},
			id:"",
			isLiked:false,
			likeCounter:0,
			base_url,
		},
		computed:{
			//likeCounter의 값이 바뀌면 자동으로 반영
			
		},
		methods:{
			//전제조건 : 글정보 불러올 때 좋아요 정보도 같이 불러와야 함
			offLike(){
				//likeCount -1, liketo table에서 좋아요 정보 삭제하는 요청
				ajaxPromise(base_url+"/ajax/cafe/offLike", "POST", 
						"liked_user="+self.id+"&cafe_num="+self.detail.num)
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 {isSuccess:true}
					console.log(data);
				})
				//결과를 모델에 반영하기 - 빈하트 표시, counter-1
				this.isLiked=false;
				this.likeCounter = this.likeCounter -1;
			},
			onLike(){
				//likeCount +1, liketo table에서 좋아요 정보 추가하는 요청
				ajaxPromise(base_url+"/ajax/cafe/onLike", "POST", 
						"liked_user="+self.id+"&cafe_num="+self.detail.num)
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 {isSuccess:true}
					console.log(data);
				})
				//결과를 모델에 반영하기 - 찬하트 표시, counter+1
				this.isLiked=true;
				this.likeCounter = this.likeCounter +1;
			},
		},
		created(){
			const self=this;
			
			//글 정보 읽어오기
			ajaxPromise(base_url+"/ajax/cafe/detail","GET","num="+num)	
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 {num:xx, writer:xx, content: xx . . . . }
				console.log(data);
			})
			//얻어온 정보를 model에 넣기
			self.detail=data;
			
			//로그인 정보를 얻어와서
			ajaxPromise(base_url+"/ajax/cafe/isLogin")
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 {id:xxx 또는 빈문자열}
				console.log(data);
			})
			//얻어온 정보를 model에 넣기
			self.id=data.id;
			
			//id와 글 번호를 전달해서 select된 결과가 있으면 true를 리턴하는 메소드 요청
			ajaxPromise(base_url+"/ajax/cafe/isLiked",
					"get","liked_user="+self.id+"&cafe_num="+self.detail.num)
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 {isLiked:true/false}
				console.log(data);
			});
			//data가 true이면 꽉찬하트 표시
			self.isLiked=true;
			//data가 false이면 빈하트 표시
			self.isLiked=false;
			
			
		}
	});
	
	
	
	/*
		$("#like").on("click",function(){
		if(${isLogin}){
			let likeCounter = Number($("#likeCounter").text());
			$("#likeCounter").text(likeCounter+1);
			//좋아요 개수를 서버로 전송한다
			$.ajax({	
				url:"${pageContext.request.contextPath}/cafe/like_insert.do",
				type:"get",
				data: "likeCounter="+likeCounter+"&num=${dto.num}>",
				success:function(data){
					if(data.isSuccess){
						$("#likeCounter1").text(${dto.likeCount});
					}
				}
			});
		}else{
			alert("로그인 후 좋아요를 누를 수 있습니다.");
		};	
	})
	*/


	//url 클립보드에 복사하기
	var currentUrl = document.getElementById("urlInput");
	currentUrl.value = window.document.location.href;  // 현재 URL 을 세팅해 줍니다.
	function urlClipCopy(){
		currentUrl.select();  // 해당 값이 선택되도록 select() 합니다
		document.execCommand("copy"); // 클립보드에 복사합니다.
		currentUrl.blur();
		alert("URL이 클립보드에 복사되었습니다."); 
	}	
	
	   
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
   
   
   //댓글의 현재 페이지 번호를 관리할 변수를 만들고 초기값 1 대입하기
   let currentPage=1;
   //마지막 페이지는 totalPageCount 이다.  
   let lastPage=${totalPageCount};
   
   //추가로 댓글을 요청하고 그 작업이 끝났는지 여부를 관리할 변수 
   let isLoading=false; //현재 로딩중인지 여부 
   
   /*
      window.scrollY => 위쪽으로 스크롤된 길이
      window.innerHeight => 웹브라우저의 창의 높이
      document.body.offsetHeight => body 의 높이 (문서객체가 차지하는 높이)
   */
   window.addEventListener("scroll", function(){
      //바닥 까지 스크롤 했는지 여부 
      const isBottom = 
         window.innerHeight + window.scrollY  >= document.body.offsetHeight;
      //현재 페이지가 마지막 페이지인지 여부 알아내기
      let isLast = currentPage == lastPage;
      let isLast1= lastPage==0;
      //현재 바닥까지 스크롤 했고 로딩중이 아니고 현재 페이지가 마지막이 아니라면
      if(isBottom && !isLoading && !isLast && !isLast1){
         //로딩바 띄우기
         document.querySelector(".loader").style.display="block";
         
         //로딩 작업중이라고 표시
         isLoading=true;
         
         //현재 댓글 페이지를 1 증가 시키고 
         currentPage++;
         
         /*
            해당 페이지의 내용을 ajax 요청을 통해서 받아온다.
            "pageNum=xxx&num=xxx" 형식으로 GET 방식 파라미터를 전달한다. 
         */
         ajaxPromise("ajax_comment_list.do","get",
               "pageNum="+currentPage+"&num=${dto.num}")
         .then(function(response){
            //json 이 아닌 html 문자열을 응답받았기 때문에  return response.text() 해준다.
            return response.text();
         })
         .then(function(data){
            //data 는 html 형식의 문자열이다. 
            // beforebegin | afterbegin | beforeend | afterend
            document.querySelector(".comments ul")
               .insertAdjacentHTML("beforeend", data);
            //로딩이 끝났다고 표시한다.
            isLoading=false;
            //새로 추가된 댓글 li 요소 안에 있는 a 요소를 찾아서 이벤트 리스너 등록 하기 
            addUpdateListener(".page-"+currentPage+" .update-link");
            addDeleteListener(".page-"+currentPage+" .delete-link");
            addReplyListener(".page-"+currentPage+" .reply-link");
            //새로 추가된 댓글 li 요소 안에 있는 댓글 수정폼에 이벤트 리스너 등록하기
            addUpdateFormListener(".page-"+currentPage+" .update-form");
            
            //로딩바 숨기기
            document.querySelector(".loader").style.display="none";
         });
      }
   });
   
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
               ajaxPromise("private/comment_delete.jsp", "post", "num="+num)
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
                  /*
                     document.querySelector() 는 html 문서 전체에서 특정 요소의 
                     참조값을 찾는 기능
                     
                     특정문서의 참조값.querySelector() 는 해당 문서 객체의 자손 요소 중에서
                     특정 요소의 참조값을 찾는 기능
                  */
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
