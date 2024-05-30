<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인바디 기록</title>
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/style.css" type="text/css">
    <link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
	<form id = "search_form" action = "inbodyList.do" method="get">
		<ul class="search">
		<li>
		<select name = "keyfield">
			<option value="1"<c:if test="${param.keyfield ==1}">selected</c:if>>날짜</option>
		</select>
		</li>
		<li>
			<input type="search" size = "16" name="keyword" id = "keyword" value="${param.keyword}">
		</li>
		<li>
			<input type="submit" value="검색">
		</li>
		</ul>
		</form>
		<div class= "list-space align-right">
		<c:if test="${user_auth!=9}">
		<input type="button" value="등록" onclick="location.href='inbodyMain.do'">
		</c:if>
		<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
		<c:if test="${count==0 }">
			<div class="result-display">
				표시할 게시물이 없습니다.
			</div>
		</c:if>
		<c:if test="${count>0 }">
			<table>
				<tr>
					<th>측정번호</th>
					<th>측정일자</th>
					<th>키</th>
					<th>몸무게</th>
					<th>골격근량</th>
					<th>삭제</th>
				</tr>
				<c:forEach var = "inbody" items="${list}">
					<tr>
					<td><a href="inbodyDetail.do?inb_num=${inbody.inb_num}&client_num=${param.client_num}">${inbody.inb_num}</a></td>
					<td>${inbody.inb_date}</td>
					<td>${inbody.inb_hei }</td>
					<td>${inbody.inb_wei}</td>
					<td>${inbody.inb_mus}</td>
					<td>
					<div class="align-center">
					<input type="button" value="삭제" onclick="location.href='deleteInbody.do?inb_num=${inbody.inb_num}'">
					</div>
					</td>
					</tr>
				</c:forEach>
			
			</table>
			<div class="align-center">${page}</div>
		</c:if>
		
	
	
	
	</div>
</div>

</body>	
</html>