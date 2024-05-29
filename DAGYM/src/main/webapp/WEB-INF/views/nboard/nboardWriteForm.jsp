<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지게시판 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('write_form');
	//이벤트 연결
	myForm.onsubmit=function(){
		const nbo_title = document.getElementById('nbo_title');
		if(nbo_title.value.trim()==''){
			alert('제목을 입력하세요');
			nbo_title.value = '';
			nbo_title.focus();
			return false;
		}
		const content = document.getElementById('nbo_content');
		if(nbo_content.value.trim()==''){
			alert('내용을 입력하세요');
			nbo_content.value = '';
			nbo_content.focus();
			return false;
		}
	};
};
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>글쓰기</h2>
		<form id="write_form" action="nboardWrite.do" method="post" enctype="multipart/form-data">
			<ul>
				<li>
					<label for="nbo_title">제목</label>
					<input type="text" name="nbo_title" id="nbo_title" maxlength="50">
				</li>
				<li>
					<label for="nbo_content">내용</label>
					<textarea rows="5" cols="40" name="nbo_content" id="nbo_content"></textarea>
				</li>
				<li>
					<label for="nbo_filename">이미지</label>
					<input type="file" name="nbo_filename" id="nbo_filename" accept="image/gif,image/png,image/jpeg">
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="등록">
				<input type="button" value="목록" onclick="location.href='nboardList.do'">
			</div>
		</form>
	</div>
</div>
</body>
</html>