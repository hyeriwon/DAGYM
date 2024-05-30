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
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>문의내역</h2>
		<%-- 검색 --%>
		<form id="search_form" action="userQuestionList.do" method="get">
			<ul class="search">
				<li>
					<select name="keyfield">
						<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>제목</option>
						<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>내용</option>
						<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>제목+내용</option>
					</select>
				</li>
				<li>
					<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}">
				</li>
				<li>
					<input type="submit" value="검색">
				</li>
			</ul>
		</form>
		<%-- 목록 --%>
		<div class="list-span">
			<div class="align-left">
				<select>
					<option></option>
				</select>
			</div>
			<div class="align-right">
				<input type="button" value="글쓰기" onclick="location.href='userWriteForm.do'">
				<input type="button" value="목록" onclick="location.href='userQuestionList.do'">
			</div>
		</div>
		<hr class="fixed-divider" size="1" width="100%" noshade="noshade">
		<c:if test="${count == 0}">
			<div class="result-display">
				표시할 문의내역이 없습니다.
			</div>
			<hr class="fixed-divider" size="1" width="100%" noshade="noshade">
		</c:if>
		<c:if test="${count > 0}">
			<table>
				<tr>
					<th>카테고리</th>
					<th>제목</th>
					<th>작성일</th>
					<th>답변여부</th>
				</tr>
				<c:forEach var="qaboard" items="${list}">
				<tr>
					<td>
						<c:if test="${qaboard.qab_type==1}">PT</c:if>
						<c:if test="${qaboard.qab_type==2}">다이어트</c:if>
						<c:if test="${qaboard.qab_type==3}">상담</c:if>
						<c:if test="${qaboard.qab_type==4}">회원권 상담</c:if>
						<c:if test="${qaboard.qab_type==5}">기타</c:if>
					</td>
					<td><a href="userDetail.do?qab_num=${qaboard.qab_num}">${qaboard.qab_title}</a></td>
					<td>${qaboard.qab_reg_date}</td>
					<td>
						<c:if test="${qaboard.qab_ref == 0}">미답변</c:if>
						<c:if test="${qaboard.qab_ref == 1}">답변완료</c:if>
					</td>
				</tr>
				</c:forEach>
			</table>
			<hr class="fixed-divider" size="1" width="%" noshade="noshade">
			<div class="align-center">${page}</div>
		</c:if>
	</div>
</div>
</body>
</html>