<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식사 기록</title>
</head>
<body>
	<table>
		<tr>
			<th>식사번호</th>
			<th>식사 타입</th>
			<th>식사 일자</th>
			<th>회원명</th>
			<th>칼로리</th>
			<th>메뉴이름</th>
			<th>메뉴번호</th>
		</tr>
		<c:forEach var="meal" items= "${meal}" >
			<tr>
				<td>${meal.meal_num}</td>
				<td>${meal.meal_time}</td>
				<td>${meal.meal_date}</td>
				<td>${meal.mem_num}</td>
				<td>${meal.tme_kcal}</td>
				<td>${meal.tme_name}</td>
				<td>${meal.tme_num}</td>
			</tr>
		</c:forEach>

	</table>

</body>
</html>