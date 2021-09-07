<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/shuttlecock_main.png" type="image/x-icon" />

<style>
   	h1 {
		color: rgb(2,38,94); 
		text-shadow:1px 1px 1px rgb(1,148,148); 
		margin: 0; 
		padding: 10px; 
		font-weight: bold; 
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
<jsp:include page="../../include/navbar.jsp">
	<jsp:param value="faq" name="thisPage"/>
</jsp:include>
	<div class="container my-4" id="ccontainer">
		<h1 class="fw-bold my-4 text-center">자주 하는 질문</h1>
		<div class="accordion" id="accordion">
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingOne">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
						High clear가 무엇인가요?
					</button>
				</h2>
				<div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordion">
					<div class="accordion-body">
			        	배드민턴에서 가장 기초가 되는 기술이자 가장 중요한 기술입니다.<br>
			        	하이클리어는 상대방 코트 엔드라인 근처까지 솟구쳐 날아가다 엔드라인 끝에서 뚝 떨어져야 합니다.<br><br />
			        	★구사 방법 <br />
			        	<img src="${pageContext.request.contextPath}/resources/images/high-clear.jpg"/><br />
			        	라켓을 든 팔과 다른 한 쪽 팔로 삼각형 모양을 그린 뒤, 그 상태에서 그대로 오른쪽 발을 왼쪽 발 뒤로 빼고, 상체도 같이 오른쪽으로 돌린다. <br />
			        	왼쪽 팔은 셔틀콕을 가리키거나, 가슴을 펴주기 위해 왼쪽 위에 두고,오른쪽 팔은 뒤로 당겨준다. 이 때 체중을 오른쪽 다리에 실어준 후, 다시 몸을 왼쪽으로 회전시키면서 라켓을 등 뒤로 떨어트렸다가, 오른발에 실었던 체중을 앞으로 이동시키면서 스윙한다. 
					</div>
			    </div>
			</div>	
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingTwo">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
						하이클리어 동호회에 가입하고 싶습니다. 어떻게 하면 되나요? 
					</button>
				</h2>
				<div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordion">
					<div class="accordion-body">
			        	우선 상단의 회원가입 버튼을 클릭하시어 하이클리어 회원이 되어 주세요!
			        	<br />
			        	정기 모임에 참가하시려면 자유게시판 글 목록의 최상단에 있는 모임 공지사항을 읽으신 후, 자유게시판에 참가 의사를 알려주시면 동호회장이 취합하여 별도 연락을 드립니다. 
			        	<br />
			        	모임 장소, 시간, 인원수는 매 회마다 다르기 때문에, 공지사항을 꼭 참고해 주세요. 		        	
					</div>
			    </div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingThree">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
						배드민턴 공식 경기 일정을 알고 싶습니다. 
					</button>
		    </h2>
				<div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordion">
					<div class="accordion-body">
			        	경기 일정은<br />
			        	대한배드민턴 협회 홈페이지 <a href="http://www.koreabadminton.org/">http://www.koreabadminton.org/</a><br />
			        	전국배드민턴대회 홈페이지 <a href="http://www.badmintongame.co.kr/">http://www.badmintongame.co.kr/</a><br />
			        	네이버, 다음 포탈 국내 배드민턴란 등에서도 확인이 가능합니다.<br /><br />
			        	또한, 저희 동호회 공지사항에도 일정을 따로 게시해 놓고 있습니다. 	
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingFour">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
						모임에 처음 참석합니다. 무슨 장비를 챙겨가야 할까요?
					</button>
		    </h2>
				<div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#accordion">
					<div class="accordion-body">
			        	아주아주 간단합니다! <br />
			        	배드민턴 라켓 1자루, 배드민턴화, 수건, 편한 복장, 배드민턴 가방만 있으시면 됩니다. 물과 셔틀콕은 저희 동호회에서 지원해 드립니다. <br />        	
			       </div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingFive">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
						초보자 장비는 어떤 걸 구매해야 하나요?  
					</button>
		    </h2>
				<div id="collapseFive" class="accordion-collapse collapse" aria-labelledby="headingFive" data-bs-parent="#accordion">
					<div class="accordion-body">
			        	★ 라켓<br />
			        	- 추천 라켓무게 : 4u (80~85g사이) 여성분의 경우 5U같은 초경량 라켓도 괜찮습니다.<br />
			        	- 추천 샤프트 탄성 : 미디움(남여), Flex 부드러움(여성추천)<br />
						- 라켓 밸런스 : 올라운드형 라켓으로 헤드와 그립쪽 균형이 같은게 초보자때는 좋습니다.<br />
						- 거트 텐션 : 남자 (25~26), 여성 (24~25)<br />
						- 가격 : 5만원~10만원 사이를 추천합니다! 보통 라켓은 2자루 이상 구비하시는게 좋습니다. 초보 레슨땐 1자루만 있어도 거의 끊어질 염려는 없습니다. 주로 스매싱을 할때 많이 끊어지는 편이니 남자분들은 라켓 한자루를 추후 더 준비하시는걸 추천합니다. <br />
			        	브랜드는 굉장히 다양하니 원하는 것으로 고르시면 됩니다. <br /> 
			        	- tip : <br />
			        	라켓을 인터넷으로 구매 시 라켓 그립이 없는채로 오기 때문에 가까운 샵에 가셔서 기본 그립을 하나 구매하셔서 그립을 갈아달라고 하면 그립 구매비용만 받고 갈아줍니다. 
			        	1,000원~2,000원 정도면 그립을 교체하실 수 있으니 인터넷으로 라켓 구매시엔 꼭 가까운 샵에서 그립을 교체해 주시기 바랍니다!
			        	<br /><br />
			        	★ 배드민턴화<br />
			        	배드민턴화는 되도록 경제적 여유가 되신다면 10만원 이상의 신발을 구매하시는걸 추천합니다. 5~6만원짜리에서 뭐 3~4만원짜리 신발도 많지만 쿠셔닝이 사실상 좋지 않아서 무릎이나 발목에 무리가 조금 갈 수 있습니다. 
			        	10만원 이상이 부담되신다면 6만원~10만원 사이 배드민턴화도 많으니 꼭 참고하시기 바랍니다. 
					</div>
				</div>
			</div>	
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingSix">
					<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
						동호회비가 따로 있나요?
					</button>
		    </h2>
				<div id="collapseSix" class="accordion-collapse collapse" aria-labelledby="headingSix" data-bs-parent="#accordion">
					<div class="accordion-body">
			        	당월 모임 횟수, 인원에 따라 다릅니다. <br />
			        	상기 내용이 정해지면 참여 회원분들께 별도로 공지하여 드리고 있으며, 회비에는 코트 대여료  외의 기타 비용이 포함됩니다.  <br />
			        	<br />
			        	저희 동호회는 서울특별시 배드민턴협회의 지원을 받고 있어, 타 동호회보다 회비가 저렴합니다 :D 
					</div>
				</div>
			</div>	
		</div> <%-- end of accordin --%>
		<div class="row pt-3">
		<h1 class="fw-bold my-4 text-center">참고 영상</h1>
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
	</div> <%-- end of container --%>
<jsp:include page="../../include/footer.jsp"></jsp:include>
</body>
</html>



