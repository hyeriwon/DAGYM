<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>문의 글쓰기</h2>
		<form id="write_form" action="userWrite.do" method = "post" enctype="multipart/form-data">
			<ul>
				<li>
					<select name="qab_type" id="qab_type">
						<option value="1">PT</option>
						<option value="2">다이어트</option>
						<option value="3">상담</option>
						<option value="4">회원권 상담</option>
						<option value="5">기타</option>
					</select>
				</li>
				<li>
					<label for="qab_title">제목</label>
					<input type="text" name="qab_title" id="qab_title" maxlength="50">
				</li>
				<li>
					<label for="qab_content">내용</label>
					<textarea rows="10" cols="50" name="qab_content" id="qab_content"></textarea>
				</li>
				<li>
					<label for="qab_filename">이미지</label>
					<input type="file" name="qab_filename" id="qab_filename" accept="image/gif,image/png,image/jpeng">
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="등록">
				<input type="submit" value="목록" onclick="location.href='userQuestionList.do'">
			</div>
		</form>
	</div>
</div>
</body>
</html>