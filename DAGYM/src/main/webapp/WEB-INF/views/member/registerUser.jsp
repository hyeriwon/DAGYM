<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 완료</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>회원가입 완료</h2>
	<div class="result-display">
		<div class="align-center">
		회원가입을 완료했습니다<p>
		<button onclick="location.href='${pageContext.request.contextPath}/main/main.do'">홈으로</button>
		</div>
		
	</div>
</div>
</body>
</html>