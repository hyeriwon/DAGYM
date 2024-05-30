<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${inb_date}일의 기록</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
</head>
<body>
<div class="page-main">

<div class="result-display2">
				<table>
			<caption>${inb_date}일의 인바디 기록</caption>
				<tr>
					<th>항목</th>
					<th>기록</th>
				</tr>
				<tr>
					<td>키</td>
					<td>${inbody.inb_hei}</td>
				</tr>
				<tr>
					<td>몸무게</td>
					<td>${inbody.inb_wei}</td>
				</tr>
				<tr>
					<td>골격근량</td>
					<td>${inbody.inb_mus}</td>
				</tr>
				<tr>
					<td>bmi지수</td>
					<td>${inb_bmi}</td>
				</tr>
				<tr>
				<td>상태</td>
				<c:choose>
				<c:when test="${inb_bmi < 18}">
						<td>저체중</td>
						</c:when>
						<c:when test="${inb_bmi < 23}">
						<td>정상</td>
						</c:when>
						<c:when test="${inb_bmi < 25}">
						<td>과체중</td>
						</c:when>
						<c:otherwise>
						<td>비만</td>
						</c:otherwise>
				</c:choose>
				</tr>
			</table>
</div>
			<div class="align-center">
			<img src="${pageContext.request.contextPath}/upload/${inbody.inb_photo}">
			</div>
			<div class="align-center">
			<input type="button" value="확인" onclick="location.href='${pageContext.request.contextPath}/inbody/inbodyList.do?client_num=${client_num}'">
			</div>
</div>
</body>
</html>