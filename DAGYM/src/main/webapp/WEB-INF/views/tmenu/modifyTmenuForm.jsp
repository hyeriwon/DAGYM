<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음식등록</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('modify_form');
	myForm.onsubmit=function(){
		const title = document.getElementById('title');
		if(title.value.trim()==''){
			alert('제목을 입력하세요');
			title.value = '';
			title.focus();
			return false;
		}
		const content = document.getElementById('menu_content');
		if(content.value.trim()==''){
			alert('내용을 입력하세요');
			content.value = '';
			content.focus();
			return false;
		}
	}
}
</script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<div class="content-main">
			<h2>오늘의 메뉴 수정</h2>
			<form id="modify_form" action="tmenuModify.do" method="post"  enctype="multipart/form-data">
				<input type="hidden" name="menu_num" id="menu_num"  value="${tmenu.tme_num}">
				<ul>
					<li>
					<label for="menu_name">메뉴 이름</label>
					<input type="text" name="menu_name" id="menu_name" value="${tmenu.tme_name}">
					</li>
					<li>
					<label for="filename">메뉴 사진</label>
					<input type="file" name="filename" id="filename" accept="image/gif,image/png,image/jpeg">
					<div id="file_detail">
					<img src="${pageContext.request.contextPath}/upload/${tmenu.tme_photo}" width="400">
					</div>
					</li>
					<li>
					<label for="menu_kcal">칼로리</label>
					<input type="number" name="menu_kcal" id="menu_kcal" value="${tmenu.tme_kcal}">
					</li>
					<li>
					<label for="menu_crabs">탄수화물</label>
					<input type="number" name="menu_crabs" id="menu_crabs" value="${tmenu.tme_crabs}">
					</li>
					<li>
					<label for="menu_protein">단백질</label>
					<input type="number" name="menu_protein" id="menu_protein" value="${tmenu.tme_protein}">
					</li>
					<li>
					<label for="menu_lipid">지방</label>
					<input type="number" name="menu_lipid" id="menu_lipid" value="${tmenu.tme_lipid}">
					</li>
					<li>식사분류 
					<input type="radio" name="tme_type" value="0" id="tme_type0"<c:if test="${tmenu.tme_type == 0}">checked</c:if>>아침 
					<input type="radio" name="tme_type" value="1" id="tme_type1"<c:if test="${tmenu.tme_type == 1}">checked</c:if>>점심 
					<input type="radio" name="tme_type" value="2" id="tme_type2"<c:if test="${tmenu.tme_type == 2}">checked</c:if>>저녁 
					<input type="radio" name="tme_type" value="3" id="tme_type3"<c:if test="${tmenu.tme_type == 3}">checked</c:if>>간식
					<input type="radio" name="tme_type" value="4" id="tme_type4"<c:if test="${tmenu.tme_type == 4}">checked</c:if>>검색용메뉴
					</li>
					<li>
					<label for="menu_content">메뉴 설명</label>
					<textarea rows="5" cols="40" name="menu_content" id="menu_content">${tmenu.tme_content}</textarea>
					</li>
				</ul>
				<div class="align-center">
					<input type="submit" value="등록"> <input type="button" value="목록" onclick="location.href='tmenuList.do'">
				</div>
			</form>
				
		</div>
	</div>
</body>
</html>
