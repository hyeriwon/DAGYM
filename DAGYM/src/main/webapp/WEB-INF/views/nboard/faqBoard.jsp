<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SHG.css" type="text/css">
<style type="text/css">
/* 전체적인 스타일 */
body {
    color: white;
 	font-family: "NanumSquareNeo", sans-serif;
}
/* 링크의 밑줄 제거 */
a {
  text-decoration: none;
}
input[type="button"].payinfo {
	color:#b5b5b5;
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/breadcrumb-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb-text">
                        <h2>FAQ</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">C/S</a>
                            <span>FAQ</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

	 <section class="team-section team-page spad">
	      <div class="container">
	          <div class="row">
	          	 <div class="col-lg-12">
	          		<div class="team-title">
	                		<div class="section-title">
	                    		<span>FAQ</span>
	                            <h2>자주하는질문</h2>
	                    	</div>
	                 </div>
	             </div>
	          </div>
	          	<div class="row">
					<div class="col-lg-12">    
						<div class="chart-table2">
						
						<!-- content 시작 -->
						<div class="accordion" id="accordionExample">
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingOne">
									<button class="accordion-button" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseOne">
										1. [센터소개] DAGYM 피트니스 위치는 어디인가요?
									</button>
								</h2>
								<div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
									<div class="accordion-body">
										서울특별시 강남구 테헤란로 132(역삼동) 8층입니다.
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingTwo">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseTwo">
										2. [회원권] 회원권 요금이 궁금합니다.
									</button>
								</h2>
								<div id="collapseTwo" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										다짐피트니스에서는 좀 더 자세한 회원권 안내를 위해서 상담 후 회원권을 등록해드리고 있습니다.<br>
										회원권 안내 페이지에서 이용 요금 확인 후 상담을 신청해주세요.<br>
										<input type="button" class="payinfo" value="회원권안내페이지" onclick="location.href='${pageContext.request.contextPath}/payment/paymentInfo.do'">
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingThree">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseThree">
										3. [회원권] 회원권 환불이 가능한가요?
									</button>
								</h2>
								<div id="collapseThree" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										회원권은 사용하지 않았을 경우 7일 이내 환불이 가능합니다.<br>
										또한 회원권당 만료일이 다르므로 자세한 내용은 회원권 안내 페이지를 참고해주세요.<br>
										<input type="button" class="payinfo" value="회원권안내페이지" onclick="location.href='${pageContext.request.contextPath}/payment/paymentInfo.do'">
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingFour">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseFour">
										4. [PT신청] PT를 신청하고 싶은데 어떻게 해야 하나요?
									</button>
								</h2>
								<div id="collapseFour" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										회원권을 먼저 결제하신 후 보유하고 계시는 회원권 수량에 한해 PT 신청을 할 수 있습니다.<br>
										* 수강신청방법<br>
										[CLASS] - [PT 신청] - 스케줄 확인 후 원하는 날짜 클릭 - 시간 및 트레이너 이름 입력 후 수강신청 버튼을 클릭해주시면 됩니다.
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingFive">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseFive">
										5. [PT신청] PT 신청 시 운동부위에 따라 PT가 진행되나요?
									</button>
								</h2>
								<div id="collapseFive" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										운동부위는 신청하신 회원님의 메인 운동으로 진행되는 부분이며 회원님의 당일 컨디션, 운동 루틴 그리고 헬스장 당일 혼잡도에 따라 변경될 수도 있습니다.
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingSix">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseSix">
										6. [PT신청] 스케줄에 표시된 색상에 의미가 궁금합니다.
									</button>
								</h2>
								<div id="collapseSix" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										1. 신청 화면 <br>
										 - 파란색 : 신청 가능 스케줄 <br>
										 - 빨간색 : 완료되서 신청 불가능 스케줄 <br>
										2. My List <br>
										 - 파란색 : 본인이 신청하여 PT 예정된 스케줄 <br>
										 - 연두색 : PT 진행 완료되어 후기를 작성할 수 있는 상태
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingSeven">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseSeven">
										7. [PT신청] PT 신청 후 취소 가능한가요?
									</button>
								</h2>
								<div id="collapseSeven" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										네, 물론입니다!<br>
										스케줄 My List에서 파란색 스케줄 이벤트를 클릭하여 PT 취소가 가능합니다.
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingEight">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseEight">
										8. [포인트] 포인트 적립 기준이 궁금합니다.
									</button>
								</h2>
								<div id="collapseEight" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										출석 체크시 10p, 후기 작성시 100p, 
										회원권 등록시 300p ~ 900p 범위 내 차등 지급됩니다.
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingNine">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseNine">
										9. [포인트] 포인트는 어디에 사용할 수 있나요?
									</button>
								</h2>
								<div id="collapseNine" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										포인트는 오프라인(센터)에서 직원 확인 후 사용 가능합니다.
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingTen">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseTen">
										10. [포인트] 포인트는 어떻게 사용할 수 있나요?
									</button>
								</h2>
								<div id="collapseTen" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										센터 내 장비를 대여하거나 건강 식품, 위생 용품 등을 구매할 때 사용할 수 있습니다.
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingEleven">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseEleven">
										11. [PT후기] PT후기 작성은 어디에서 할 수 있나요?
									</button>
								</h2>
								<div id="collapseEleven" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										메인 페이지 상단 우측 - 로그인아이콘 - 수강내역 중 완료한 PT에 한해 후기를 작성하실 수 있습니다.
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingTwelve">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseTwelve">
										12. [PT후기] 후기를 신고하면 어떻게 되나요?
									</button>
								</h2>
								<div id="collapseTwelve" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										신고를 받아 3회 이상 신고 처리가 된 글은 블라인드되며, 글을 쓴 회원은 1주일간 정지됩니다.
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingThirteen">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseThirteen">
										13. [PT후기] 작성한 PT후기가 보이지 않아요.
									</button>
								</h2>
								<div id="collapseThirteen" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										작성자 본인이 직접 삭제하거나 3회 이상 신고 처리가 된 후기는 볼 수 없습니다.
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingFourteen">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseFourteen">
										14. [식사기록]  사용방법이 궁금합니다.
									</button>
								</h2>
								<div id="collapseFourteen" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										등록 : 등록 버튼을 누르고 원하는 날짜를 클릭하게 되면 작성 할 수 있습니다. (단, 오늘 이전의 날짜만 등록이 가능합니다.)<br>
										조회:  목록에서 해당 날짜를 클릭하게 되면 해당 날짜의 식사 목록 및 칼로리 섭취를 볼 수 있습니다.
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingFifteen">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseFifteen">
										15. [인바디]  인바디 사진은 반드시 저장해야하나요?
									</button>
								</h2>
								<div id="collapseFifteen" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										아닙니다.<br>
										인바디 사진은 회원의 선택사항에 따라 회원님의 인바디 사진을 저장할 수 있고, 추후에 따로 수정을 통해 사진을 등록할 수 있습니다.
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingSixteen">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseSixteen">
										16. [운동기록] 운동기록 기능을 사용하고 싶습니다.
									</button>
								</h2>
								<div id="collapseSixteen" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										다짐피트니스는 회원제 서비스로 제공되고 있습니다. 운동기록을 사용하시려면 회원가입이 필요합니다.<br>
										회원가입을 하시면 운동기록 뿐만 아니라 인바디, 1:1문의, PT신청 등 다양한 서비스를 이용할 수 있습니다.
									</div>
								</div>
							</div><!-- end of item -->
							<div class="accordion-item">
								<h2 class="accordion-header" id="headingSeventeen">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
										data-bs-target="#collapseSeventeen">
										17. [1:1문의] 문의는 어디에서 할 수 있나요?
									</button>
								</h2>
								<div id="collapseSeventeen" class="accordion-collapse collapse" 
								   data-bs-parent="#accordionExample">
									<div class="accordion-body">
										문의는 로그인한 회원에 한해서만 작성이 가능하며, 메인 페이지 상단 우측 - 로그인아이콘 - 문의내역을 통해서 문의사항을 작성할 수 있습니다.
									</div>
								</div>
							</div><!-- end of item -->
						</div>
						<br>
						<div class="align-right">
							다른 질문이 있으면 02-3482-4632로 전화주시거나 1:1문의를 이용해주세요<br>
						</div>
						<div class="align-right">	
							<input type="button" value="1:1문의" onclick="location.href='${pageContext.request.contextPath}/qaboard/userQuestionList.do'">
						</div>
						<!-- content 끝 -->
						
						</div>
					</div>
				</div>
		      </div>
		  </section>
	  
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<jsp:include page="/WEB-INF/views/common/js_plugins.jsp"/>

</body>
</html>