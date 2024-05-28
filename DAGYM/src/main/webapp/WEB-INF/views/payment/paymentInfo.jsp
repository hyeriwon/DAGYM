<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원권 안내</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>회원권 안내</h2>
		<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/membership.jsp">
			<p>
			<input type="button" value="상담신청" onclick="location.href='${pageContext.request.contextPath}/payment/paymentCounselingForm.do'">
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</div>
</div>
</body>
</html>