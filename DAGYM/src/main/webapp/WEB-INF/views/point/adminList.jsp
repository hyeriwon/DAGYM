<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<style>
    .point-in {
        color: blue;
    }
    .point-out {
        color: red;
    }
</style>
</head>
<body>

	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="content-main">
			<h2>포인트</h2>
			<form id="search_form" action="list.do" method="get">
<%-- 				<ul class="search">
					<li>
						<select name="keyfield">
							<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
							<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>작성자</option>
							<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>내용</option>
						</select>
					</li>
					<li>
						<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}">
					</li>
					<li>
						<input type="submit" value="검색">
					</li>
				</ul> --%>
			</form>
			<c:if test="${count == 0}">
			<div class="result-display">
				표시할 게시물이 없습니다.
			</div>
			</c:if>
			<c:if test="${count > 0}">
			<h3>전체 누적 : ${totalPointsIn}p</h3>
			<h3>사용 가능 : <span class="point-in">${totalPointsInOut}p</span></h3>
			<input type="button" value="포인트 사용" onclick="location.href='outForm.do?mem_num=${mem_num}'">
			<table>
				<tr>
					<th>날짜</th>
					<th>포인트 종류</th>
					<th>포인트</th>
				</tr>
				<c:set var="previousDate" value=""/>
				<c:forEach var="point" items="${list}">
				<tr>
					<!-- 적립일자, 사용일자 -> 일자 -->
					<!-- 같은 날짜는 생략 -->
					<!-- yyyy-mm-dd -> mm.dd -->
                    <td>
                        <c:choose>
                            <c:when test="${point.poi_in_date != null && not point.poi_in_date.toString().equals(previousDate)}">
                                <fmt:formatDate value="${point.poi_in_date}" pattern="MM.dd"/>
                                <c:set var="previousDate" value="${point.poi_in_date.toString()}"/>
                            </c:when>
                            <c:when test="${point.poi_out_date != null && not point.poi_out_date.toString().equals(previousDate)}">
                                <fmt:formatDate value="${point.poi_out_date}" pattern="MM.dd"/>
                                <c:set var="previousDate" value="${point.poi_out_date.toString()}"/>
                            </c:when>
                            <c:otherwise>
                                <!-- 빈 칸으로 둡니다 -->
                            </c:otherwise>
                        </c:choose>
                    </td>
					<td>${point.poi_type}</td>
					<!-- 적립포인트, 사용포인트 -> 포인트 -->
					<!-- + 파란색, - 빨간색  -->
					<td>
						<c:choose>
							<c:when test="${point.poi_in > 0}">
								<span class="point-in">+${point.poi_in}</span>
							</c:when>
							<c:otherwise>
								<span class="point-out">-${point.poi_out}</span>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				</c:forEach>
			</table>
			<br>
			<div class="align-center">${page}</div>
			</c:if>
		</div>
	</div>
	
</body>
</html>