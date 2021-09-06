<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>gallery</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
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
      /* 한줄만 text 가 나오고  한줄 넘는 길이에 대해서는 ... 처리 하는 css */
      display:block;
      white-space : nowrap;
      text-overflow: ellipsis;
      overflow: hidden;
    }
    .img-wrapper img{
         width: 100%;
         height: 100%;
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
                                <label class="form-label"for="image">이미지</label>
                                <small class="text-muted">이미지를 선택하거나 폴더에서 끌어다 놓으세요.</small>
                                <input @change="uploadImage" class="my-2 form-control form-control-sm" type="file" name="image" id="image" 
                                   accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
                             </div>
                             <%--<div class="drag-area"></div> --%>
                         </form>
                        <div class="img-wrapper">
                            <img v-bind:src="base_url+previewImagePath"/>
                        </div> 
                    </div>
                </div>
                <div class="modal-footer">
                  <button type="button" class="mb-4 btn btn-sm btn-outline-success" @click="submitClicked">등록</button>
                  <button type="button" class="mb-4 btn btn-sm btn-outline-success" data-bs-dismiss="modal">닫기</button>
              </div>
            </div>
        </div>
    </div>     

    <!-- 갤러리 목록 -->
      <div class="row row-cols-1 row-cols-md-3 g-4">
        <div v-for="(item, index) in galleryList" v-bind:key="item.num" class="col-6 col-md-4 col-lg-3">
            <div class="col align-middle">
            <div class="card text-center mb-3 h-100">
                <a @click.prevent="showDetail(index)" href="">
                    <div class="img-wrapper d-flex justify-content-center align-items-center">
                        <img class="card-img-top" v-bind:src="base_url+item.imagePath" 
                        onerror="this.src='${pageContext.request.contextPath}/resources/images/frown-face.png'"/>
                    </div>
                </a>
                <div class="card-body">
                    <p class="card-text fs-3 fw-bold">{{item.title}}</p>
                    <p class="card-text">by <strong>{{item.writer}}</strong></p>
                    <p><small class="text-muted" style="font-size:0.875rem;">{{item.regdate}}</small></p>
                    <p>
                        <svg style="color:#dc3545;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="me-2 bi bi-heart-fill" viewBox="0 0 16 16">
                           <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
                        </svg>
                        <span class="text-muted">{{item.likeCount}}</span>
                    </p>
                </div>
            </div>
            </div>
        </div>
      </div>

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
   <div class="modal fade" ref="detailModal">
        <div class="modal-dialog modal-dialog-centered modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">{{detailItem.title}}</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body"></div>
                    <div class="card mb-3">
                        <div class="img-wrapper">
                            <img class="card-img-top" v-bind:src="base_url+detailItem.imagePath"/>
                        </div>
                        <div class="card-body">
                            <p class="card-text fs-3 fw-bold">{{detailItem.title }}</p>
                            <p class="card-text">{{detailItem.content }}</p>
                            <p class="card-text">by <strong>{{detailItem.writer}}</strong></p>
                            <p><small class="text-muted" style="font-size:0.875rem;">{{detailItem.regdate}}</small></p>
                            <!-- 북마크 -->  
                            <input type="text" id="urlInput" class="form-control form-control-sm"
                                style="display:block; position:absolute; left:-100000px"/>
                                <a ref="bookmark" class="text-decoration-none link-dark mx-2" @click="urlClipCopy">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bookmark-fill" viewBox="0 0 16 16">
                                        <path d="M2 2v13.5a.5.5 0 0 0 .74.439L8 13.069l5.26 2.87A.5.5 0 0 0 14 15.5V2a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2z"/>
                                    </svg>
                                </a>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>       
</div>

<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
<script>

    const base_url="http://localhost:8888/minton05";

    let app=new Vue({
        el:"#app",
        data:{
            galleryList:[],
            base_url,
            pageNum:1,
            startPageNum:1,
            endPageNum:5,
            totalPageCount:0,
            detailItem:{},
            isMakeForm:false,  //업로드 폼을 만들지 여부
            previewImagePath:""
        },
        computed:{
            /*
                최초 호출된 이후 
                startPageNum 혹은 endPageNum 에 변경이 있을때만
                다시 호출되는 함수 
            */
            pageNums(){
                console.log("pageNums()");
                const nums=[];
                for(i=this.startPageNum; i<=this.endPageNum; i++){
                    nums.push(i);
                }
                return nums;
            }
        },
        methods:{
            urlClipCopy(){
                var currentUrl = document.getElementById("urlInput");
                currentUrl.value = window.document.location.href;  // 현재 URL 을 세팅해 줍니다.
                currentUrl.select();  // 해당 값이 선택되도록 select() 합니다
                document.execCommand("copy"); // 클립보드에 복사합니다.
                currentUrl.blur();
                alert("URL이 클립보드에 복사되었습니다."); 
	        },
            submitClicked(){
                //ref="insertForm" 인 폼을 강제 전송한다(submit 시킨다).
                this.$refs.insertForm.submit();
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
                    console.log(data);
                    //미리보기 사진이 보일수 있도록 한다.
                    self.previewImagePath = data.imagePath;
                    //이미지 경로가 전송될수 있도록 form 안에 input 요소의 value 에 넣어준다. 
                    self.$refs.imagePath.value = data.imagePath;
                });
            },
            showDetail(index){
                //선택된 인덱스에 해당하는 object 를 detailItem 에 대입한다.
                this.detailItem=this.galleryList[index];
                //detail 모달의 참조값 얻어오기 
                let modalElement=this.$refs.detailModal;
                //bootstrap 모달 띄우기 
                let modal=new bootstrap.Modal(modalElement);
                modal.show();
            },
            showInsert(){
                //insert모달의 참조값 얻어오기 
                let modalElement=this.$refs.insertModal;
                //bootstrap 모달 띄우기 
                let modal=new bootstrap.Modal(modalElement);
                modal.show();
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
                    console.log(data);
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
        }
    });
</script>    
</body>
</html>