<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class= "content-main">
		</div>
			<table>
				<tr>
					<th>식사분류</th>
					<th>메뉴이름</th>
					<th>칼로리</th>
				</tr>
				<c:forEach var = "meal" items="${meal}">
					<tr>
					<c:choose>
						<c:when test="${meal.meal_time ==0}">
						<td>아침</td>
						</c:when>
						<c:when test="${meal.meal_time ==1}">
						<td>점심</td>
						</c:when>
						<c:when test="${meal.meal_time ==2}">
						<td>저녁</td>
						</c:when>
						<c:otherwise>
						<td>간식</td>
						</c:otherwise>
					</c:choose>
					<td>${meal.tme_name}</td>
					<td>${meal.tme_kcal}</td>
					</tr>
				</c:forEach>
				<tr>
				<td>총칼로리</td>
				<td>${totalKcal}</td>
				</tr>
			</table>
			<input type="button" value="확인" onclick="location.href='${pageContext.request.contextPath}/meal/mealDetail.do'">
</body>
</html>