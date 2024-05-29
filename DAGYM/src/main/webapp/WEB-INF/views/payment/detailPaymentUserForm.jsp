<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원권 정보(관리자 전용)</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
	
		<h2>[${mem_name}]님의 회원권 정보(관리자 전용)</h2>
		
			<input type="hidden" name="mem_num" value="${mem_num}">
			<ul>
				<li>
					<label>보유한 회원권 : </label>${remain}
				</li>
				<li>
					<P>
					<label>결제내역</label>
				</li>
			</ul>
			<c:if test="${count == 0}">
				<div class="result-display">
					표시할 회원권 결제내역이 없습니다.
				</div>
			</c:if>	
			<c:if test="${count > 0}">
				<table>
					<tr>
						<th>결제번호</th>
						<th>수강료</th>
						<th>등록횟수</th>
						<th>결제일</th>
					</tr>
				<c:forEach var="payment" items="${list}">
					<tr>
						<td>${payment.pay_num}</td>
						<td>${payment.pay_fee}</td>
						<td>${payment.pay_enroll}</td>
						<td>${payment.pay_reg_date}</td>
					</tr>
				</c:forEach>
				</table>
				<div class="align-center">${page}</div>
			</c:if>
			<div class="align-center">
				<!-- 관리자가 아닌 경우에만 수정 버튼 -->
				<c:if test="${member.mem_auth!=9}">
					<input type="button" value="회원권등록" onclick="location.href='insertMembershipForm.do?mem_num=${mem_num}'">
				</c:if>
				<input type="button" value="목록" onclick="location.href='paymentMemberList.do'">
			</div>
		
	</div>
</div>
</body>
</html>