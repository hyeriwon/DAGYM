<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page = "/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>공지게시판</h2>
		<div class="list-space align-right">
		
			<c:if test="${user_auth == 9}">
			<input type="button" value="글쓰기" onclick="location.href='nboardWriteForm.do'">
			</c:if>
			<input type="button" value="목록" onclick="location.href='nboardList.do'">
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</div>
</div>
</body>
</html>