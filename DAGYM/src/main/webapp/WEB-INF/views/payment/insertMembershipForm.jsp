<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원권 등록(관리자)</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function() {
    $('#pay_type').change(function() {
        updatePayment();
    });

    function updatePayment() {
        var membershipType = $('#pay_type').val();
        var payEnroll;
        var payFee;

        if (membershipType === "10회권") {
            payEnroll = 10;
            payFee = 700000;
        } else if (membershipType === "20회권") {
            payEnroll = 20;
            payFee = 1400000; 
        } else if (membershipType === "30회권") {
            payEnroll = 30;
            payFee = 2100000; 
        }

        $('#pay_enroll').val(payEnroll);
        $('#pay_fee').val(addCommasToNumber(payFee));
    }
    function addCommasToNumber(number) {
        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>회원권 등록(관리자)</h2>
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
							<option value="선택">--선택--</option>
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
	</div>
</div>
</body>
</html>