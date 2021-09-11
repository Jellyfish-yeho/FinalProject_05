<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gallery</title>
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
   /* card 이미지 부모요소의 높이 지정 */
   .img-wrapper{
      height: 250px;
      /* transform 을 적용할대 0.3s 동안 순차적으로 적용하기 */
      transition: transform 0.3s ease-out;
   }
   /* .img-wrapper 에 마우스가 hover 되었을때 적용할 css */
    .img-wrapper:hover{
      /* 원본 크기의 1.1 배로 확대 시키기*/
      transform: scale(1.05);
   } 
   
   .card .card-text{
      /* 한줄만 text 가 나오고  한줄 넘는 길이에 대해서는...처리 하는 css */
      display:block;
      white-space : nowrap;
      text-overflow: ellipsis;
      overflow: hidden;
    }
    .img-wrapper img{
         width: 90%;
         height: 90%;
         /* fill | contain | cover | scale-down | none(default) */
         /*   
            cover - 부모의 크기에 맞게 키운 후, 자른다. 비율은 일정하게 증가한다. 
            contain - 안잘린다. 대신 빈 공간이 남을 수 있다.
            fill - 부모의 크기에 딱 맞게, 비율 관계 없이 맞춘다.(이미지가 일그러질 수 있다.)
            scale-down - 가로, 세로 중에 큰 것을 부모의 크기에 맞춘 상태까지만 커지거나 작아지고, 비율은 일정하다.
         */
        object-fit: contain;   
    }
    .drag-area{
      width: 500px;
      height:100px;
      border: 1px solid gray;
      border-radius: 10px;
    }
   	#content{
		height: 200px;
		resize: none;
	}
	a{
   		cursor:pointer !important;
   }
