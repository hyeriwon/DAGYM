<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ReviewReport</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript">
window.onload = function(){
	let report = document.getElementById('reportForm');
	report.onsubmit = function(){
		const content = document.getElementById('content');
		if(content.value.trim()==''){
			alert('신고 사유 필수 입력!');
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
		<h2>PT후기 신고하기</h2>
		<form id="reportForm" action="reportReview.do" method="post">
			<input type="hidden" name="rev_num" value="rev_num">
			<input type="hidden" name="mem_num" value="mem_num">
			<h3>신고 사유를 작성해주세요.</h3>
			<div class="align-center">
				<ul>
					<li>
						<textarea rows="5" cols="50" id="content"></textarea>
					</li>
				</ul>		
				<input type="submit" value="신고">
				<input type="button" value="취소" onclick="location.href='detailReview.do?rev_num=${rev_num}">
			</div>
		</form>
	</div>
</div>
</body>
</html>