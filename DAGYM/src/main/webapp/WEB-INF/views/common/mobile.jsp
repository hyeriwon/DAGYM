<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- 공통 -->
    <c:if test="${empty user_num}">
	 <!-- Offcanvas Menu Section Begin -->
	 	    <div class="offcanvas-menu-overlay"></div>
	    <div class="offcanvas-menu-wrapper">
	        <div class="canvas-close">
	            <i class="fa fa-close"></i>
	        </div>
	        <nav class="canvas-menu mobile-menu">
	            <ul>
	                <li><a href="${pageContext.request.contextPath}/main/main.do">Home</a></li>
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
                            <li><a href="${pageContext.request.contextPath}/nboard/faqBoard.do">자주하는질문</a></li>
	                    </ul>
	                </li>
	            </ul>
	        </nav>
	        <div id="mobile-menu-wrap"></div>
	        <div class="canvas-social">
	            <a href="#"><i class="fa fa-facebook"></i></a>
	            <a href="#"><i class="fa fa-twitter"></i></a>
	            <a href="#"><i class="fa fa-youtube-play"></i></a>
	            <a href="#"><i class="fa fa-instagram"></i></a>
	        </div>
	    </div>
    <!-- Offcanvas Menu Section End -->
    </c:if>
    
	<c:if test="${!empty user_num && user_auth != 8 && user_auth != 9}"><!-- 회원 -->	                       
	    <div class="offcanvas-menu-overlay"></div>
	    <div class="offcanvas-menu-wrapper">
	        <div class="canvas-close">
	            <i class="fa fa-close"></i>
	        </div>
	        <nav class="canvas-menu mobile-menu">
	            <ul>
	                <li><a href="${pageContext.request.contextPath}/main/main.do">Home</a></li>
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
                            <li><a href="${pageContext.request.contextPath}/nboard/faqBoard.do">자주하는질문</a></li>
	                    </ul>
	                </li>
	                <li><a href="#">Class</a>
	                	<ul class="dropdown">
	                    	<li><a href="${pageContext.request.contextPath}/main/profile.do">강사프로필</a></li>
	                    	<li><a href="${pageContext.request.contextPath}/history/list.do">PT신청</a></li>
	                    </ul>
	                </li>
	                <li><a href="#">Mypage</a>
	                	<ul class="dropdown">
		                	<li><a href="${pageContext.request.contextPath}/member/myPage.do">회원상세</a></li>
		                    <li><a href="${pageContext.request.contextPath}/attend/list.do">출석체크</a></li>
		                    <li><a href="${pageContext.request.contextPath}/point/list.do">포인트</a></li>
		                    <li><a href="${pageContext.request.contextPath}/exercise/exerciseList.do">운동기록</a></li>
		                    <li><a href="${pageContext.request.contextPath}/meal/mealDetail.do">식사기록</a></li>
		                    <li><a href="${pageContext.request.contextPath}/inbody/inbodyList.do">인바디</a></li>
		                    <li><a href="${pageContext.request.contextPath}/history/mylist.do">수강내역</a></li>
		                    <li><a href="${pageContext.request.contextPath}/qaboard/userQuestionList.do">문의내역</a></li>
	                    </ul>
	                </li>	                
	            </ul>
	        </nav>
	        <div id="mobile-menu-wrap"></div>
	        <div class="canvas-social">
	            <a href="#"><i class="fa fa-facebook"></i></a>
	            <a href="#"><i class="fa fa-twitter"></i></a>
	            <a href="#"><i class="fa fa-youtube-play"></i></a>
	            <a href="#"><i class="fa fa-instagram"></i></a>
	        </div>
	    </div>
    <!-- Offcanvas Menu Section End -->
    </c:if>
    
 	<c:if test="${!empty user_num && user_auth == 8}"><!-- 강사 --> 	                       
	    <div class="offcanvas-menu-overlay"></div>
	    <div class="offcanvas-menu-wrapper">
	        <div class="canvas-close">
	            <i class="fa fa-close"></i>
	        </div>
	        <nav class="canvas-menu mobile-menu">
	            <ul>
	                <li><a href="${pageContext.request.contextPath}/main/main.do">Home</a></li>
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
                            <li><a href="${pageContext.request.contextPath}/nboard/faqBoard.do">자주하는질문</a></li>
	                    </ul>
	                </li>
                    <li><a href="#">Member</a>
                    	<ul class="dropdown">
                        	<li><a href="${pageContext.request.contextPath}/member/adminMemberList.do">회원상세</a></li>
                            <li><a href="${pageContext.request.contextPath}/attend/adminMemberList.do">출석체크</a></li>
                            <li><a href="${pageContext.request.contextPath}/point/adminMemberList.do">포인트</a></li>
							<li><a href="${pageContext.request.contextPath}/exercise/exerciseMain.do">운동기록</a></li>
							<li><a href="${pageContext.request.contextPath}/meal/list.do">식사기록</a></li>
							<li><a href="${pageContext.request.contextPath}/inbody/inbodyMain.do">인바디</a></li>
							<li><a href="${pageContext.request.contextPath}/schedule/mylist.do">수강내역</a></li>
							<li><a href="${pageContext.request.contextPath}/qaboard/adminAnswerList.do">문의내역</a></li>
                        </ul>
                    </li>
                    <li><a href="#">Mypage</a>
                    	<ul class="dropdown">
                    		<li><a href="${pageContext.request.contextPath}/member/myPage.do">강사상세</a></li>
		                    <li><a href="${pageContext.request.contextPath}/schedule/list.do">스케줄</a></li>
                    	</ul>
                    </li>
	            </ul>
	        </nav>
	        <div id="mobile-menu-wrap"></div>
	        <div class="canvas-social">
	            <a href="#"><i class="fa fa-facebook"></i></a>
	            <a href="#"><i class="fa fa-twitter"></i></a>
	            <a href="#"><i class="fa fa-youtube-play"></i></a>
	            <a href="#"><i class="fa fa-instagram"></i></a>
	        </div>
	    </div>
    <!-- Offcanvas Menu Section End -->
    </c:if>
    
    <c:if test="${!empty user_num && user_auth == 9}"><!-- 관리자 -->    	                       
	    <div class="offcanvas-menu-overlay"></div>
	    <div class="offcanvas-menu-wrapper">
	        <div class="canvas-close">
	            <i class="fa fa-close"></i>
	        </div>
	        <nav class="canvas-menu mobile-menu">
	            <ul>
	                <li><a href="${pageContext.request.contextPath}/main/main.do">Home</a></li>
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
                            <li><a href="${pageContext.request.contextPath}/nboard/faqBoard.do">자주하는질문</a></li>
	                    </ul>
	                </li>
                    <li><a href="#">Member</a>
                        <ul class="dropdown">
                        	<li><a href="${pageContext.request.contextPath}/member/adminMemberList.do">회원상세</a></li>
                            <li><a href="${pageContext.request.contextPath}/attend/adminMemberList.do">출석체크</a></li>
                            <li><a href="${pageContext.request.contextPath}/point/adminMemberList.do">포인트</a></li>
							<li><a href="${pageContext.request.contextPath}/exercise/exerciseMain.do">운동기록</a></li>
							<li><a href="${pageContext.request.contextPath}/meal/list.do">식사기록</a></li>
							<li><a href="${pageContext.request.contextPath}/inbody/inbodyMain.do">인바디</a></li>
							<li><a href="${pageContext.request.contextPath}/history/adminHistoryList.do">수강내역</a></li>
							<li><a href="${pageContext.request.contextPath}/qaboard/adminAnswerList.do">문의내역</a></li>
                        </ul>
                     <li>					
                     <li><a href="#">Trainer</a>
                        <ul class="dropdown">
                            <li><a href="${pageContext.request.contextPath}/member/adminTrainerList.do">강사상세</a></li>
                            <li><a href="${pageContext.request.contextPath}/schedule/list.do">스케줄</a></li>
                        </ul>
                     <li>	
                     <li><a href="#">Mypage</a>
                        <ul class="dropdown">
		                	<li><a href="${pageContext.request.contextPath}/member/myPage.do">관리자상세</a></li>
		                    <li><a href="${pageContext.request.contextPath}/payment/paymentMemberList.do">회원권등록</a></li>
		                    <li><a href="${pageContext.request.contextPath}/tmenu/tmenuList.do">메뉴등록</a></li>
		                    <li><a href="${pageContext.request.contextPath}/review/adminReportList.do">신고관리</a></li>
                        </ul>
                     <li>	                
	            </ul>
	        </nav>
	        <div id="mobile-menu-wrap"></div>
	        <div class="canvas-social">
	            <a href="#"><i class="fa fa-facebook"></i></a>
	            <a href="#"><i class="fa fa-twitter"></i></a>
	            <a href="#"><i class="fa fa-youtube-play"></i></a>
	            <a href="#"><i class="fa fa-instagram"></i></a>
	        </div>
	    </div>
    <!-- Offcanvas Menu Section End -->
    </c:if>

    