</style>
</head>
<body>
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="gallery" name="thisPage"/>
</jsp:include>
<div class="container" id="app">
	<h1 class="fw-bold my-4 text-center">갤러리</h1>
	
    <!--새글작성 링크-->
    <div class="mb-2 d-flex justify-content-end">
        <a @click.prevent="showInsert()" class="link-success text-decoration-none" href="">
           <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
              <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
              <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
           </svg>
           	새 사진 올리기
        </a>
    </div>
    
    <!--새글작성 모달-->
    <div class="modal fade" ref="insertModal">
        <div class="modal-dialog modal-dialog-centered modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">새 사진 올리기</h5>
                </div>
                <div class="modal-body">
                    <div class="card mb-3">
                        <form action="http://localhost:8888/minton05/gallery/ajax_insert.do" method="post" ref="insertForm">
                            <input type="hidden" name="imagePath" ref="imagePath"/>
                            <div class="d-flex d-inline-flex flex-column mb-3">
                                <label class="form-label" for="title">제목</label>
                                <input class="form-control form-control-sm" type="text" name="title" id="title"/>
                            </div>
                            <div class=" mb-3">
                                <label class="form-label" for="content">내용</label>
                                <textarea class="form-control form-control-sm" name="content" id="content"></textarea>
                            </div>
                         </form>
                         <form action="http://localhost:8888/minton05/gallery/ajax_upload2.do" method="post" ref="ajaxForm" enctype="multipart/form-data">
                            <div class="d-flex d-inline-flex flex-column mb-3">
                                <label class="form-label" for="image">이미지</label>
                                <small class="text-muted">이미지를 선택하거나 폴더에서 끌어다 놓으세요.</small>
                                <input @change="uploadImage" class="my-2 form-control form-control-sm" type="file" name="image" id="image" 
                                   accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
                             </div>
                             <div class="drag-area"></div>
                         </form>
                         <!-- 이미지미리보기 -->
                        <div v-if="previewImagePath === ''">
                        </div>
                        <div v-else class="img-wrapper">
                        	<img v-bind:src="base_url+previewImagePath"/>  
                        </div> 
                    </div>
                </div>
                <div class="modal-footer">
                  <button type="button" @click="submitClicked" class="mb-4 btn btn-sm btn-outline-success" data-bs-dismiss="modal">등록</button>
                  <button type="button" class="mb-4 btn btn-sm btn-outline-success" data-bs-dismiss="modal">닫기</button>
              </div>
            </div>
        </div>
    </div>

    <!-- 갤러리 목록 -->
      <div class="row row-cols-1 row-cols-md-3 g-4">
        <div v-for="(item, index) in galleryList" v-bind:key="item.num">
            <div class="card text-center mb-3 h-100 col align-middle">
                <a @click.prevent="showDetail(item.num)" href="">
                    <div class="img-wrapper d-flex justify-content-center align-items-center">
                        <img class="card-img-top" v-bind:src="base_url+item.imagePath" 
                        onerror="this.src='${pageContext.request.contextPath}/resources/images/frown-face.png'"/>
                    </div>
                </a>
                <div class="card-body">
                    <p class="card-text fs-3 fw-bold">{{item.title}}</p>
                    <p class="card-text">by <strong>{{item.writer}}</strong></p>
                    <p><small class="text-muted" style="font-size:0.875rem;">{{item.regdate}}</small></p>
                    <!-- 좋아요 -->
                    <p>
						<a class="text-decoration-none link-danger">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
								<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
							</svg>
						</a>
						<span class="text-muted mx-1">
							{{item.likeCount}}
						</span>
                    </p>
                    
                </div>
            </div>
        </div>
      </div>
      <br>

    <!-- 페이징 -->
    <nav>
        <ul class="pagination justify-content-center">
            <li class="page-item" v-if="startPageNum != 1">
                <a v-on:click.prevent="movePage(startPageNum-1)" class="page-link" href="">&lt;</a>
            </li>
            <li class="page-item disabled" v-else>
                <a class="page-link" href="javascript:">&lt;</a>
            </li>
            <li v-for="i in pageNums" class="page-item" v-bind:class="{active: i == pageNum }">
                <a v-on:click.prevent="movePage(i)"  class="page-link" href="">{{i }}</a>
            </li>
            <li class="page-item" v-if="endPageNum < totalPageCount">
                <a v-on:click.prevent="movePage(endPageNum+1)"  class="page-link" href="">&gt;</a>
            </li>
            <li class="page-item disabled" v-else>
                <a class="page-link" href="javascript:">&gt;</a>
            </li>
        </ul>
    </nav>  
    
   <!-- 갤러리 자세히보기 Modal -->
   <div class="modal fade" ref="detailModal" v-if="isDetailModalShow">
        <div class="modal-dialog modal-dialog-centered-scrollable modal-xl text-center">
            <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">{{detailItem.num}}</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body"></div>
                    <div class="card mb-3">
                        <div class="img-wrapper">
                        	<br>
                            <img class="card-img-top" v-bind:src="base_url+detailItem.imagePath"/>
                        </div>
                        <div class="card-body">
                        	<br>
                            <p class="card-text fs-3 fw-bold">{{detailItem.title }}</p>
                            <p class="card-text">{{detailItem.content }}</p>
                            <p class="card-text">by <strong>{{detailItem.writer}}</strong></p>
                            <p><small class="text-muted" style="font-size:0.875rem;">{{detailItem.regdate}}</small></p>
							
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
							<span v-bind="detailItem" class="text-muted mx-1">
								{{detailItem.likeCount}}
                        </div>
                        <!-- 이전글 목록 다음글 -->
                        <ul class="mb-5 d-flex flex-row ps-0 justify-content-center" style="list-style:none;">
					         <li v-if="detailItem.prevNum != 0">
								<a class="link-success text-decoration-none" @click.prevent="showPrevNumDetail">
								&lt이전글
								</a>
							</li>		
					       	<li class="mx-3">
								<a class="fw-bold link-success text-decoration-none" data-bs-dismiss="modal">목록보기</a>
							</li>
				       		<li v-if="detailItem.nextNum != 0">			   
								<a class="link-success text-decoration-none" @click.prevent="showNextNumDetail">
								다음글&gt	     	
						      </a>
						    </li>
						</ul>
						<!-- 수정 삭제 -->
						<ul class="d-flex flex-row ps-0 justify-content-center" style="list-style:none;">	
							<li v-if="detailItem.writer === id">
								<a class="link-success text-decoration-none mx-1" v-bind:href="'updateform.do?num='+detailItem.num">수정</a>
							</li>
							<li v-if="detailItem.writer === id">
								<a class="link-success text-decoration-none mx-1" v-bind:href="'delete.do?num='+detailItem.num">삭제</a>
							</li>
						</ul>
                    </div>
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>       
</div>

