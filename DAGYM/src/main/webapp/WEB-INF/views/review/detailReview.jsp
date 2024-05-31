<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PT 수강후기 상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<div>
			<h2>${review.rev_title}</h2>
			<ul>
				<li>
					<c:if test="${empty member.mem_photo}">
						<img src="${pageContext.request.contextPath}/images/face.png"
							width="20" height="20" class="my-photo">
					</c:if>
					<c:if test="${!empty member.mem_photo}">
						<img src="${pageContext.request.contextPath}/upload/${member.mem_photo}"
							width="20" height="20" class="my-photo">
					</c:if>
					<c:if test="${mem_num != member.mem_num}">
						${fn:substring(member.mem_name, 0, 1)}**
					</c:if>
					<c:if test="${mem_num == member.mem_num}">
						${member.mem_name}
					</c:if>
				</li>
				<li>
					<label>진행 날짜</label> ${history.sch_date}시
					<label>트레이너</label> ${trainer.mem_name}
				</li>
				<li>
					<label>별점</label>
					<c:forEach var="i" begin="1" end="5">
						<c:if test="${i <= review.rev_grade}">
							<span style="color:#ff5500;">★</span>
						</c:if>
						<c:if test="${i > review.rev_grade}">
							<span style="color: #ddd;">★</span>
						</c:if>
					</c:forEach>
				</li>
				<li>
					<c:if test="${!empty review.rev_filename1}">
						<img src="${pageContext.request.contextPath}/upload/${review.rev_filename1}">
					</c:if>
					<c:if test="${!empty review.rev_filename2}">
						<img src="${pageContext.request.contextPath}/upload/${review.rev_filename2}">
					</c:if>
				</li>
				<li>
					${review.rev_content}
				</li>	
				<li>
					<label>조회수</label> ${review.rev_hit}
					<label>좋아요!</label> ${review.rev_hit}
				</li>
				<li class="align-right">
					<label>작성일</label> ${review.rev_reg_date}
					<c:if test="${!empty review.rev_modify_date}">
						<label>수정일</label> ${review.rev_modify_date}
					</c:if>	
				</li>	
			</ul>
			<hr size="1" noshade="noshade" width="80%">
			<div class="align-center">
				<c:if test="${member.mem_num == mem_num}">
					<input type="button" value="수정" onclick="location.href='updateReviewForm.do?rev_num=${review.rev_num}'">
					<input type="button" value="삭제" id="delReview">
					<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
					<script type="text/javascript">
						$(function{
							$('#delReview').click(function(){
								
							});
						});
					</script>
				</c:if>
				<input type="button" value="목록" onclick="location.href='listReview.do'">
			</div>
		</div>
	</div>
</div>
</body>
</html>