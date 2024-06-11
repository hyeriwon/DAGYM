<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
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
                        <h2>Q&A</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">MyPage</a>
                            <span>Q&A</span>
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
                    		<span>Q&A</span>
                            <h2>문의내역</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->		
					<%-- 목록 --%>
					<c:if test="${count > 0}">
					<div class="align-left">
						<form class="userQuestion" action="userQuestionList.do" method="get">
							<select name="category" onchange="this.form.submit()">
								<option value="">전체</option>
								<option value="1" <c:if test="${param.category==1}">selected</c:if>>PT</option>
								<option value="2" <c:if test="${param.category==2}">selected</c:if>>다이어트</option>
								<option value="3" <c:if test="${param.category==3}">selected</c:if>>상담</option>
								<option value="4" <c:if test="${param.category==4}">selected</c:if>>회원권 상담</option>
								<option value="5" <c:if test="${param.category==5}">selected</c:if>>기타</option>
							</select>
						</form>
					</div>
					</c:if>
					<div class="align-right">
						<input type="button" value="등록" onclick="location.href='userWriteForm.do'">
					</div>
					<br>
					
					<c:if test="${count == 0}">
						<div class="result-display">
							표시할 문의내역이 없습니다.
						</div>
					</c:if>
					<c:if test="${count > 0}">
						<table>
							<thead>
								<tr>
									<th>카테고리</th>
									<th>제목</th>
									<th>작성일</th>
									<th>답변여부</th>
								</tr>
							</thead>
							<c:forEach var="qaboard" items="${list}">
							<tr>
								<td>
									<c:if test="${qaboard.qab_type==1}">PT</c:if>
									<c:if test="${qaboard.qab_type==2}">다이어트</c:if>
									<c:if test="${qaboard.qab_type==3}">상담</c:if>
									<c:if test="${qaboard.qab_type==4}">회원권 상담</c:if>
									<c:if test="${qaboard.qab_type==5}">기타</c:if>
								</td>
								<td><a href="userDetail.do?qab_num=${qaboard.qab_num}">${qaboard.qab_title}</a></td>
								<td>${qaboard.qab_reg_date}</td>
								<td>
									<c:if test="${qaboard.qab_ref == 0}">미답변</c:if>
									<c:if test="${qaboard.qab_ref > 0}">답변완료</c:if>
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