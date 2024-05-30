<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인바디 등록</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
window.onload = function(){
	const myForm = document.getElementById('write_form');
	myForm.onsubmit = function(){
		const items = document.querySelectorAll('input[type="number"]');
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim()== ''){
			const label = document.querySelector('label[for="'+items[i].id+'"]');
			alert(label.textContent + '항목은 필수 입력');
			items[i].value = '';
			items[i].focus();
			return false;
			}
			
		}
	};
};
</script>
</head>
<body>
<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<div class="content-main">
		<form id="write_form" action="inbodyWrite.do" method="post" enctype= "multipart/form-data">
		<input type="hidden" id="inb_date" name="inb_date" value="${param.inb_date}">
		<h2>인바디 등록</h2>
		<ul>
			<li>
				<label for="inb_hei">키</label>
				<input type="number" id="inb_hei" name="inb_hei">
			</li>
			<li>
				<label for="inb_wei">몸무게</label>
				<input type="number" id="inb_wei" name="inb_wei">
			</li>
			<li>
				<label for="inb_mus">골격근량</label>
				<input type="number" id="inb_mus" name="inb_mus">
			</li>
			<li>
				<label for="inb_photo">인바디 사진</label>
				<input type="file" id="inb_photo" name="inb_photo">
			</li>
			<div class="align-center">
			<input type="submit" value="등록">
			<input type="button" value="취소" onclick="${pageContext.request.contextPath}/inbody/inbodyList.do">
			</div>
		</ul>
			</form>
		</div>
</div>
</body>
</html>