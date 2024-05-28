<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원권 상담신청</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('write_form');
	//이벤트 연결
	myForm.onsubmit=function(){
		const title = document.getElementById('qab_title');
		if(title.value.trim()==''){
			alert('제목을 입력하세요');
			title.value = '';
			title.focus();
			return false;
		}
		const content = document.getElementById('qab_content');
		if(content.value.trim()==''){
			alert('내용을 입력하세요');
			content.value = '';
			content.focus();
			return false;
		}
	};
};
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<div class="content-main">
		<h2>회원권 상담 신청</h2>
		<form id="write_form" action="paymentCounseling.do" method="post">
			<ul>
				<li>
					<label for="qab_title">제목</label>
					<input type="text" name="qab_title" id="qab_title" maxlength="50">
				</li>
				<li>
					<label for="qab_type">문의종류</label>
					<span>회원권 상담 신청</span>
					<input type="hidden" name="qab_type" id="qab_type" value="4">
				</li>
				<li>
					<label for="qab_content">내용</label>
					<textarea rows="5" cols="40" name="qab_content" id="qab_content"></textarea>
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="등록">
				<input type="button" value="취소" onclick="location.href='paymentInfo.do'">
			</div>
		</form>
	</div>
</div>
</body>
</html>