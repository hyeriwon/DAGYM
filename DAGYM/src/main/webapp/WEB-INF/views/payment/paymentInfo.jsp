<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBERSHIP</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/breadcrumb-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb-text">
                        <h2>Membership</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <span>Membership</span>
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
                    		<span>Membership</span>
                            <h2>회원권 안내</h2>
                    	</div>
                 </div>
             </div>
          </div>
    </div>
	<br><br>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-4 col-md-8">
                    <div class="ps-item">
                        <h3>10회권</h3>
                        <div class="pi-price">
                            <h2>&#8361;600,000</h2>
                            <span>회당 60,000</span>
                        </div>
                        <ul>
                            <li>쾌적한 운동시설</li>
                            <li>최고의 운동기구</li>
                            <li>친절하고 전문적인 트레이너</li>
                            <li>퍼스널 트레이닝</li>
                            <li>다이어트/체력관리/실버트레이닝</li>
                            <li>유효기한 : 결제 후 5개월</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-8">
                    <div class="ps-item">
                        <h3>20회권</h3>
                        <div class="pi-price">
                            <h2>&#8361;1,100,000</h2>
                            <span>회당 55,000</span>
                        </div>
                        <ul>
                            <li>쾌적한 운동시설</li>
                            <li>최고의 운동기구</li>
                            <li>친절하고 전문적인 트레이너</li>
                            <li>퍼스널 트레이닝</li>
                            <li>다이어트/체력관리/실버트레이닝</li>
                            <li>유효기한 : 결제 후 10개월</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-8">
                    <div class="ps-item">
                        <h3>30회권</h3>
                        <div class="pi-price">
                            <h2>&#8361;1,500,000</h2>
                            <span>회당 50,000</span>
                        </div>
                        <ul>
                        	<li>쾌적한 운동시설</li>
                            <li>최고의 운동기구</li>
                            <li>친절하고 전문적인 트레이너</li>
                            <li>퍼스널 트레이닝</li>
                            <li>다이어트/체력관리/실버트레이닝</li>
                            <li>유효기한 : 결제 후 15개월</li>
                        </ul>
                    </div>
                </div>
                <!-- content 시작 -->
				<div class="align-center">
					<br>
					<input type="button" value="상담신청" onclick="location.href='${pageContext.request.contextPath}/payment/paymentCounselingForm.do'">
					<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
				</div>
				<!-- content 끝 -->
            </div>
        </div>
    </section>
    <!-- Pricing Section End -->
	  
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<jsp:include page="/WEB-INF/views/common/js_plugins.jsp"/>

</body>
</html>