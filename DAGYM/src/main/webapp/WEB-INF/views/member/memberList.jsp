<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MYPAGE</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('search_form');
	//이벤트 연결
	myForm.onsubmit=function(){
		const keyword = document.getElementById('keyword');
		if(keyword.value.trim()==''){//아무것도 입력하지 않은 경우
			alert('검색어를 입력하세요');
			keyword.value='';
			keyword.focus();
			return false;
		}
	};
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
                        <h2>Mypage</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">Member</a>
                            <span>Mypage</span>
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
                    		<span>Mypage</span>
                            <h2>회원목록 (회원상세)</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<%-- 검색 --%>
					<form id="search_form" action="adminMemberList.do" method="get">
						<ul class="search">
							<li>
								<select name="keyfield">
									<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>이름</option>
									<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>아이디</option>
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
					<div class="list-span align-right">
						<input type="button" value="목록" onclick="location.href='adminMemberList.do'">
					</div>
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
							<th>이름</th>
							<th>전화번호</th>
							<th>생년월일</th>
							<th>담당트레이너</th>
							<th>가입일</th>
							<th>등급</th>
						</tr>
						<c:forEach var="member" items="${list}">
						<tr>
							<td>
							<c:if test="${member.mem_auth > 0}">
							<a href="adminUserForm.do?mem_num=${member.mem_num}">${member.mem_id}</a>
							</c:if>
							<c:if test="${member.mem_auth == 0}">${member.mem_id}</c:if>
							</td>
							<td>${member.mem_name}</td>
							<td>${member.mem_phone}</td>
							<td>${member.mem_birth}</td>
							<td><%-- 담당트레이너 데이터 --%></td>
							<td>${member.mem_reg_date}</td>
							<td>
								<c:if test="${member.mem_auth == 0}">탈퇴</c:if>
								<c:if test="${member.mem_auth == 1}">정지</c:if>
								<c:if test="${member.mem_auth == 2}">일반</c:if>
							</td>
						</tr>
						</c:forEach>
					</table>
					<hr class="fixed-divider" size="1" width="%" noshade="noshade">
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
