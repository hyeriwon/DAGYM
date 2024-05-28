<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의내역</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
	<%-- 자신이 쓴 글에 대해서만 문의내역이 들어가도록 미설정, 설정필요 --%>
		<h2>문의내역</h2>
		<div class="list-space align-right">
			<input type="button" value="글쓰기" onclick="location.href='wirteFrom.do'">
			<input type="button" value="목록" onclick="location.href='questionList.do'">
		</div>
	</div>
</div>
</body>
</html>