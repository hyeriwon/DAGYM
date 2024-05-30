<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- header 시작 -->
<div id="memberdetail_nav">
	<ul>
		<li>
			<a href="${pageContext.request.contextPath}/member/myPage.do">회원상세</a>
		</li>
		<li>
			<a href="${pageContext.request.contextPath}/meal/mealDetail.do">식사기록</a>
		</li>
	</ul>
</div>