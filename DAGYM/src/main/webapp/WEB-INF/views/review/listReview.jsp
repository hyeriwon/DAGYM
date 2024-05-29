<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강후기 목록</title>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>수강후기</h2>
		<form action="listReview.do" method="post">
			<
		</form>
		<c:if test="${count == 0}">
			<div class="result-display">
				표시할 게시물이 없습니다.
			</div>
		</c:if>
		<c:if test="${count > 0}">
			<table>
				<tr>
					<th>제목</th>
					<th>트레이너</th>
					<th>수업일시</th>
					<th>회원명</th>
					<th>별점</th>
					<th>등록일</th>
					<th>조회수</th>
				</tr>
				<c:forEach var="review" items="${list}">
					<tr>
						<td><a href="reviewDetail.do?rev_num=${review.rev_num}">${review.rev_title}</a></td>
						<td>${review.rev_tra_name}</td>
						<td>${review.rev_sch_date}</td>
						<td>${review.rev_mem_name}</td>
						<td>${review.rev_grade}</td>
						<td>${review.rev_reg_date}</td>
						<td>${review.rev_hit}</td>
					</tr>
				</c:forEach>
			</table>
			<div class="align-center">${page}</div>
		</c:if>
	</div>
</div>
</body>
</html>