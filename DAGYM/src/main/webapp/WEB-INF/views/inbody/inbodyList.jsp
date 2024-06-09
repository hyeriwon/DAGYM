<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>INBODY</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
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
							 <a href="#">
	                            <c:if test="${user_auth == 2}">MyPage</c:if>
	                            <c:if test="${user_auth >= 8}">Member</c:if>
                             </a>
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
          		<div class="team-title">
                		<div class="section-title">
                    		<span>Inbody</span>
                            <h2>인바디</h2>
                    	</div>
                 </div>	
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->		
					<form id="search_form" action="inbodyList.do" method="get">
						<input type="hidden" id="client_num" value="${param.client_num}" name="client_num">
						<ul class="search">
						<li>
						<select name = "keyfield">
							<option value="1"<c:if test="${param.keyfield ==1}">selected</c:if>>날짜</option>
						</select>
						</li>
						<li>
							<input type="search" size = "16" name="keyword" id = "keyword" value="${param.keyword}">
						</li>
						<li>
							<input type="submit" value="검색">
						</li>
						</ul>
					</form>
					<br>
					
					<div class= "list-space align-right">
						<c:if test="${user_auth==2}">
						<input type="button" value="등록" onclick="location.href='inbodyMain.do'">
						</c:if>
					</div>
					<br>
					
						<c:if test="${count==0 }">
							<div class="result-display">
								표시할 게시물이 없습니다.
							</div>
						</c:if>
						<c:if test="${count>0 }">
						<table>
							<thead>
								<tr>
									<th>측정일자</th>
									<th>키(cm)</th>
									<th>몸무게(kg)</th>
									<th>골격근량(kg)</th>
									<th>삭제</th>
								</tr>
							</thead>
							<c:forEach var="inbody" items="${list}">
								<tr>
									<c:if test="${user_auth>=8}">
									<td><a href="inbodyDetail.do?inb_date=${inbody.inb_date}&client_num=${param.client_num}">${inbody.inb_date}</a></td>
									</c:if>
									<c:if test="${user_auth==2}">
									<td><a href="inbodyDetail.do?inb_date=${inbody.inb_date}">${inbody.inb_date}</a></td>
									</c:if>
									<td>${inbody.inb_hei }</td>
									<td>${inbody.inb_wei}</td>
									<td>${inbody.inb_mus}</td>
									<td>
									<div class="align-center">
										<c:if test="${user_auth==2}">
										<input type="button" value="삭제" onclick="confirmDelete('deleteInbody.do?inb_num=${inbody.inb_num}')">
										</c:if>
										<c:if test="${user_auth>=8}">
										<input type="button" value="삭제" onclick="confirmDelete('deleteInbody.do?inb_num=${inbody.inb_num}&client_num=${param.client_num}')">
										</c:if>
									</div>
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