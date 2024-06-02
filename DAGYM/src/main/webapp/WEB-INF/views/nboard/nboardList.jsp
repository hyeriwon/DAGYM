<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NOTICE</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/breadcrumb-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb-text">
                        <h2>Notice</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">C/S</a>
                            <span>Notice</span>
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
	                    		<span>Notice</span>
	                            <h2>공지사항</h2>
	                    	</div>
	                 </div>
	             </div>
	          </div>
	          	<div class="row">
					<div class="col-lg-12">    
						<div class="chart-table">
						
						<!-- content 시작 -->
						<form id="search_form" action="nboardList.do" method="get">
							<ul class="search">
								<li>
									<select name="keyfield">
										<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>제목</option>
										<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>내용</option>
									</select>
								</li>
								<li>
									<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}">
								</li>
								<li>
									<input type="submit" value="검색">
								</li>
							</ul>
						</form>
						<br>
						<div class="list-space align-right">
							<c:if test="${user_auth == 9}">
							<input type="button" value="글쓰기" onclick="location.href='nboardWriteForm.do'">
							</c:if>
							<input type="button" value="목록" onclick="location.href='nboardList.do'">
							<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
						</div>
						<br>
						<c:if test="${count == 0}">
						
							<div class="result-display">
								표시할 게시물이 없습니다.
							</div>
						</c:if>
						<c:if test="${count > 0}">
							<table>
								<tr>
									<th>글번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>조회</th>
								</tr>
								<c:forEach var="nboard" items="${list}">
									<tr>
										<td>${nboard.nbo_num}</td>
										<td><a href="nboardDetail.do?nbo_num=${nboard.nbo_num}">${nboard.nbo_title}</a></td>
										<td>관리자</td>
										<td>${nboard.nbo_reg_date}</td>
										<td>${nboard.nbo_hit}</td>
									</tr>
								</c:forEach>
							</table>
							<br>
							<div class="align-center">${page}</div>
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