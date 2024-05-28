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
<div class="content-main">
<div class="align-center">
<h2>${tmenu.tme_name}</h2>
</div>
<div style="overflow: auto;">
<div class="align-left" style="width:400px; float: left;">
<img  src="${pageContext.request.contextPath}/upload/${tmenu.tme_photo}" width="400px">
</div >
<div class="align-right" style="width:400px; float: right;">
<ul>
	<li>칼로리 : ${tmenu.tme_kcal}</li>
	<li>탄수화물 : ${tmenu.tme_crabs}</li>
	<li>단백질 : ${tmenu.tme_protein}</li>
	<li>지방: ${tmenu.tme_lipid}</li>
</ul>
</div>
</div>
<hr size="1" noshade="noshade" width="100%">
<p>
${tmenu.tme_content}


</p>

<hr size="1" noshade="noshade" width="100%">
<div class="align-right">
<div>
	 	<input type="button" value="수정" onclick="location.href='tmenuModifyForm.do?tme_num=${tmenu.tme_num}'">
	 	<input type="button" value="삭제" onclick="location.href='tmenuDelete.do?tme_num=${tmenu.tme_num}'">
	 	<input type="button" value="목록" onclick="location.href='tmenuList.do'">
	</div>
</div>
</div>
</div>

</body>
</html>