<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="main_nav">
	<ul>
		<li>
			<a href="${pageContext.request.contextPath}/tmenu/tmenuWriteForm.do">오늘의 메뉴 등록</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/tmenu/tmenuList.do">오늘의 메뉴 목록</a>
		</li>
		
		<c:if test="${!empty user_num && user_auth == 8}"><!-- 강사 -->
		<li>
			<a href="${pageContext.request.contextPath}/attend/list.do">출석확인</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/tmenu/tmenuWriteForm.do">오늘의 메뉴 등록</a>
		</li>
		</c:if>
		
		<c:if test="${!empty user_num && user_auth == 9}"><!-- 관리자 -->
		<li>
			<a href="${pageContext.request.contextPath}/attend/list.do">출석확인</a>
		</li>		
		<li>
			<a href="${pageContext.request.contextPath}/inbody/inbodyMain.do">인바디</a>
		</li>		
		</c:if>
		
		<c:if test="${!empty user_num && user_auth != 8 && user_auth != 9}"><!-- 회원 -->
		<li>
			<a href="${pageContext.request.contextPath}/inbody/inbodyMain.do">인바디 등록</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/history/historyList.do">PT신청</a>
		</li>
		</c:if>
		
		<c:if test="${!empty user_num}"><!-- 로그인 후 -->
		<li>
			<a href="${pageContext.request.contextPath}/member/myPage.do">MY페이지</a>
		</li>
		<li class="menu-logout">
			[<span>${user_id}</span>]
			<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
		</li>
		</c:if>
		
		<c:if test="${!empty user_num && !empty user_photo}"><!-- 로그인 후 사진 O -->
		<li	class="menu-profile">
			<img src="${pageContext.request.contextPath}/upload/${user_photo}" width="25" height="25" class="my-photo">
		</li>
		</c:if>
		
		<c:if test="${!empty user_num && empty user_photo}"><!-- 로그인 후 사진 X -->
		<li	class="menu-profile">
			<img src="${pageContext.request.contextPath}/images/face.png" width="25" height="25" class="my-photo">
		</li>
		</c:if>
		
		<c:if test="${empty user_num}"><!-- 로그인 전 -->
		<li>
			<a href="${pageContext.request.contextPath}/member/registerUserForm.do">회원가입</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/member/loginForm.do">로그인</a>
		</li>
		</c:if>
		
	</ul>
</div>
<!-- header 끝 -->








