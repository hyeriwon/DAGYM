<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>회원목록(포인트차감)</h2>
		<hr class="fixed-divider" size="1" width="100%" noshade="noshade">
		<c:if test="${count == 0}">
			<div class="result-display">
				표시할 회원정보가 없습니다.
			</div>
			<hr class="fixed-divider" size="1" width="100%" noshade="noshade">
		</c:if>
		<c:if test="${count > 0}">
		<table>
			<tr>
				<th>아이디</th>
			</tr>
			<c:forEach var="member" items="${list}">
			<tr>
				<td><a href="adminList.do?mem_num=${member.mem_num}">${member.mem_id}</a></td>
			</tr>
			</c:forEach>
		</table>
		<hr class="fixed-divider" size="1" width="%" noshade="noshade">
		</c:if>
	</div>
</div>
</body>
</html>
