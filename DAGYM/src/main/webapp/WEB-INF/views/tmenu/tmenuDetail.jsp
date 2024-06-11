	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>MENU</title>
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
	                        <h2>Menu</h2>
	                        <div class="bt-option">
	                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
	                            <a href="#">Mypage</a>
	                            <span>Menu</span>
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
	                    		<span>Menu</span>
	                            <h2>메뉴상세</h2>
	                    	</div>
	                 </div>
	             </div>
	          </div>
	          	<div class="row">
					<div class="col-lg-12">    
						<div class="chart-table">
						
						<!-- content 시작 -->
						<div class="align-center">
							<span style="font-size:20pt"><b><h3>${tmenu.tme_name}</h3></b></span>
						</div>
						<br><br>
						<div style="overflow: auto;">
							<div class="align-left" style="width:600px; float: left;">
								<img src="${pageContext.request.contextPath}/upload/${tmenu.tme_photo}" width="500px">
							</div >
							<div class="align-right" style="width:300px;">
								<div>
									<ul>
										<li> <h4>음식 영양 정보</h4></li>
										<br>
										<li> 칼로리 : ${tmenu.tme_kcal} Kcal</li>
										<li> 탄수화물 : ${tmenu.tme_crabs} g</li>
										<li> 단백질 : ${tmenu.tme_protein} g</li>
										<li> 지방: ${tmenu.tme_lipid} g</li>
									</ul>
									<br>
								</div>
							</div>
							<div class="content-text" style="width:300px; float: right;">
							<p>
							<div class="margin-10"><h4>음식상세</h4></div>
							<br>
							<div class="margin-10">
								&ensp;${tmenu.tme_content}
							</div>
							</div>
							<br>
							<div id="output"></div>
						</div>
						<br>
						<c:if test="${user_auth <8 || user_num == null}">
						<div class="align-center">
							<input type="button" value="목록" onclick="location.href='tmenuRecommendList.do'">
						</div>
						</c:if>
						<c:if test="${user_auth >=8}">
							<div class="align-right">
								<input type="button" value="수정" onclick="location.href='tmenuModifyForm.do?tme_num=${tmenu.tme_num}'">
								<input type="button" value="삭제" onclick="location.href='tmenuDelete.do?tme_num=${tmenu.tme_num}'">
								<input type="button" value="목록" onclick="location.href='tmenuList.do'">
							</div>
						</c:if>
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