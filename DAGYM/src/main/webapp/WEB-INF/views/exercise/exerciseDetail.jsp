<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EXERCISE</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-section set-bg"
		data-setbg="${pageContext.request.contextPath}/resources/img/breadcrumb-bg.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="breadcrumb-text">
						<h2>Exercise</h2>
						<div class="bt-option">
							<a href="${pageContext.request.contextPath}/main/main.do">Home</a>
							<a href="#">
	                            <c:if test="${user_auth == 2}">MyPage</c:if>
	                            <c:if test="${user_auth >= 8}">Member</c:if>
                            </a>
							<span>Exercise</span>
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
							<span>Exercise</span>
							<h2>운동상세</h2>
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
								<caption>${exe_date}일의운동기록</caption>
								<thead>
									<tr>
										<th>운동부위</th>
										<th>운동시간(분)</th>
										<th>운동상세</th>
										<th>수정</th>
									</tr>
								</thead>
								<c:forEach var="exercise" items="${exerciselist}">
									<tr>
										<td>${exercise.exe_type}</td>
										<td>${exercise.exe_time}</td>
										<td>${exercise.exe_content}</td>
										<td>
											<div class="align-center">
												<c:if test="${user_auth==2}">
													<input type="button" value="수정"
														onclick="location.href='${pageContext.request.contextPath}/exercise/exerciseModifyForm.do?exe_num=${exercise.exe_num}'">
												</c:if>
												<c:if test="${user_auth>=8}">
													<input type="button" value="수정"
														onclick="location.href='${pageContext.request.contextPath}/exercise/exerciseModifyForm.do?exe_num=${exercise.exe_num}&client_num=${param.client_num}'">
												</c:if>
											</div>
										</td>
									</tr>
								</c:forEach>
							</table>
						</div>
						<div class="align-center">
							<input type="button" value="확인"
								onclick="location.href='${pageContext.request.contextPath}/exercise/exerciseList.do?client_num=${param.client_num}'">
						</div>
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