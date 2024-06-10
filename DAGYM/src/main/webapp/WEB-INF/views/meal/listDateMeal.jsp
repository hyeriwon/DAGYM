<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEAL</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/breadcrumb-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb-text">
                        <h2>Meal</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
							 <a href="#">
	                            <c:if test="${user_auth == 2}">MyPage</c:if>
	                            <c:if test="${user_auth >= 8}">Member</c:if>
                             </a>
                            <span>Meal</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

 <section class="team-section team-page spad">
      <div class="container">
          <div class="row">
          	 <div class="col-lg-12">
          		<div class="team-title">
                		<div class="section-title">
                    		<span>Meal</span>
                            <h2>식사상세</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<div class="result-display2">
						<table>
							<caption>${meal_date}일의 칼로리</caption>
							<thead>
								<tr>
									<th>식사분류</th>
									<th>메뉴이름</th>
									<th>칼로리</th>
								</tr>
							</thead>
							<c:forEach var = "meal" items="${meal}">
								<tr>
									<c:choose>
										<c:when test="${meal.meal_time == 0}">
										<td>아침</td>
										</c:when>
										<c:when test="${meal.meal_time == 1}">
										<td>점심</td>
										</c:when>
										<c:when test="${meal.meal_time == 2}">
										<td>저녁</td>
										</c:when>
										<c:otherwise>
										<td>간식</td>
										</c:otherwise>
									</c:choose>
									<td>${meal.tme_name}</td>
									<td><fmt:formatNumber value="${meal.tme_kcal}"/>Kcal</td>
								</tr>
								</c:forEach>
								<tr>
									<td colspan="2">총칼로리</td>
									<td><fmt:formatNumber value="${totalKcal}"/>Kcal</td>
								</tr>
						</table>
					</div>
					<div class="align-center">
						<c:if test="${user_auth >=8}">
						<input type="button" value="확인" onclick="location.href='${pageContext.request.contextPath}/meal/mealDetail.do?client_num=${param.client_num}'">
						</c:if>
						<c:if test="${user_auth ==2}">
						<input type="button" value="확인" onclick="location.href='${pageContext.request.contextPath}/meal/mealDetail.do'">
						</c:if>
					</div>
					<!-- content 끝 -->
					
					</div>
				</div>
			</div>
	      </div>
	  </section>
	  
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<jsp:include page="/WEB-INF/views/common/js_plugins.jsp"/>

</body>
</html>