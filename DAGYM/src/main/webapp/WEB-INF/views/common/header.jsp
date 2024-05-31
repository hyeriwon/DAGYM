<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- header 시작 -->
<div id="main_logo">
	<h1 class="align-center">
		<a href="${pageContext.request.contextPath}/main/main.do">DAGYM</a>
	</h1>
</div>
<div id="main_nav">
	<ul>
		<li>
			<a href="${pageContext.request.contextPath}/">센터소개</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/review/listReview.do">센터소개(수강후기)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/payment/paymentInfo.do">회원권안내</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/">고객센터</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/nboard/nboardList.do">고객센터(공지사항)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/qaboard/userQuestionList.do">고객센터(1:1문의)</a>
		</li>

		<c:if test="${!empty user_num && user_auth != 8 && user_auth != 9}"><!-- 회원 -->
		<li>
			<a href="${pageContext.request.contextPath}/">클래스</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/">클래스(강사프로필)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/history/list.do">클래스(PT신청)</a>
		</li>

		<li>
			<a href="${pageContext.request.contextPath}/">MY페이지</a>
		</li>		
		<li>
			<a href="${pageContext.request.contextPath}/member/myPage.do">MY페이지(회원상세)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/attend/list.do">MY페이지(출석체크)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/point/list.do">MY페이지(포인트)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/">MY페이지(운동기록)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/meal/mealDetail.do">MY페이지(식사기록)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/inbody/inbodyList.do">MY페이지(인바디)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/">MY페이지(수강내역)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/qaboard/userQuestionList.do">MY페이지(문의내역)</a>
		</li>
		</c:if>
		
		<c:if test="${!empty user_num && user_auth == 8}"><!-- 강사 -->
		<li>
			<a href="${pageContext.request.contextPath}/">회원목록</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/member/adminMemberList.do">회원목록(회원상세)</a>
		</li>	
		<li>
			<a href="${pageContext.request.contextPath}/attend/adminMemberList.do">회원목록(출석체크)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/point/adminMemberList.do">회원목록(포인트)</a>
		</li>
		
		<li>
			<a href="${pageContext.request.contextPath}/">MY페이지</a>
		</li>	
		<li>
			<a href="${pageContext.request.contextPath}/member/myPage.do">MY페이지(강사상세)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/schedule/list.do">MY페이지(스케줄)</a>
		</li>
		</c:if>
		
		<c:if test="${!empty user_num && user_auth == 9}"><!-- 관리자 -->	
		<li>
			<a href="${pageContext.request.contextPath}/">회원목록</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/member/adminMemberList.do">회원목록(회원상세)</a>
		</li>	
		<li>
			<a href="${pageContext.request.contextPath}/attend/adminMemberList.do">회원목록(출석체크)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/point/adminMemberList.do">회원목록(포인트)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/qaboard/adminAnswerList.do">회원목록(문의내역)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/">강사목록</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/member/adminTrainerList.do">강사목록(강사상세)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/">강사목록(스케줄)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/">MY페이지</a>
		</li>	
		<li>
			<a href="${pageContext.request.contextPath}/payment/paymentMemberList.do">MY페이지(회원권등록)</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/tmenu/tmenuList.do">MY페이지(메뉴등록)</a>
		</li>		
		</c:if>
		
		<c:if test="${!empty user_num}"><!-- 로그인 후 -->
<%-- 		<li>
			<a href="${pageContext.request.contextPath}/member/myPage.do">MY페이지</a>
		</li> --%>
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
<%-- 		<li>
			<a href="${pageContext.request.contextPath}/member/registerUserForm.do">회원가입</a>
		</li> --%>
		<li>
			<a href="${pageContext.request.contextPath}/member/myPage.do">MY페이지</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/member/loginForm.do">로그인</a>
		</li>
		</c:if>
		
	</ul>
</div>
<!-- header 끝 -->
