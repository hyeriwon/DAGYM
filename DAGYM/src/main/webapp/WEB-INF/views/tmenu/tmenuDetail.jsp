<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 상세정보</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
<h2>상세정보보기</h2>
<ul>
	<li>메뉴번호 : ${tmenu.tme_num}</li>
	<li>메뉴이름 : ${tmenu.tme_name}</li>
	<li>칼로리 : ${tmenu.tme_kcal}</li>
	<li>탄수화물 : ${tmenu.tme_crabs}</li>
	<li>단백질 : ${tmenu.tme_protein}</li>
	<li>지방: ${tmenu.tme_lipid}</li>
	<li>식사분류 : ${tmenu.tme_type}</li>
	
</ul>
<hr size="1" noshade="noshade" width="100%">
<p>
${tmenu.tme_content}


</p>
<img src="${pageContext.request.contextPath}/upload/${tmenu.tme_photo}" width="400px">
<hr size="1" noshade="noshade" width="100%">
<div class="align-right">
	 	<input type="button" value="수정" onclick="location.href='tmenuModifyForm.do?tme_num=${tmenu.tme_num}'">
	 	<input type="button" value="삭제" onclick="location.href='tmenuDeleteForm.do?tme_num=${tmenu.tme_num}'">
	 	<input type="button" value="목록" onclick="location.href='tmenuList.do'">
	</div>
</div>

</body>
</html>