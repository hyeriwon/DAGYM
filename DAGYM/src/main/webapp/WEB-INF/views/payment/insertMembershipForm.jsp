<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBERSHIP</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function() {
	$('#write_form').submit(function() {
        if($('#pay_fee').val().trim()==''){
        	alert('회원권 종류를 선택하세요');
        	$('#pay_fee').val('').focus();
        	return false;
        }
    });
    function updatePayment() {
        var membershipType = $('#pay_type').val();
        var payEnroll;
        var payFee;

        if (membershipType === "10회권") {
            payEnroll = 10;
            payFee = 600000;
        } else if (membershipType === "20회권") {
            payEnroll = 20;
            payFee = 1100000; 
        } else if (membershipType === "30회권") {
            payEnroll = 30;
            payFee = 1600000; 
        }

        $('#pay_enroll').val(payEnroll);
        $('#pay_fee').val(payFee);
    }

    $('#pay_type').change(function() {
        updatePayment();
    });

    // 폼 초기화 시 "10회권" 설정
    updatePayment();
});
</script>
</head>
<body>
<
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
                            <a href="#">Mypage</a>
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
                            <h2>회원권 등록</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<form id="write_form" action="insertMembership.do" method="post">
					<input type="hidden" name="mem_num" value="${mem_num}">
						<ul>
							<li>
								<label>회원명</label>${mem_name}
								<p>현재 보유한 회원권 : ${remain} 회</p>
							</li>
							<li>
								<label>회원권 종류</label>
								<select id="pay_type" name="pay_type">
										<option value="" selected disabled>--선택--</option>
										<option value="10회권">10회권</option>
										<option value="20회권">20회권</option>
										<option value="30회권">30회권</option>
								</select>
							</li>
							<li>
			            		<input type="hidden" name="pay_enroll" id="pay_enroll">
			       			</li>
							<li>
			                    <label>결제 금액</label>
			                    <input type="text" name="pay_fee" id="pay_fee" readonly>
			                </li>
						</ul>
						<div class="align-center">
							<input type="submit" value="등록">
							<input type="button" value="취소" onclick="location.href='paymentMemberList.do'">
						</div>
					</form>
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