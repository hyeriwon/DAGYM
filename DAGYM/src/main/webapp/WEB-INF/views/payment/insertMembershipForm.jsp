<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원권 등록(관리자)</title>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>회원권 등록(관리자)</h2>
		<form id="write_form" action="insertMembership.do" method="post">
			<ul>
				<li>
					<label>회원명</label>
					<select>
					<%-- --%>
					</select>
				</li>
			</ul>
		</form>
	</div>
</div>
</body>
</html>