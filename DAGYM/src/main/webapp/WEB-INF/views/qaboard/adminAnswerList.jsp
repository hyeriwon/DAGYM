<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/qaboard.inquiry.js"></script>
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('search_form');
	myForm.onsubmit=function(){
		const keyword = document.getElementById('keyword');
		if(keyword.value.trim()==''){
			alert('검색어를 입력하세요');
			keyword.value = '';
			keyword.focus();
			return false;
		}
	};
};
</script>
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
                            <a href="#">Member</a>
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
                            <h2>회원목록 (문의내역)</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->	
					<%-- 검색 --%>
					<form id="search_form" action="adminAnswerList.do" method="get">
						<ul class="search">
							<li>
								<select name="keyfield">
									<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>아이디</option>
									<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>제목</option>
									<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>내용</option>
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
					<%-- 목록 --%>
					<div class="list-span">
						<div class="align-left">
							<form action="adminAnswerList.do" method="get">
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
						<div class="align-right">
							<input type="button" value="목록" onclick="location.href='adminAnswerList.do'">
						</div>
					</div>
					<br>
					<c:if test="${count == 0}">
						<hr class="fixed-divider" size="1" width="100%" noshade="noshade">
						<div class="result-display">
							표시할 문의내역이 없습니다
						</div>
						<hr class="fixed-divider" size="1" width="100%" noshade="noshade">
					</c:if>
					<c:if test="${count > 0}">
						<table>
							<thead>
								<tr>
									<th>카테고리</th>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>답변여부</th>
									<th>삭제여부</th>
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
									<td><a href="adminAnswerDetail.do?qab_num=${qaboard.qab_num}">${qaboard.qab_title}</a></td>
									<td>${qaboard.mem_id}</td>
									<td>${qaboard.qab_reg_date}</td>
									<td>
										<c:if test="${qaboard.qab_ref==0}"><span style="color:red;">미답변</span></c:if>
										<c:if test="${qaboard.qab_ref>0}">답변완료</c:if>
									</td>
									<td>
										<c:if test="${qaboard.qab_remove==0}">X</c:if>
										<c:if test="${qaboard.qab_remove==1}">O</c:if>
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