<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>REVIEW</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<style type="text/css">
    .yellow-bg {
        background-color: yellow;
    }
</style>
<script type="text/javascript">
window.onload = function(){
	const searchForm = document.getElementById('search_form');
	searchForm.onsubmit = function(){
		const keyword = document.getElementById('keyword');
		if(keyword.value.trim() == ''){
			alert('검색어를 입력해주세요!');
			keyword.value = '';
			keyword.focus();
			return false;
		}
	}
};
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
                        <h2>Review</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">About</a>
                            <span>Review</span>
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
                    		<span>Review</span>
                            <h2>수강후기</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<form id="search_form" action="listReview.do" method="get">
						<ul class="search">
							<li> 
								<select name="keyfield">
									<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>트레이너 이름</option>
									<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>제목</option>
									<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>내용</option>
								</select>					
							</li>
							<li>
								<input type="search" size="20" name="keyword" id="keyword" value="${param.keyword}">
							</li>
							<li>
								<input type="submit" value="검색">
							</li>
						</ul>
					</form>
					<br><br>
					<c:if test="${count == 0}">
						<div class="result-display">
							표시할 게시물이 없습니다.
						</div>
					</c:if>
					<c:if test="${count > 0}">
						<table>
							<tr>
								<th>제목</th>
								<th>트레이너</th>
								<th>수업일시</th>
								<th>회원ID</th>
								<th>별점</th>
								<th>등록일</th>
								<th>조회수</th>
							</tr>
							<c:forEach var="review" items="${list}">
								<tr class="<c:if test='${review.rev_del==1}'>yellow-bg</c:if>">
									<td><a href="detailReview.do?rev_num=${review.rev_num}">${review.rev_title}</a></td>
									<td>${review.tra_name}</td>
									<td>${review.sch_date}시</td>
									<td>
										<c:if test="${review.mem_num != user_num}">
											<c:set var="len" value="${fn:length(review.mem_id)}"/>
											<c:set var="maskedId" value="${fn:substring(review.mem_id, 0, 4)}"/>
											<c:set var="maskedId" value="${maskedId}${fn:substring('********', 0, len-4)}"/>
											${maskedId}
										</c:if>
										<c:if test="${review.mem_num == user_num}">
											${member.mem_id}
										</c:if>
									</td>
									<td>
										<c:forEach var="i" begin="1" end="5">
											<c:if test="${i <= review.rev_grade}">
												<span style="color:#ff5500;">★</span>
											</c:if>
											<c:if test="${i > review.rev_grade}">
												<span style="color: #ddd;">★</span>
											</c:if>
										</c:forEach>
									</td>
									<td>${review.rev_reg_date}</td>
									<td>${review.rev_hit}</td>
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