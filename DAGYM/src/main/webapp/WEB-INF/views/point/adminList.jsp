<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>POINT</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
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

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/breadcrumb-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb-text">
                        <h2>Point</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">Member</a>
                            <span>Point</span>
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
                    		<span>Point</span>
                            <h2>포인트 내역</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<br>
					<c:if test="${count == 0}">
					<div class="result-display">
						표시할 게시물이 없습니다.
					</div>
					</c:if>
					<c:if test="${count > 0}">
					<h3>전체 누적 : <fmt:formatNumber value="${totalPointsIn}" type="number" groupingUsed="true"/>p</h3>
					<h3>사용 가능 : <span class="point-in"><fmt:formatNumber value="${totalPointsInOut}" type="number" groupingUsed="true"/>p</span></h3>
					<input type="button" value="포인트 사용" onclick="location.href='outForm.do?mem_num=${mem_num}'">
					<table>
						<thead>
							<tr>
								<th>날짜</th>
								<th>적립 종류</th>
								<th>포인트</th>
							</tr>
						</thead>
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
								<!-- 숫자 쉼표 표시 -->
								<td>
									<c:choose>
									    <c:when test="${point.poi_in > 0}">
									        <span class="point-in">+<fmt:formatNumber value="${point.poi_in}" type="number" groupingUsed="true"/></span>
									    </c:when>
									    <c:otherwise>
									        <span class="point-out">-<fmt:formatNumber value="${point.poi_out}" type="number" groupingUsed="true"/></span>
									    </c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</table>
					<br>
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
  	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<jsp:include page="/WEB-INF/views/common/js_plugins.jsp"/>
	
</body>
</html>