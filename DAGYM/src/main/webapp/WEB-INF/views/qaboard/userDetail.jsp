<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${qaboard.qab_title}</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#delete').click(function(){
		if(confirm("정말 삭제하시겠습니까?")){
			location.href='userDelete.do?qab_num='+"${qaboard.qab_num}";
		}
	});
});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>${qaboard.qab_title}</h2>
		<div class="align-right">
			<input type="button" value="수정" onclick="location.href='userUpdateForm.do?qab_num=${qaboard.qab_num}'">
			<input type="button" value="삭제" id="delete">
			<input type="button" value="목록" onclick="location.href='userQuestionList.do'">
		</div>
		<hr size="1" noshade="noshade" width="100%">
		<%-- 내용 --%>
		<p>${qaboard.qab_content}</p><br>
		<%-- 첨부파일이 있을 경우 --%>	
		<c:if test="${!empty qaboard.qab_filename}">
		<div class="align-left">
			<img src="${pageContext.request.contextPath}/upload/${qaboard.qab_filename}" class="detail-img">
		</div>
		</c:if>
		<hr size="1" noshade="noshade" width="100%">
		<%-- 등록일, 수정일 --%>
		<div class="align-right">
			<c:if test="${!empty qaboard.qab_modify_date}">
				최근 수정일 : ${qaboard.qab_modify_date}
			</c:if>
			작성일 : ${qaboard.qab_reg_date}
		</div>
		<%-- 문의답변 --%>
	</div>
</div>
</body>
</html>