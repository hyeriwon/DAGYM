<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBERSHIP</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
    $('.cancel-btn').on('click', function() {
        var pay_num = $(this).data('paynum');
        var mem_num = $(this).data('memnum'); // mem_num 데이터를 가져옴
        var choice = confirm('회원권을 취소하시겠습니까?');
        if(choice){
        	$.ajax({
            type: 'POST',
            url:'updatePayment.do',
            data: {
                pay_num: pay_num,
                mem_num: mem_num // mem_num도 데이터에 추가
            },
            dataType: 'json',
            success: function(param) {
                if(param.result === 'success') {
                    alert('회원권 취소가 완료되었습니다.');
                    location.reload();
                } else if(param.result === 'wrongAccess') {
                    alert('잘못된 접근입니다.');
                }else{
                	alert('회원권 취소 오류 발생')
                }
            },
            error: function() {
                alert('네트워크 오류 발생');
            }
        });
      }
    });
});

</script>
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
                            <h2>회원권 내역</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<input type="hidden" name="mem_num" value="${mem_num}">
					<h4>[${mem_name}]님</h4>
					<br>
					<p>
						보유한 회원권 : <span style="color:red;">${remain}</span>회
						
					<c:if test="${count == 0}">
						<div class="result-display">
							표시할 회원권 결제내역이 없습니다.
						</div>
					</c:if>	
					<c:if test="${count > 0}">
					<div class="align-right">
						<!-- 관리자가 아닌 경우에만 수정 버튼 -->
						<c:if test="${member.mem_auth!=9}">
							<input type="button" value="회원권등록" onclick="location.href='insertMembershipForm.do?mem_num=${mem_num}'">
						</c:if>
						<input type="button" value="목록" onclick="location.href='paymentMemberList.do'">
					</div>
					<br>
					<table>
						<thead>
							<tr>
								<th>결제번호</th>
								<th>수강료</th>
								<th>등록횟수</th>
								<th>결제일</th>
								<th>만료일</th>
								<th>결제상태</th>
								<th>취소</th>
							</tr>
						</thead>
						<c:forEach var="payment" items="${list}">
							<tr>
								<td>${payment.pay_num}</td>
								<td><fmt:formatNumber value="${payment.pay_fee}"/></td>
								<td>
								<c:if test="${payment.pay_status == 1 || payment.pay_status == 2}">
									0
								</c:if>
								<c:if test="${payment.pay_status == 0}">
									${payment.pay_enroll}
								</c:if>
								</td>
								<td>${payment.pay_reg_date}</td>
								<td>
								<c:if test="${payment.pay_status == 1}">
								 	결제취소
								</c:if>
								<c:if test="${payment.pay_status == 0 || payment.pay_status == 2}">
									${payment.pay_exp}
								</c:if>
								</td>
								<td>
								<c:if test="${payment.pay_status == 1}">
									결제 취소 완료
								</c:if>
								<c:if test="${payment.pay_status == 0}">
									결제 완료
								</c:if>
								<c:if test="${payment.pay_status == 2}">
									만료됨
								</c:if>
								</td>
								<td>
									<c:if test="${payment.pay_status == 0}">
									<input type="button" class="cancel-btn" value="취소" data-paynum="${payment.pay_num}" data-memnum="${mem_num}">
								</c:if>
								</td>
							</tr>
						</c:forEach>
						</table>
						<br>
						<div class="align-center">
							<div class="blog-pagination">
								${page}
							</div>
						</div>
					</c:if>
					<br>
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