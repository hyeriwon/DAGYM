<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${qaboard.qab_title}</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/WHR.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#answer_form').submit(function(){
		if($('#answer_content').val().trim() == ''){
			alert('답변 내용을 입력하세요');
			$('#answer_content').val('').focus();
			return false;
		}
		alert('정상적으로 답변이 등록되었습니다');
	});
});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>${qaboard.qab_title}</h2>${qaboard.qab_type}
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
			작성자 ${qaboard.mem_id}&nbsp;|
			<c:if test="${!empty qaboard.qab_modify_date}">
				최근 수정일 &nbsp;${qaboard.qab_modify_date}&nbsp;|
			</c:if>
			작성일 &nbsp;${qaboard.qab_reg_date}
		</div>
		<br>
		<%-- 문의미답변 --%>
		<c:if test="${user_auth >= 8 && answerBoard==null}">
			<div id="answer-div">
			<hr size="1" noshade="noshade" width="80%">
				<span class="answer-title">답변 등록</span>
				<form id="answer_form" action="adminWriteAnswer.do" method="post">
					<input type="hidden" name="qab_num" value="${qaboard.qab_num}" id="qab_num"><!-- 문의글 번호 -->
					<input type="hidden" name="qab_type" value="${qaboard.qab_type}" id="qab_type"><!-- 문의글 번호 -->
						<textarea rows="10" cols="50" name="answer_content" id="answer_content"></textarea>
					<input type="submit" value="등록">				
				</form>
			<hr size="1" noshade="noshade" width="80%">
			</div>
		</c:if>
		<%-- 문의답변 --%>
		<c:if test="${user_auth >= 8 && answerBoard!=null}">
			<div id="answer-div">
				<hr size="1" noshade="noshade" width="80%">
				<p>${answerBoard.qab_content}</p><br>
				<hr size="1" noshade="noshade" width="80%">
				<div class="align-right">
					${answerBoard.qab_reg_date}
				</div>
			</div>
		</c:if>
	</div>
</div>
</body>
</html>