<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ATTEND</title>
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
                        <h2>Attend</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">Member</a>
                            <span>Attend</span>
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
                    		<span>Attend</span>
                            <h2>회원목록 (출석체크)</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<hr class="fixed-divider" size="1" width="100%" noshade="noshade">
					<c:if test="${count == 0}">
						<div class="result-display">
							표시할 회원정보가 없습니다.
						</div>
						<hr class="fixed-divider" size="1" width="100%" noshade="noshade">
					</c:if>
					<c:if test="${count > 0}">
					<table>
						<tr>
							<th>아이디</th>
						</tr>
						<c:forEach var="member" items="${list}">
						<tr>
							<td><a href="adminList.do?mem_num=${member.mem_num}">${member.mem_id}</a></td>
						</tr>
						</c:forEach>
					</table>
					<hr class="fixed-divider" size="1" width="%" noshade="noshade">
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
