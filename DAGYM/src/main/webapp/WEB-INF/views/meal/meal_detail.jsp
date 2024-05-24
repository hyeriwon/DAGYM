<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식사 목록</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript">
window.onload=function(){
	const myform= document.getElementById('search_form');
	
	myform.onsubmit=function(){
		const keyword = document.getElementById('keyword');
		if(keyword.value.trim()==''){
			alert('검색어를 입력하세요');
			keyword.value='';
			keyword.focus();
			return false;
		}
	}
}
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>식사 목록</h2>
		<form id = "search_form" action = "list.do" method="get">
		<ul class="search">
		<li>
		<select name = "keyfield">
			<option value="1"<c:if test="${param.keyfield ==1}">selected</c:if>>음식이름</option>
			<option value="2"<c:if test="${param.keyfield ==2}">selected</c:if>>식사일자</option>
		</select>
		</li>
		<li>
			<input type="search" size = "16" name="keyword" id = "keyword" value="${param.keyword}">
		</li>
		<li>
			<input type="submit" value="검색">
		</li>
		</ul>
			
		</form>
		
		
		<div class= "list-space align-right">
			<input type="button" value="글쓰기" onclick="location.href='writeForm.do'"
			<c:if test="${empty user_num}"> disabled="disabled"</c:if>
			>	
		<input type="button" value="목록" onclick="location.href='list.do'">
		<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
		<c:if test="${count==0 }">
			<div class="result-display">
				표시할 게시물이 없습니다.
			</div>
		</c:if>
		<c:if test="${count>0 }">
			<table>
				<tr>
					<th>식사일자</th>
					<th>메뉴이름</th>
					<th>칼로리</th>
				</tr>
				<c:forEach var = "meal" items="${meal}">
					<tr>
					<td><a href="detail.do?meal_num=${meal.meal_num}">${meal.meal_date}</a></td>
					<td>${meal.tme_name }</td>
					<td>${meal.tme_kcal }</td>
					</tr>
				</c:forEach>
			
			</table>
			<div class="align-center">${page}</div>
		</c:if>
	</div>
</div>

</body>
</html>