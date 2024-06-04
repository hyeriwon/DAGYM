<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PT후기 신고내역</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<!-- 메뉴를 관리자 header의 myPage에 추가 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<div class="content-main">
		<h2>PT후기 신고내역</h2>
		<form id="search_form" action="adminReportList.do" method="get">
			<ul class="search">
				<li>
					<select name="keyfield">
						<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>원본 제목</option>
						<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>신고 사유</option>
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
		<c:if test="${count == 0}">
			<div class="result-display">
				표시할 신고 내역이 없습니다.
			</div>
		</c:if>
		<c:if test="${count > 0}">
			<table>
				<tr>
					<th>원본 글번호</th>
					<th>원본 제목</th>
					<th>신고한 회원ID</th>
					<th>신고사유</th>
					<th>신고처리</th>
				</tr>
				<c:forEach var="report" items="${list}">
				<tr>
					<td>${report.rev_num}</td>
					<td>
						<a href="detailReview.do?rev_num=${report.rev_num}">
						${report.rev_title}</a>
					</td>
					<td>${report.mem_id}</td>
					<td title="${report.report_content}">
						${fn:substring(report.report_content,0,10)}...
					</td>
					<td>
					<c:if test="${report.report_del == 0}">
						<input type="button" value="신고" id="UpdateRev">
					</c:if>
					<c:if test="${report.report_del == 1}">
						<input type="button" value="완료" disabled>
						<input type="button" value="취소" id="recoverRev">
					</c:if>
					</td>
				</tr>
				</c:forEach>
			</table> 
		</c:if>
	</div>
</div>
</body>
</html>