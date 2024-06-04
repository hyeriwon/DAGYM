<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <title>OUR TEAM</title>
    
    <!-- Google Font & Css Styles -->
    <jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
</head>

<body>
    <!-- Header Section Begin -->
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <!-- Header End -->

    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/breadcrumb-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb-text">
                        <h2>Our Team</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">Class</a>
                            <span>Our team</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Team Section Begin -->
    <section class="team-section team-page spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="team-title">
                        <div class="section-title">
                            <span>Our Team</span>
                            <h2>강사 프로필</h2>
                        </div>
                        <a href="${pageContext.request.contextPath}/history/list.do" class="primary-btn btn-normal appoinment-btn">appointment</a>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-sm-6">
                    <div class="ts-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/team/team-1.jpg">
                        <div class="ts_text">
                            <h4>Athart Rachel</h4>
                            <span>Gym Trainer</span>
                            <div class="tt_social">
                                <a href="#"><i class="fa fa-facebook"></i></a>
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-youtube-play"></i></a>
                                <a href="#"><i class="fa fa-instagram"></i></a>
                                <a href="#"><i class="fa  fa-envelope-o"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="ts-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/team/team-2.jpg">
                        <div class="ts_text">
                            <h4>Athart Rachel</h4>
                            <span>Gym Trainer</span>
                            <div class="tt_social">
                                <a href="#"><i class="fa fa-facebook"></i></a>
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-youtube-play"></i></a>
                                <a href="#"><i class="fa fa-instagram"></i></a>
                                <a href="#"><i class="fa  fa-envelope-o"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="ts-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/team/team-3.jpg">
                        <div class="ts_text">
                            <h4>Athart Rachel</h4>
                            <span>Gym Trainer</span>
                            <div class="tt_social">
                                <a href="#"><i class="fa fa-facebook"></i></a>
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-youtube-play"></i></a>
                                <a href="#"><i class="fa fa-instagram"></i></a>
                                <a href="#"><i class="fa  fa-envelope-o"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="ts-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/team/team-4.jpg">
                        <div class="ts_text">
                            <h4>Athart Rachel</h4>
                            <span>Gym Trainer</span>
                            <div class="tt_social">
                                <a href="#"><i class="fa fa-facebook"></i></a>
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-youtube-play"></i></a>
                                <a href="#"><i class="fa fa-instagram"></i></a>
                                <a href="#"><i class="fa  fa-envelope-o"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="ts-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/team/team-5.jpg">
                        <div class="ts_text">
                            <h4>Athart Rachel</h4>
                            <span>Gym Trainer</span>
                            <div class="tt_social">
                                <a href="#"><i class="fa fa-facebook"></i></a>
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-youtube-play"></i></a>
                                <a href="#"><i class="fa fa-instagram"></i></a>
                                <a href="#"><i class="fa  fa-envelope-o"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="ts-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/team/team-6.jpg">
                        <div class="ts_text">
                            <h4>Athart Rachel</h4>
                            <span>Gym Trainer</span>
                            <div class="tt_social">
                                <a href="#"><i class="fa fa-facebook"></i></a>
                                <a href="#"><i class="fa fa-twitter"></i></a>
                                <a href="#"><i class="fa fa-youtube-play"></i></a>
                                <a href="#"><i class="fa fa-instagram"></i></a>
                                <a href="#"><i class="fa  fa-envelope-o"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Team Section End -->


    <!-- Footer Section Begin -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <!-- Footer Section End -->

	<!-- Js Plugins -->
	<jsp:include page="/WEB-INF/views/common/js_plugins.jsp"/>
	
</body>
</html>