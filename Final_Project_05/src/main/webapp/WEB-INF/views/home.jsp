<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>High-clear</title>
<%-- resource include --%>
<jsp:include page="../include/resource.jsp"></jsp:include>

<link rel="icon" href="${pageContext.request.contextPath}/resources/images/shuttlecock_main.png" type="image/x-icon" />
<style>
   .modal {
   	  margin-top: -200px !important;
      top: 50% !important;	
      margin-left: -120px !important;	
      left: 50% !important;	
   	  position: fixed;
   	  height: 440px !important;
   	  width: 300px !important;
   	  }
    .modal-content {
    	margin-top: -200px !important;
      	top: 50% !important;
      	margin-left: -120px !important;	
      	left: 50% !important;	
     	height: 300px !important;
    	width: 240px !important;
    	}

	/*글자 css*/
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
	th{
		color: rgb(0,136,236); 
	}
	td{
		color:rgb(2,38,94);
		font-size: 1em; 
	}
	a{
		color:rgb(2,38,94);
		text-decoration: none;
	}

	/* 갤러리 carousel css*/
	.col-md-3{
	  display: inline-block;
	}
	.col-md-3 img{
	  width:100%;
	  height:auto;
	}
	
</style>
</head>
<body>

<jsp:include page="../include/navbar.jsp"></jsp:include>

	<!-- 메인 carousel -->  
	<div>
		<img src="${pageContext.request.contextPath}/resources/images/bd.png" class="d-block w-100" alt=mainImage">
	</div>
	<div id="app" class="container-fluid mt-5" style="margin:0 auto; padding:5px;">
	<!-- 공지사항 -->
	<div class="row">
		<div class="col">
			<h2 class="text-center my-3" style="color:rgb(2,38,94);text-shadow:1px 1px 1px rgb(1,148,148);">공지사항</h2>
		    <table class="table table-hover text-center">
				<thead>
					<tr>
						<th style="color: #48a697;">번호</th>
			            <th style="color: #48a697;">제목</th>
			            <th style="color: #48a697;">날짜</th>
			            <th style="color: #48a697;">조회수</th>   
					</tr>
				</thead>
				<tbody>
					<tr v-for="(notice, index) in noticeList" :key="notice.num">
						<td>{{notice.num}}</td>
			      		<td>
			      			<a class="link-dark text-decoration-none fw-bold" 
			      			:href="base_url+'/notice/detail.do?num='+notice.num">
			      				{{notice.title}}
			      			</a>		      		
			      		</td>
			      		<td>{{notice.regdate}}</td>
			      		<td>{{notice.viewCount}}</td>
					</tr>	
		      </tbody>
		     </table> 
		</div>
		
		<!-- 자유게시판 -->
		<div class="col">
			<h2 class="text-center my-3" style="color:rgb(2,38,94);text-shadow:1px 1px 1px rgb(1,148,148);">자유게시판</h2>
			<table class="table table-hover text-center">
		      <thead>
		         <tr>
		            <th style="color: #48a697;">번호</th>
		            <th style="color: #48a697;">제목</th>
		            <th style="color: #48a697;">작성자</th>
		            <th style="color: #48a697;">날짜</th>
		            <th style="color: #48a697;">조회수</th>
		            <th style="color: #48a697;">
		            	<svg style="color:#dc3545;" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
							<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
						</svg>
		            </th>  
		         </tr>
		      </thead>
		      <tbody>
					<tr v-for="(cafe, index) in cafeList" :key="cafe.num">
						<td>{{cafe.num}}</td>
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
			           		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="listProfile bi bi-person-circle" viewBox="0 0 16 16">
								<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
								<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
							</svg>
							{{cafe.writer}}
						</td>        
			            <td>{{cafe.regdate}}</td>
						<td>{{cafe.viewCount}}</td>
            			<td>{{cafe.likeCount}}</td>			
					</tr>
		      </tbody>
		   </table>
		</div>
	</div>
	
	<div class="row pt-3">
		<h2 class="text-center my-3" style="color:rgb(2,38,94);text-shadow:1px 1px 1px rgb(1,148,148);">참고 영상</h2>
		<div class="col">
			<div class="card text-center">
                 <iframe height="235" src="https://www.youtube.com/embed/TdeBlsehb6g" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                 <div class="card-body">
                   <h5 class="card-title">스텝</h5>
                   <p class="card-text">배드민턴 스텝의 모든것</p>
                 </div>
           </div>	
           </div>		
		<div class="col">
			<div class="card text-center">
                 <iframe height="235" src="https://www.youtube.com/embed/gAl4cW4r3vw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                 <div class="card-body">
                   <h5 class="card-title">드롭샷</h5>
                   <p class="card-text">깎기드롭부터 백드롭까지</p>
                 </div>
            </div>
		</div>
		<div class="col">
			<div class="card text-center">
                 <iframe height="235" src="https://www.youtube.com/embed/oPgFINcuOVQ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                 <div class="card-body">
                   <h5 class="card-title">포핸드그립 백핸드그립 준비그립</h5>
                   <p class="card-text">필수로 알고 시작해야하는 3종 그립</p>
                 </div>
            </div>						
		</div>
		<div class="col">
			<div class="card text-center">
                 <iframe height="235" src="https://www.youtube.com/embed/2a2ESf7SN9g" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                 <div class="card-body">
                   <h5 class="card-title">배드민턴꿀팁</h5>
                   <p class="card-text">배드민턴 꿀팁 특별강습</p>
                 </div>
            </div>						
		</div>
	</div>
	
	<!-- gallery -->
	<div class="row pt-3 text-center vertical">
	<h2 class="text-center my-3" style="color:rgb(2,38,94);text-shadow:1px 1px 1px rgb(1,148,148);">갤러리</h2>
		<div class="col-lg-12 col-xs-12">
			<span class="col-lg-1" style="float:none; margin:0 auto;">		            
				<img class="p-2" src="${pageContext.request.contextPath}/resources/images/shuttlecock_main.png" width="50" height="50"/>
	        </span>
			<!-- Gallery --> 
			<span v-for="gallery in galleryList" :key="gallery.num" class="col-lg-2">
				<a class="text-decoration-none" :href="base_url+'/gallery/detail.do?num='+gallery.num">				
					<img :src="base_url+gallery.imagePath" 
						onerror="this.src='${pageContext.request.contextPath}/resources/images/frown-face.png'" 
						class="col-xs-12 col-sm-8 col-md-2 col-lg-2 rounded"/>
				</a>
			</span>
            <span class="col-lg-1">
           		<img class="p-2" src="${pageContext.request.contextPath}/resources/images/shuttlecock_main.png" width="50" height="50"/>
           	</span>		             
		</div>
	</div>
