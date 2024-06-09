<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEAL</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
<script type="text/javascript">
window.onload=function(){
	const myform= document.getElementById('search_form');
	
	myform.onsubmit=function(){
		const keyword = document.getElementById('keyword');
		if(keyword.value.trim()==''){
			alert('검색어를 입력하세요');
			keyword.value='';
			keyword.focus();
			return false;
		}
	}
}
	function confirmDelete(url) {
	    if (confirm('정말 삭제하시겠습니까?')) {
	        location.href = url;
	    }
	}
</script>
</head>
<body>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-section set-bg"
		data-setbg="${pageContext.request.contextPath}/resources/img/breadcrumb-bg.jpg">
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
							<h2>식사기록</h2>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="chart-table">

						<!-- content 시작 -->
						<form id="search_form" action="mealDetail.do" method="get">
							<ul class="search">
								<li><select name="keyfield">
										<option value="1"
											<c:if test="${param.keyfield ==1}">selected</c:if>>음식이름</option>
										<option value="2"
											<c:if test="${param.keyfield ==2}">selected</c:if>>날짜</option>
								</select></li>
								<li><input type="search" size="16" name="keyword"
									id="keyword" value="${param.keyword}"></li>
								<li><input type="submit" value="검색"></li>
							</ul>
							<input type="hidden" name="client_num"
								value="${param.client_num}">
						</form>

						<div class="list-space align-right">
							<c:if test="${ user_auth ==2}">
								<input type="button" value="등록"
									onclick="location.href='list.do'">
							</c:if>
							<c:if test="${ user_auth >=8}">
								<input type="button" value="회원검색"
									onclick="location.href='list.do'">
							</c:if>
							<input type="button" value="홈으로"
								onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
						</div>
						<c:if test="${count==0 }">
							<div class="result-display">표시할 게시물이 없습니다.</div>
						</c:if>
						<c:if test="${count>0 }">
							<table>
							<thead>
								<tr>
									<th>식사일자</th>
									<th>식사분류</th>
									<th>메뉴이름</th>
									<th>칼로리</th>
									<th>삭제</th>
								</tr>
							</thead>
							<c:forEach var="meal" items="${meal}">
								<tr>
									<td>
										<c:if test="${user_auth ==2}">
										<a href="listDateMeal.do?meal_date=${meal.meal_date}">${meal.meal_date}</a>
										</c:if>
										<c:if test="${user_auth >=8}">
										<a href="listDateMeal.do?meal_date=${meal.meal_date}&client_num=${param.client_num}">${meal.meal_date}</a>
										</c:if>	
										</td>
										<c:choose>
											<c:when test="${meal.meal_time ==0}">
												<td>아침</td>
											</c:when>
											<c:when test="${meal.meal_time ==1}">
												<td>점심</td>
											</c:when>
											<c:when test="${meal.meal_time ==2}">
												<td>저녁</td>
											</c:when>
											<c:otherwise>
												<td>간식</td>
											</c:otherwise>
										</c:choose>
										<td>${meal.tme_name}</td>
										<td>${meal.tme_kcal}</td>
										<td>
											<div class="align-center">
											<c:if test="${user_auth ==2}">
												<input type="button" value="삭제"
													onclick="confirmDelete('delete.do?meal_num=${meal.meal_num}')">
											</c:if>
											<c:if test="${user_auth >=8}">
												<input type="button" value="삭제"
													onclick="confirmDelete('delete.do?meal_num=${meal.meal_num}&client_num=${param.client_num}')">
											</c:if>
											</div>
										</td>
									</tr>
								</c:forEach>
							</table>
							<div class="align-center">
								<div class="blog-pagination">
									${page}
								</div>
							</div>
						</c:if>
						<!-- content 끝 -->

					</div>
				</div>
			</div>
		</div>
	</section>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<jsp:include page="/WEB-INF/views/common/js_plugins.jsp" />

</body>
</html>