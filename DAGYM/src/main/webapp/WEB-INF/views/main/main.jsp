<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
<head>
    <meta charset="UTF-8">
    <title>DAGYM</title>
    
    <!-- Google Font & Css Styles -->
    <jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
</head>
<body>
    <!-- Header Section Begin -->
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <!-- Header End -->

    <!-- Hero Section Begin -->
    <section class="hero-section">
        <div class="hs-slider owl-carousel">
            <div class="hs-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/hero/hero-1.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6 offset-lg-6">
                            <div class="hi-text">
                                <span>Shape your body</span>
                                <h1>Be <strong>strong</strong> traning hard</h1>
                                <a href="${pageContext.request.contextPath}/main/about.do" class="primary-btn">Get info</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hs-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/hero/hero-2.jpg">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6 offset-lg-6">
                            <div class="hi-text">
                                <span>Shape your body</span>
                                <h1>Be <strong>strong</strong> traning hard</h1>
                                <a href="${pageContext.request.contextPath}/main/about.do" class="primary-btn">Get info</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Hero Section End -->

    <!-- Classes Section Begin -->
    <section class="classes-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <span>Our Classes</span>
                        <h2>프로그램 소개</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="class-item">
                        <div class="ci-pic">
                            <img src="${pageContext.request.contextPath}/resources/img/classes/class-1.jpg" alt="">
                        </div>
                        <div class="ci-text">
                            <span>HEALTH</span>
                            <h5>식단 관리</h5>
                            <a href="#"><i class="fa fa-angle-right"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="class-item">
                        <div class="ci-pic">
                            <img src="${pageContext.request.contextPath}/resources/img/classes/class-2.jpg" alt="">
                        </div>
                        <div class="ci-text">
                            <span>TRAINING</span>
                            <h5>실내 스트레칭</h5>
                            <a href="#"><i class="fa fa-angle-right"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="class-item">
                        <div class="ci-pic">
                            <img src="${pageContext.request.contextPath}/resources/img/classes/class-3.jpg" alt="">
                        </div>
                        <div class="ci-text">
                            <span>STRENGTH</span>
                            <h5>케틀벨 운동</h5>
                            <a href="#"><i class="fa fa-angle-right"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="class-item">
                        <div class="ci-pic">
                            <img src="${pageContext.request.contextPath}/resources/img/classes/class-4.jpg" alt="">
                        </div>
                        <div class="ci-text">
                            <span>STRENGTH</span>
                            <h4>데드리프트</h4>
                            <a href="#"><i class="fa fa-angle-right"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="class-item">
                        <div class="ci-pic">
                            <img src="${pageContext.request.contextPath}/resources/img/blog/details/details-hero.jpg" alt="">
                        </div>
                        <div class="ci-text">
                            <span>HEALTH</span>
                            <h4>메뉴 추천</h4>
                            <a href="#"><i class="fa fa-angle-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ChoseUs Section End -->

    <!-- Banner Section Begin -->
    <section class="banner-section set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/banner-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="bs-text">
                        <h3>지금 등록하고 더 많은 혜택을 받아보세요</h3>
                        <div class="bt-tips">Where health, beauty and fitness meet.</div>
                        <a href="${pageContext.request.contextPath}/payment/paymentCounselingForm.do" class="primary-btn  btn-normal">Membership</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Banner Section End -->

    <!-- Team Section Begin -->
    <section class="team-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="team-title">
                        <div class="section-title">
                            <span>Our Team</span>
                            <h2>강사프로필</h2>
                        </div>
                        <a href="${pageContext.request.contextPath}/history/list.do" class="primary-btn btn-normal appoinment-btn">schedule</a>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="ts-slider owl-carousel">
                    <div class="col-lg-4">
                        <div class="ts-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/team/team-1.jpg">
                            <div class="ts_text">
                                <h4>Athart Rachel</h4>
                                <span>Gym Trainer</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="ts-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/team/team-2.jpg">
                            <div class="ts_text">
                                <h4>Athart Rachel</h4>
                                <span>Gym Trainer</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="ts-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/team/team-3.jpg">
                            <div class="ts_text">
                                <h4>Athart Rachel</h4>
                                <span>Gym Trainer</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="ts-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/team/team-4.jpg">
                            <div class="ts_text">
                                <h4>Athart Rachel</h4>
                                <span>Gym Trainer</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="ts-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/team/team-5.jpg">
                            <div class="ts_text">
                                <h4>Athart Rachel</h4>
                                <span>Gym Trainer</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="ts-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/team/team-6.jpg">
                            <div class="ts_text">
                                <h4>Athart Rachel</h4>
                                <span>Gym Trainer</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Team Section End -->

    <!-- Gallery Section Begin -->
    <div class="gallery-section">
        <div class="gallery">
            <div class="grid-sizer"></div>
            <div class="gs-item grid-wide set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/gallery/gallery-1.jpg">
                <a href="${pageContext.request.contextPath}/resources/img/gallery/gallery-1.jpg" class="thumb-icon image-popup"><i class="fa fa-picture-o"></i></a>
            </div>
            <div class="gs-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/gallery/gallery-2.jpg">
                <a href="${pageContext.request.contextPath}/resources/img/gallery/gallery-2.jpg" class="thumb-icon image-popup"><i class="fa fa-picture-o"></i></a>
            </div>
            <div class="gs-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/gallery/gallery-3.jpg">
                <a href="${pageContext.request.contextPath}/resources/img/gallery/gallery-3.jpg" class="thumb-icon image-popup"><i class="fa fa-picture-o"></i></a>
            </div>
            <div class="gs-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/gallery/gallery-4.jpg">
                <a href="${pageContext.request.contextPath}/resources/img/gallery/gallery-4.jpg" class="thumb-icon image-popup"><i class="fa fa-picture-o"></i></a>
            </div>
            <div class="gs-item set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/gallery/gallery-5.jpg">
                <a href="${pageContext.request.contextPath}/resources/img/gallery/gallery-5.jpg" class="thumb-icon image-popup"><i class="fa fa-picture-o"></i></a>
            </div>
            <div class="gs-item grid-wide set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/gallery/gallery-6.jpg">
                <a href="${pageContext.request.contextPath}/resources/img/gallery/gallery-6.jpg" class="thumb-icon image-popup"><i class="fa fa-picture-o"></i></a>
            </div>
        </div>
    </div>
    <!-- Gallery Section End -->

    <!-- Footer Section Begin -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <!-- Footer Section End -->

	<!-- Js Plugins -->
	<jsp:include page="/WEB-INF/views/common/js_plugins.jsp"/>
	
</body>
</html>