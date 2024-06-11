<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MYPAGE</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SYJ.css" type="text/css">
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
                    		<c:if test="${user_auth == 2}">
                            <h2>회원상세</h2>
                         </c:if>
                         <c:if test="${user_auth == 8}">
                            <h2>강사상세</h2>
                         </c:if>
                         <c:if test="${user_auth == 9}">
                            <h2>관리자상세</h2>
                         </c:if>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<form id="modify_form">
						<ul>
							<li>
								<label>아이디</label>
								${member.mem_id}
							</li>
							<li>
								<label>이름</label>
								${member.mem_name}
							</li>
							<li>
								<label>프로필</label>
								<c:if test="${empty member.mem_photo}">
									<img src="${pageContext.request.contextPath}/images/face.png" width="50" height="50" class="my-photo">
								</c:if>
								<c:if test="${!empty member.mem_photo}">
									<img src="${pageContext.request.contextPath}/upload/${member.mem_photo}" width="50" height="50" class="my-photo">
								</c:if>
							</li>
							<li>
								<label>전화번호</label>
								${member.mem_phone}
							</li>
							<li>
								<label>이메일</label>
								${member.mem_email}
							</li>
							<c:if test="${member.mem_gender == 1}">
								<li><label>성별</label>여성</li>
							</c:if>
							<c:if test="${member.mem_gender == 0}">
								<li><label>성별</label>남성</li>
							</c:if>
							<li>
								<label>생일</label>
								${member.mem_birth}
							</li>
							<li>
								<label>우편번호</label>
								${member.mem_zipcode}
							</li>
							<li>
								<label>주소</label>
								${member.mem_address1} ${member.mem_address2}
							</li>
							<li>
								<label>가입일</label>
								${member.mem_reg_date}
							</li>
							<c:if test="${!empty member.mem_modify_date}">
								<li><label>수정일</label>${member.mem_modify_date}</li>
							</c:if>				
						</ul>
						<br>
						<div class="align-center">
							<input type="button" value="수정" onclick="location.href='modifyUserForm.do'">
							<input type="button" value="탈퇴" onclick="location.href='deleteUserForm.do'">
						</div>
					</form>
						
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