<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주 묻는 질문</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</head>
<body>
<div class="container">
	<h3>자주 묻는 질문</h3>
	<div class="accordion" id="accordionExample">
		<div class="accordion-item">
			<h2 class="accordion-header" id="headingOne">
				<button class="accordion-button" type="button" data-bs-toggle="collapse"
					data-bs-target="#collapseOne">
					1. DAGYM 피트니스 위치는 어디인가요?
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
					2. 회원권 요금이 궁금합니다.
				</button>
			</h2>
			<div id="collapseTwo" class="accordion-collapse collapse" 
			   data-bs-parent="#accordionExample">
				<div class="accordion-body">
					다짐피트니스에서는 좀 더 자세한 회원권 안내를 위해서 상담 후 회원권을 등록해드리고 있습니다.<br>
					회원권 안내 페이지에서 이용 요금 확인 후 상담을 신청해주세요.<br>
					<input type="button" value="회원권안내페이지" onclick="location.href='${pageContext.request.contextPath}/payment/paymentInfo.do'">
				</div>
			</div>
		</div><!-- end of item -->
		<div class="accordion-item">
			<h2 class="accordion-header" id="headingThree">
				<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
					data-bs-target="#collapseThree">
					3. 운동기록, 식사기록 기능을 사용하고 싶습니다.
				</button>
			</h2>
			<div id="collapseThree" class="accordion-collapse collapse" 
			   data-bs-parent="#accordionExample">
				<div class="accordion-body">
					다짐피트니스는 회원제 서비스로 제공되고 있습니다. 운동기록, 식사기록을 사용하시려면 회원가입이 필요합니다.<br>
					회원가입을 하시면 운동기록, 식사기록 뿐만 아니라 인바디, 1:1문의, PT신청 등 다양한 서비스를 이용할 수 있습니다.
				</div>
			</div>
		</div><!-- end of item -->
		<div class="accordion-item">
			<h2 class="accordion-header" id="headingFour">
				<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
					data-bs-target="#collapseFour">
					4. 포인트 적립 기준이 궁금합니다.
				</button>
			</h2>
			<div id="collapseFour" class="accordion-collapse collapse" 
			   data-bs-parent="#accordionExample">
				<div class="accordion-body">
					출석체크, 회원권등록, PT후기 작성
				</div>
			</div>
		</div><!-- end of item -->
		<div class="accordion-item">
			<h2 class="accordion-header" id="headingFive">
				<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
					data-bs-target="#collapseFive">
					5. PT 신청을 하고 싶은데 어떻게 해야 하죠?
				</button>
			</h2>
			<div id="collapseFive" class="accordion-collapse collapse" 
			   data-bs-parent="#accordionExample">
				<div class="accordion-body">
					회원권을 먼저 결제하신 후 보유하고 계시는 회원권 수량에 한해 PT 신청을 할 수 있습니다.<br>
					수강신청방법<br>
					[CLASS] - [PT 신청] - 스케줄 확인 후 원하는 날짜 클릭 - 시간 및 트레이너 이름 입력 후 수강신청 버튼
				</div>
			</div>
		</div><!-- end of item -->
	</div>
</div>
</body>
</html>