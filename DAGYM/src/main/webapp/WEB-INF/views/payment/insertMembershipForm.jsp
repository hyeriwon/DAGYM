<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원권 등록(관리자)</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>회원권 등록(관리자)</h2>
		<form id="write_form" action="insertMembership.do" method="post">
			<ul>
				<li>
					<label>회원명</label>${mem_name}
					
					<p>
					[]님 현재 보유한 회원권 : 
				</li>
					
					
				<li>
					<label>회원권 종류</label>
					<select>
						<option>10회권</option>
						<option>20회권</option>
						<option>30회권</option>
					</select>
				</li>
				<li>
					<label>결제 금액</label>
					<input>
				</li>
			</ul>
			<input type="submit" value="등록">
			<input type="button" value="취소" onclick="">
		</form>
	</div>
</div>
</body>
</html>