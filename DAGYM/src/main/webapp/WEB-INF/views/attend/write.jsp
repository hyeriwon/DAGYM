<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출석작성 완료</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" type="text/css">
</head>
<body>

	<div class="page-main">
		<h1>출석작성 완료</h1>
		<div class="result-display">
			<div class="align-center">
				출석을 완료했습니다.<p>
				<button onclick="location.href='list.do'">목록</button>
			</div>
		</div>
	</div>
	
</body>
</html>