</div>
<!-- footer -->
<jsp:include page="../include/footer.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-latest.js"></script> 
<!-- The Modal -->
<div id="myModal" class="modal"> 
<!-- Modal content -->
	<div class="modal-content">
		<p style="text-align: center;">
			<span style="font-size: 14pt;">
				<b>
					<span style="color: green; font-size: 24pt;">*JOIN US~~*</span>
				</b>
			</span>
		</p>
		<a href="http://www.badmintonmart.com/shop/main/index.php"> 
			<img src="${pageContext.request.contextPath}/resources/images/notice.jpg" class="card-img-top" height=300px width=240px; />
		</a>
		<div style="cursor:pointer;background-color:black; color:white; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
			<span class="pop_bt" style="font-size: 12pt;" >
			5초후 자동으로 사라집니다^^
			</span>
		</div>
	</div> 
</div>
<!--End Modal--> 
<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script type="text/javascript">      
       jQuery(document).ready(function() {
               $('#myModal').show();
       });
       //팝업 Close 기능
       function close_pop(flag) {
            $('#myModal').hide();             
       };
       //5초후 자동으로 사라지기 
       setTimeout(function() { $('#myModal').hide();}, 5000)
       
	//Vue 관련 로직       
	//const base_url="http://localhost:8888/minton05";
       
	let app=new Vue({ 
		el:"#app",
		data:{
			base_url,
			noticeList:[],
			cafeList:[],
			galleryList:[],
		},
		methods:{
			
		},
		created(){
			let self=this;
			//ajax 요청으로 cafe 글 목록을 json으로 받아온다.
			ajaxPromise(base_url+"/ajax/cafe/listIndex.do","get")
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 cafe글 목록이 들어 있는 array
				//console.log(data);
				//받아온 데이터를 data의 모델에 넣어준다
				self.cafeList=data;
			});
			
			//ajax 요청으로 notice 글 목록을 json으로 받아온다.
			ajaxPromise(base_url+"/ajax/notice/listIndex.do","get")
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 notice글 목록이 들어 있는 array
				//console.log(data);
				//받아온 데이터를 data의 모델에 넣어준다
				self.noticeList=data;
			});
			
			//ajax 요청으로 gallery 글 목록을 json으로 받아온다.
			ajaxPromise(base_url+"/ajax/gallery/listIndex.do","get")
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 notice글 목록이 들어 있는 array
				//console.log(data);
				//받아온 데이터를 data의 모델에 넣어준다
				self.galleryList=data;
			});
			
			//popup을 띄울지 여부를 받아온다
			ajaxPromise(base_url+"/popup/isPopup.do","get")
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				//data는 {isPopup:false} 또는 없음
				//true이면 popup을 열도록 한다
				if(data.isPopup != false){
					window.open(base_url+"/popup/popup.do","창의제목","width=470,height=470,top=100,left=100");
				}
			});
		}
	});
       
       
</script>

</body>
</html>






