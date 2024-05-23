<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음식등록</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('write_form');
	myForm.onsubmit=function(){
		const title = document.getElementById('title');
		if(title.value.trim()==''){
			alert('제목을 입력하세요');
			title.value = '';
			title.focus();
			return false;
		}
		const content = document.getElementById('content');
		if(content.value.trim()==''){
			alert('내용을 입력하세요');
			content.value = '';
			content.focus();
			return false;
		}
	}
};

</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>음식등록</h2>
		<form id="write_form" action = "mealWrite.do" method="post">
		<ul>
			<li>
			<label for="meal_date">식사일</label>
			<input type="date" name="meal_date" id= "meal_date" >
			</li>
			<li>
			<label for="tme_num">메뉴</label>
			<input type="number" name="tme_num" id="tme_num">
			</li>
			<li>식사분류
			<input type="radio" name="meal_time" value="0">아침
			<input type="radio" name="meal_time" value="1">점심
			<input type="radio" name="meal_time" value="2">저녁
			<input type="radio" name="meal_time" value="3">간식
			</li>
			
		</ul>
		<div class="align-center">
			<input type="submit" value="등록	">
			<input type="button" value="목록" onclick="location.href='list.do'">
			
		</div>
		</form>
	</div>
</div>


</body>
</html>