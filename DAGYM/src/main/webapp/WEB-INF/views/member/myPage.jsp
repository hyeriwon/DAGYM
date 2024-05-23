<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
</head>  
<body>
<div>
	<!-- 메인페이지 header -->	
	<div>
		<!-- 회원 상세페이지 header -->
		<div>
			<hr size="1" width="80%" noshade="noshade">
			<ul>
				<li>
					<label>아이디</label>${member.mem_id}
				</li>
				<li>
					<label>이름</label>${member.mem_name}
				</li>
				<li>
					<label>프로필</label>
					<c:if test="${empty member.mem_photo}">
						<img src="${pageContext.request.contextPath}/images/face.png"
							width="50" height="50">
					</c:if>
					<c:if test="${!empty member.mem_photo}">
						<img src="${pageContext.request.contextPath}/upload/${member.mem_photo}"
							width="50" height="50">
					</c:if>
				</li>
				<li>
					<label>전화번호</label>${member.mem_phone}
				</li>
				<li>
					<label>이메일</label>${member.mem_email}
				</li>
				<li>
					<label>성별</label>${member.mem_gender}
				</li>
				<li>
					<label>생일</label>${member.mem_birth}
				</li>
				<li>
					<label>우편번호</label>${member.mem_zipcode}
				</li>
				<li>
					<label>주소</label>${member.mem_address1} ${member.mem_address2}
				</li>
				<li>
					<label>가입일</label>${member.mem_reg_date}
				</li>
				<li>
					<label>수정일</label>${member.mem_modify_date}
				</li>
			</ul>
			<hr size="1" width="80%" noshade="noshade">
		</div>
		<input type="button" value="수정하기">
		<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">		
	</div>
</div>
</body>
</html>