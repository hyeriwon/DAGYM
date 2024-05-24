<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출석작성</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>

	<div class="page-main">
		<h2>출석작성</h2>
		<form id="write_form" action="write.do" method="post">
			<ul>
				<li>
					<label for="mem_num">회원번호</label>
					<input type="text" name="mem_num" id="mem_num" size="10" maxlength="50">
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="등록">
				<input type="button" value="목록" onclick="location.href='list.do'">
			</div>
		</form>
	</div>

</body>
</html>