<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴하기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript">
window.onload = function(){
	const deleteForm = document.getElementById('delete_form');
	deleteForm.onsubmit = function(){
		const items = document.querySelectorAll('.input-check');	
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim()==''){
				const label = document.querySelector('label[for="'+items[i].id+'"]');
				alert(label.textContent+' 항목 필수 입력!');
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
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>회원 탈퇴하기</h2>
		<form action="deleteUser.do" method="post" id="delete_form">
			<ul>
				<li>
					<label for="id">아이디</label>
					<input type="text" autocomplete="off" maxlength="12" id="id" name="mem_id" class="input-check">
				</li>
				<li>
					<label for="pw">비밀번호</label>
					<input type="password" autocomplete="off" maxlength="12" id="pw" name="mem_pw" class="input-check">
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="탈퇴하기">
				<input type="button" value="취소" onclick="location.href='myPage.do'">
			</div>
		</form>			
	</div>
</div>
</body>
</html>