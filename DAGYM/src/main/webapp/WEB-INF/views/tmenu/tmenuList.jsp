<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MENU</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet"href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">	
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
                            <h2>메뉴목록</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<form id = "search_form" action = "tmenuList.do" method="get">
					<ul class="search">
					<li>
					<select name = "keyfield">
						<option value="1"<c:if test="${param.keyfield ==1}">selected</c:if>>메뉴이름</option>
						<option value="2"<c:if test="${param.keyfield ==2}">selected</c:if>>식사분류</option>
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
					<input type="button" value="등록" onclick="location.href='tmenuWriteForm.do'">
					<input type="button" value="목록" onclick="location.href='tmenuList.do'">
					</div>
					<br>
					
					<c:if test="${count==0 }">
						<div class="result-display">
							표시할 게시물이 없습니다.
						</div>
					</c:if>
					<c:if test="${count>0}">
						<table>
							<thead>
								<tr>
									<th>메뉴번호</th>
									<th>메뉴이름</th>
									<th>칼로리</th>
									<th>식사분류</th>
									<th>메뉴추천</th>
								</tr>
							</thead>
							<c:forEach var = "tmenu" items="${list}">
								<tr>
								<td>${tmenu.tme_num}</td>
								<td><a href="tmenuDetail.do?tme_num=${tmenu.tme_num}">${tmenu.tme_name}</a></td>
								<td>${tmenu.tme_kcal}</td>
								<c:choose>
									<c:when test="${tmenu.tme_type ==0}">
									<td>아침</td>
									</c:when>
									<c:when test="${tmenu.tme_type ==1}">
									<td>점심</td>
									</c:when>
									<c:when test="${tmenu.tme_type ==2}">
									<td>저녁</td>
									</c:when>
									<c:when test="${tmenu.tme_type ==3}">
									<td>간식</td>
									</c:when>
									<c:otherwise>
									<td>검색용 메뉴</td>
									</c:otherwise>
								</c:choose>
								<td>
									<c:if test="${tmenu.tme_type <= 2 }">
									<input type="button" value="추천" onclick="location.href='${pageContext.request.contextPath}/tmenu/tmenuRecommend.do?tme_num=${tmenu.tme_num}'">								
									</c:if>
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