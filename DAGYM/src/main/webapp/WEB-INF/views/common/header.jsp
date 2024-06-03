<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

	<!-- Offcanvas Menu Section Begin -->
 	<jsp:include page="/WEB-INF/views/common/mobile.jsp"/>
 	<!-- Offcanvas Menu Section End -->

	<!-- header 시작 -->
    <header class="header-section">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-3">
                    <div class="logo">
                        <a href="${pageContext.request.contextPath}/main/main.do">
                            <img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="">
                        </a>
                    </div>
                </div>
                <div class="col-lg-6">
                    <nav class="nav-menu">
                        <ul> <!-- 공통 -->
                        	 <li class="active"><a href="${pageContext.request.contextPath}/main/main.do">Home</a></li>
                             <li><a href="#">About Us</a>                            		
                             	 <ul class="dropdown">
                                     <li><a href="${pageContext.request.contextPath}/main/about.do">센터소개</a></li>
                                     <li><a href="${pageContext.request.contextPath}/review/listReview.do">수강후기</a></li>
                                 </ul>
                             </li>
                             <li><a href="${pageContext.request.contextPath}/payment/paymentInfo.do">Membership</a></li>
                             <li><a href="#">C/S</a>
                            	 <ul class="dropdown">
                                     <li><a href="${pageContext.request.contextPath}/nboard/nboardList.do">공지사항</a></li>
                                     <li><a href="${pageContext.request.contextPath}/qaboard/userQuestionList.do">1:1문의</a></li>
                                     <li><a href="${pageContext.request.contextPath}/nboard/faqBoard.do">자주하는질문</a></li>
                                 </ul>
                             </li>
                             
                            <c:if test="${!empty user_num && user_auth != 8 && user_auth != 9}"><!-- 회원 -->
	                        	<li><a href="#">Class</a>
	                        		<ul class="dropdown">
	                                    <li><a href="#">강사프로필</a></li>
	                                    <li><a href="${pageContext.request.contextPath}/history/list.do">PT신청</a></li>
	                                </ul>
	                        	</li>
                        	</c:if>
                        		
                        	<c:if test="${!empty user_num && user_auth == 8}"><!-- 강사 -->
                        		<li><a href="#">MEMBER</a>
                        			<ul class="dropdown">
	                                    <li><a href="${pageContext.request.contextPath}/member/adminMemberList.do">회원상세</a></li>
	                                    <li><a href="${pageContext.request.contextPath}/attend/adminMemberList.do">출석체크</a></li>
	                                	<li><a href="${pageContext.request.contextPath}/point/adminMemberList.do">포인트</a></li>
										<li><a href="#">운동기록</a></li>
										<li><a href="${pageContext.request.contextPath}/meal/list.do">식사기록</a></li>
										<li><a href="${pageContext.request.contextPath}/inbody/inbodyMain.do">인바디</a></li>
										<li><a href="#">수강내역</a></li>
										<li><a href="#">문의내역</a></li>
                                	</ul>
                        		</li>
                        	</c:if>
                        		
							<c:if test="${!empty user_num && user_auth == 9}"><!-- 관리자 -->
                        		<li><a href="#">MEMBER</a>
                        			<ul class="dropdown">
                                    	<li><a href="${pageContext.request.contextPath}/member/adminMemberList.do">회원상세</a></li>
                                    	<li><a href="${pageContext.request.contextPath}/attend/adminMemberList.do">출석체크</a></li>
                                		<li><a href="${pageContext.request.contextPath}/point/adminMemberList.do">포인트</a></li>
										<li><a href="#">운동기록</a></li>
										<li><a href="${pageContext.request.contextPath}/meal/list.do">식사기록</a></li>
										<li><a href="${pageContext.request.contextPath}/inbody/inbodyMain.do">인바디</a></li>
										<li><a href="#">수강내역</a></li>
										<li><a href="${pageContext.request.contextPath}/qaboard/adminAnswerList.do">문의내역</a></li>
                                 	</ul>
                        		</li>					
                        		<li><a href="#">TRAINER</a>
                        			<ul class="dropdown">
                                     	<li><a href="${pageContext.request.contextPath}/member/adminTrainerList.do">강사상세</a></li>
                                     	<li><a href="#">스케줄</a></li>
                                 	</ul>
                        		<li>		                    							
							</c:if>
							
                        </ul>
                    </nav>
                </div>
                <div class="col-lg-3">
                    <div class="top-option">
                        <div class="to-social">
	                        <nav class="nav-menu">
		                        <ul>
		                        	<c:if test="${!empty user_num && user_auth != 8 && user_auth != 9}"><!-- 회원 -->
		                            <li><a href="#"><i class="fa fa-user"></i></a>
		                        		<ul class="dropdown">
		                                     <li><a href="${pageContext.request.contextPath}/member/myPage.do">회원상세</a></li>
		                                     <li><a href="${pageContext.request.contextPath}/attend/list.do">출석체크</a></li>
		                                     <li><a href="${pageContext.request.contextPath}/point/list.do">포인트</a></li>
		                                     <li><a href="#">운동기록</a></li>
		                                     <li><a href="${pageContext.request.contextPath}/meal/mealDetail.do">식사기록</a></li>
		                                     <li><a href="${pageContext.request.contextPath}/inbody/inbodyList.do">인바디</a></li>
		                                     <li><a href="#">수강내역</a></li>
		                                     <li><a href="${pageContext.request.contextPath}/qaboard/userQuestionList.do">문의내역</a></li>
		                                 </ul>
			                        <li>  
			                        </c:if>

		                        	<c:if test="${!empty user_num && user_auth == 8}"><!-- 강사 -->
		                        		<li><a href="#"><i class="fa fa-user"></i></a>
		                        			<ul class="dropdown">
		                                     <li><a href="${pageContext.request.contextPath}/member/myPage.do">강사상세</a></li>
		                                     <li><a href="${pageContext.request.contextPath}/schedule/list.do">스케줄</a></li>
		                                 </ul>
		                        		<li>
		                        	</c:if>
		                        		
		                        	<c:if test="${!empty user_num && user_auth == 9}"><!-- 관리자 -->
		                        		<li><a href="#"><i class="fa fa-user"></i></a>
		                        			<ul class="dropdown">
		                                     <li><a href="${pageContext.request.contextPath}/payment/paymentMemberList.do">회원권등록</a></li>
		                                     <li><a href="${pageContext.request.contextPath}/tmenu/tmenuList.do">메뉴등록</a></li>
		                                 </ul>
		                        		<li>                        							
									</c:if>
									
		                        	</ul>  
                            </nav>
                        </div>
                        <div class="to-social">
                            <c:if test="${empty user_num}"><!-- 로그인 전 -->
								<a href="${pageContext.request.contextPath}/member/loginForm.do">Login</a>
							</c:if>
							<c:if test="${!empty user_num}"><!-- 로그인 후 -->
								<a href="${pageContext.request.contextPath}/member/logout.do">Logout</a>
							</c:if>
                        </div>
                    </div>
                </div>
            </div>
            <div class="canvas-open">
                <i class="fa fa-bars"></i>
            </div>
        </div>
    </header>
	<!-- header 끝 -->
