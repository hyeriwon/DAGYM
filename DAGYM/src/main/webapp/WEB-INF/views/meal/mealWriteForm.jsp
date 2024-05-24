<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
	const queryString = window.location.search;
	const urlParams = new URLSearchParams(queryString);
	const mealDate = urlParams.get('meal_date');
	if (mealDate) {
		document.getElementById('meal_date').value = mealDate;
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
		<input type="hidden"  id="meal_date" name="meal_date" value="meal_date" >
		<ul>
			<li>
                    <label for="menu_name">메뉴 검색</label>
                    <input type="number" name="tme_num" id="tme_num">
                    <input type="button"  value= "검색" onclick="location.href='searchMenuAndSetTmeNum.do'">
            </li>
			<li>식사분류
			<input type="radio" name="meal_time" value="0" id="meal_time0">아침
			<input type="radio" name="meal_time" value="1" id="meal_time1">점심
			<input type="radio" name="meal_time" value="2" id="meal_time2">저녁
			<input type="radio" name="meal_time" value="3" id="meal_time3">간식
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