<jsp:include page="../../include/footer.jsp"></jsp:include>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>

    //const base_url="http://localhost:8888/minton05";

    let app=new Vue({
        el:"#app",
        data:{
			today:'',
            galleryList:[],
            base_url,
            pageNum:1,
            startPageNum:1,
            endPageNum:5,
            totalPageCount:0,
            detailItem:{},
            isMakeForm:false,  //업로드 폼을 만들지 여부
            previewImagePath:"",
            isDetailModalShow: true,
            id:"",
			isLiked:"",
        },
        computed:{
            /*
                        최초 호출된 이후 startPageNum 혹은 endPageNum 에 변경이 있을때만 다시 호출되는 함수 
            */
            pageNums(){
                //console.log("pageNums()");
                const nums=[];
                for(i=this.startPageNum; i<=this.endPageNum; i++){
                    nums.push(i);
                }
                return nums;
            }
        },
        methods:{
 			offLike(){
				const self=this;
				//likeCount -1, liketo table에서 좋아요 정보 삭제하는 요청
				ajaxPromise(base_url+"/ajax/gallery/offLike.do", "POST", 
						"liked_user="+self.id+"&gallery_num="+self.detailItem.num)
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					//data는 {isSuccess:true}
					if(data.isSuccess){
						//결과를 모델에 반영하기 - 빈하트 표시, counter-1
						self.isLiked=false;
						self.detailItem.likeCount --;
						//갤러리 목록 업데이트
						// ajax 요청을 통해서 gallery 목록을 json 으로 받아온다.
		                ajaxPromise(base_url+"/api/gallery/list.do", "GET", "pageNum="+self.pageNum)
		                .then(function(response){
		                    return response.json();
		                })
		                .then(function(data){
		                    //data 는 gallery 목록이 들어있는 array 이다.
		                    //console.log(data);
		                    self.galleryList=data;
		                });
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
					ajaxPromise(base_url+"/ajax/gallery/onLike.do", "POST", 
							"liked_user="+self.id+"&gallery_num="+self.detailItem.num)
					.then(function(response){
						return response.json();
					})
					.then(function(data){
						//data는 {isSuccess:true / false}
						//console.log(data);
						if(data.isSuccess){ //isSuccess가 true일 경우에 하트 추가
							//결과를 모델에 반영하기 - 찬하트 표시, counter+1
							self.isLiked=true;
							self.detailItem.likeCount ++;
							//갤러리 목록 업데이트
							// ajax 요청을 통해서 gallery 목록을 json 으로 받아온다.
			                ajaxPromise(base_url+"/api/gallery/list.do", "GET", "pageNum="+self.pageNum)
			                .then(function(response){
			                    return response.json();
			                })
			                .then(function(data){
			                    //data 는 gallery 목록이 들어있는 array 이다.
			                    //console.log(data);
			                    self.galleryList=data;
			                });
						}
					})
				}
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
            submitClicked(){
	        	const self=this;
                //ref="insertForm" 인 폼을 강제 전송한다(submit 시킨다).
                //this.$refs.insertForm.submit();
                //폼 제출 수행
                let form=this.$refs.insertForm;
                ajaxFormPromise(form)
                .then(function(response){
                	return response.json();
                })
                .then(function(data){
                	//data는 {isSuccess:true}
                	//버튼을 누르면 모달이 자동 닫힘, 알림창 띄워주기
                	Swal.fire({
						title:'작성 성공',
						text: '새 글 작성에 성공하였습니다.',
						icon: 'success',
						confirmButtonColor: '#198754',
						confirmButtonText: '확인'
					}).then((result) => {
						if (result.value) {
							location.href="${pageContext.request.contextPath}/gallery/list.do";
					  }
					})

                });
            },
            uploadImage(){
                let self=this;
                //폼의 참조값
                const form=this.$refs.ajaxForm;
                ajaxFormPromise(form)
                .then(function(response){
                    return response.json();
                })
                .then(function(data){
                    //console.log(data);
                    //미리보기 사진이 보일수 있도록 한다.
                    self.previewImagePath = data.imagePath;
                    //이미지 경로가 전송될수 있도록 form 안에 input 요소의 value 에 넣어준다. 
                    self.$refs.imagePath.value = data.imagePath;
                });
            },
            showDetail(num){
            	const self=this;
                //선택된 인덱스에 해당하는 object 를 detailItem 에 대입한다.
                //로그인한 유저가 좋아요를 눌렀는지 확인
				ajaxPromise(base_url+"/ajax/gallery/isLiked.do",
						"get","liked_user="+'${id}'+"&gallery_num="+num)
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
                ajaxPromise(base_url+"/ajax/gallery/getDetail.do", "GET", "num="+num)
                .then(function(response){
                    return response.json();
                })
                .then(function(data){
                    //data 는 이전글의 정보 {num:xx, writer:xx...}
                    //console.log(data);
                    self.detailItem=data;
                });    
                //detail 모달의 참조값 얻어오기 
                let modalElement=this.$refs.detailModal;
                //bootstrap 모달 띄우기 
                let modal=new bootstrap.Modal(modalElement);
                modal.show();
            },
            showPrevNumDetail(){
            	const self=this;
                ajaxPromise(base_url+"/ajax/gallery/getDetail.do", "GET", "num="+self.detailItem.prevNum)
                .then(function(response){
                    return response.json();
                })
                .then(function(data){
                    //data 는 이전글의 정보 {num:xx, writer:xx...}
                    //console.log(data);
                    self.detailItem=data;
                });        	
            },  
            showNextNumDetail(){
            	const self=this;
                ajaxPromise(base_url+"/ajax/gallery/getDetail.do", "GET", "num="+self.detailItem.nextNum)
                .then(function(response){
                    return response.json();
                })
                .then(function(data){
                    //data 는 다음글의 정보 {num:xx, writer:xx...}
                    //console.log(data);
                    self.detailItem=data;
                });        	
            },   
            showInsert(){
            	const self=this;
                //insert모달의 참조값 얻어오기 
                let modalElement=this.$refs.insertModal;
                //bootstrap 모달 띄우기 
                let modal=new bootstrap.Modal(modalElement);
                modal.show();
               
   			 // dragenter 이벤트가 일어 났을때 실행할 함수 등록 
     		   document.querySelector(".drag-area")
     		      .addEventListener("dragenter", function(e){
     		         // drop 이벤트까지 진행될수 있도록 기본 동작을 막는다.
     		         e.preventDefault();
     		      });
     		   
     		   // dragover 이벤트가 일어 났을때 실행할 함수 등록 
     		   document.querySelector(".drag-area")
     		   .addEventListener("dragover", function(e){
     		      // drop 이벤트까지 진행될수 있도록 기본 동작을 막는다.
     		      e.preventDefault();
     		      e.stopPropagation();
     		   });
     			// dragover 이벤트가 일어 났을때 실행할 함수 등록 
     			document.querySelector(".drag-area").addEventListener("drop", function(e){	      
     				e.preventDefault();
     				e.stopPropagation();
     				//drop 된 파일의 여러가지 정보를 담고 있는 object 
     				const data = e.dataTransfer;
     				//drop 된 파일객체를 저장하고 있는 배열
     				const files = data.files;
     			      
     			      // input 요소에 drop 된 파일정보를 넣어준다. 
     			      document.querySelector("#image").files = files;
     			      // 한개만 drop 했다는 가정하에서 drop 된 파일이 이미지 파일인지 여부 알아내기
     			      const reg=/image.*/;
     			      const file = files[0];
     			      //drop 된 파일의 mime type 확인
     			      if(file.type.match(reg)){
     			         self.uploadImage();
     			      }else{
     			         alert("이미지 파일만 업로드 가능합니다.");
     			      }
     			   });	 

            },
            updateUI(){
                //겔러리 목록을 요청해서 받아온다.
                let self=this;
                // ajax 요청을 통해서 gallery 목록을 json 으로 받아온다.
                ajaxPromise(base_url+"/api/gallery/list.do", "GET", "pageNum="+this.pageNum)
                .then(function(response){
                    return response.json();
                })
                .then(function(data){
                    //data 는 gallery 목록이 들어있는 array 이다.
                    //console.log(data);
                    self.galleryList=data;
                });
                //페이징 처리에 관련된 값도 요청해서 받아온다. 
                ajaxPromise(base_url+"/api/gallery/paging.do", "GET", "pageNum="+this.pageNum)
                .then(function(response){
                    return response.json();
                })
                .then(function(data){
                    //data 는 {"startPageNum": x, "endPageNum":x, "totalPageCount":x} 형식이다
                    self.startPageNum=data.startPageNum;
                    self.endPageNum=data.endPageNum;
                    self.totalPageCount=data.totalPageCount;
                }); 
            },
            movePage(pageNum){
                //현재 페이지를 수정하고 
                this.pageNum=pageNum;
                //화면 업데이트
                this.updateUI();
            }
        },
        created(){
        	//화면 업데이트
            this.updateUI();  
        	
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

        }
    });
</script>    
</body>
</html>