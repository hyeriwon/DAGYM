<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${meal_date}일의 기록</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
</head>
<body>
<div class="page-main">

<div class="result-display2">

			<table>
			<caption>${meal_date}일의 칼로리</caption>
				<tr>
					<th>식사분류</th>
					<th>메뉴이름</th>
					<th>칼로리</th>
				</tr>
				<c:forEach var = "meal" items="${meal}">
					<tr>
					<c:choose>
						<c:when test="${meal.meal_time == 0}">
						<td>아침</td>
						</c:when>
						<c:when test="${meal.meal_time == 1}">
						<td>점심</td>
						</c:when>
						<c:when test="${meal.meal_time == 2}">
						<td>저녁</td>
						</c:when>
						<c:otherwise>
						<td>간식</td>
						</c:otherwise>
					</c:choose>
					<td>${meal.tme_name}</td>
					<td>${meal.tme_kcal}Kcal</td>
					</tr>
				</c:forEach>
				<tr>
				<td colspan="2" class="align-right">총칼로리</td>
				<td class="align-center">${totalKcal}Kcal</td>
				</tr>
				
			</table>
</div>
			<div class="align-center">
			<input type="button" value="확인" onclick="location.href='${pageContext.request.contextPath}/meal/mealDetail.do?client_num=${param.client_num}'">
			</div>
</div>
</body>
</html>