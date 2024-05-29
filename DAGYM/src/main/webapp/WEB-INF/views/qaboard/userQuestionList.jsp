<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의내역</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp">
	<div class="content-main">
		<h2>문의내역</h2>
		<form id="search_form" action="userQuestionList.do" method="get">
			<ul class="search">
				<li>
					<select name="keyfield">
					<%-- 제목, 글, 제목+글(?) 검색 처리 진행 --%>
					</select>
				</li>
				<li>
					<input type="search" size="16" name="keyword" id="keyword" value="<%-- 작성 --%>">
				</li>
				<li>
					<input type="submit" value="검색">
				</li>
			</ul>
		</form>
		<div class="list-space">
			<div class="align-left">
				<select>
				<%-- type에 따른 분류 처리 진행 --%>
				</select>
			</div>
			<div class="align-right">
				<input type="button" value="글쓰기" onclick="location.href='userWriteForm.do'">
				<input type="button" value="목록" onclick="location.href='userQuestionList.do'">
			</div>
		</div>
		<c:if test="${count == 0}">
			<div class="result-display">
				표시할 문의내역이 없습니다.
			</div>
		</c:if>
		<c:if test="${count > 0}">
			<table>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성일</th>
					<th>답변여부</th>
				</tr>
				<%-- <c:forEach var="board" item="${list}"> --%>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<%-- </c:forEach> --%>
			</table>
			<div class="align-center">${page}</div>
		</c:if>
	</div>
</div>
</body>
</html>