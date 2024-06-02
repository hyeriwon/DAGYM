<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>INBODY</title>
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
                        <h2>Inbody</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">MyPage</a>
                            <span>Inbody</span>
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
          	 <div class="align-right"></div>
          		<div class="team-title">
                		<div class="section-title">
                    		<span>Inbody</span>
                            <h2>인바디 상세</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					<div class="align-right">
					<input type="button" value="수정" onclick="location.href='${pageContext.request.contextPath}/inbody/inbodyModifyForm.do?inb_date=${inb_date}'">
					</div>
					<!-- content 시작 -->		
					<div class="result-display2">
						<table>
						<caption>${inb_date}일의 인바디 기록</caption>
							<tr>
								<th>항목</th>
								<th>기록</th>
							</tr>
							<tr>
								<td>키</td>
								<td>${inbody.inb_hei}cm</td>
							</tr>
							<tr>
								<td>몸무게</td>
								<td>${inbody.inb_wei}kg</td>
							</tr>
							<tr>
								<td>골격근량</td>
								<td>${inbody.inb_mus}kg</td>
							</tr>
							<tr>
								<td>bmi지수</td>
								<td>${inb_bmi}%</td>
							</tr>
							<tr>
							<td>상태</td>
							<c:choose>
							<c:when test="${inb_bmi < 18}">
									<td>저체중</td>
									</c:when>
									<c:when test="${inb_bmi < 23}">
									<td>정상</td>
									</c:when>
									<c:when test="${inb_bmi < 25}">
									<td>과체중</td>
									</c:when>
									<c:otherwise>
									<td>비만</td>
									</c:otherwise>
							</c:choose>
							</tr>
						</table>
					</div>
					<div class="align-center">
						<img src="${pageContext.request.contextPath}/upload/${inbody.inb_photo}" width="300" height="300">
					</div>
					<div class="align-center">
						<input type="button" value="확인" onclick="location.href='${pageContext.request.contextPath}/inbody/inbodyList.do?mem_num=${mem_num}'">
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