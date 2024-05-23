<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>회원정보 수정</h2>
		<hr size="1" width="80%" noshade="noshade">
		<form action="modifyUser.do" method="post" enctype="multipart/form-data">
			<ul>
				<li>
					<label>이름</label>
					<input type="text" value="${member.mem_name}">
				</li>
				<li>
					<label>프로필 사진</label>
					<input type="file" value="${member.mem_name}">
				</li>
				<li>
					<label>현재 비밀번호</label>
					<input type="password">
				</li>
				<li>
					<label>새 비밀번호</label>
					<input type="password">
				</li>
				<li>
					<label>새 비밀번호 확인</label>
					<input type="password">
				</li>
				<li>
					<label>이메일</label>
					<input type="email" value="${member.mem_email}">
				</li>
				<li>
					<label>성별</label>
					
				</li>
				<li>
					<label>생년월일</label>
					<input type="date" value="${member.mem_birth}">
				</li>
				<li>
					<label>우편번호</label>
					<input type="text" value="${member.mem_zipcode}">
				</li>
				<li>
					<label>주소</label>
					<input type="text" value="${member.mem_address1}">
				</li>
				<li>
					<label>상세 주소</label>
					<input type="text" value="${member.mem_address2}">
				</li>
			</ul>
		</form>
		<hr size="1" width="80%" noshade="noshade">
	</div>
</div>
</body>
</html>