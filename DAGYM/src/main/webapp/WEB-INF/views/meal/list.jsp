<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="content-main">
    <div id="calendar"></div>
    <input type="button" id="registerMealButton" value="음식기록 등록">
    </div>
</div>
</body>
</html>
