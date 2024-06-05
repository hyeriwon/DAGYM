<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <title>ABOUT US</title>
    
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
                        <h2>About us</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <span>About</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- ChoseUs Section Begin -->
    <section class="choseus-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <span>Why chose us?</span>
                        <h2>PUSH YOUR LIMITS FORWARD</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3 col-sm-6">
                    <div class="cs-item">
                        <span class="flaticon-034-stationary-bike"></span>
                        <h4>Modern equipment</h4>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                            dolore facilisis.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="cs-item">
                        <span class="flaticon-033-juice"></span>
                        <h4>Healthy nutrition plan</h4>
                        <p>Quis ipsum suspendisse ultrices gravida. Risus commodo viverra maecenas accumsan lacus vel
                            facilisis.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="cs-item">
                        <span class="flaticon-002-dumbell"></span>
                        <h4>Proffesponal training plan</h4>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                            dolore facilisis.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-sm-6">
                    <div class="cs-item">
                        <span class="flaticon-014-heart-beat"></span>
                        <h4>Unique to your needs</h4>
                        <p>Quis ipsum suspendisse ultrices gravida. Risus commodo viverra maecenas accumsan lacus vel
                            facilisis.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ChoseUs Section End -->

    <!-- About US Section Begin -->
    <section class="aboutus-section">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-6 p-0">
                    <div class="about-video set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/about-us.jpg">
                        <a href="https://www.youtube.com/watch?v=nFYwcndNuOY" class="play-btn video-popup"><i
                                class="fa fa-caret-right"></i></a>
                    </div>
                </div>
                <div class="col-lg-6 p-0">
                    <div class="about-text">
                        <div class="section-title">
                            <span>About Us</span>
                            <h2>What we have done</h2>
                        </div>
                        <div class="at-desc">
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt
                                ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices gravida. Risus commodo
                                viverra maecenas accumsan lacus vel facilisis. aliquip ex ea commodo consequat sit amet,
                                consectetur adipiscing elit, sed do eiusmod tempor.</p>
                        </div>
                        <div class="about-bar">
                            <div class="ab-item">
                                <p>Body building</p>
                                <div id="bar1" class="barfiller">
                                    <span class="fill" data-percentage="80"></span>
                                    <div class="tipWrap">
                                        <span class="tip"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="ab-item">
                                <p>Training</p>
                                <div id="bar2" class="barfiller">
                                    <span class="fill" data-percentage="85"></span>
                                    <div class="tipWrap">
                                        <span class="tip"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="ab-item">
                                <p>Fitness</p>
                                <div id="bar3" class="barfiller">
                                    <span class="fill" data-percentage="75"></span>
                                    <div class="tipWrap">
                                        <span class="tip"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- About US Section End -->

    <!-- Testimonial Section Begin -->
    <section class="testimonial-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <span>Testimonial</span>
                        <h2>Our cilent say</h2>
                    </div>
                </div>
            </div>
            <div class="ts_slider owl-carousel">
                <div class="ts_item">
                    <div class="row">
                        <div class="col-lg-12 text-center">
                            <div class="ti_pic">
                                <img src="${pageContext.request.contextPath}/resources/img/testimonial/testimonial-1.jpg" alt="">
                            </div>
                            <div class="ti_text">
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                                    incididunt<br /> ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices
                                    gravida. Risus commodo<br /> viverra maecenas accumsan lacus vel facilisis.</p>
                                <h5>Marshmello Gomez</h5>
                                <div class="tt-rating">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="ts_item">
                    <div class="row">
                        <div class="col-lg-12 text-center">
                            <div class="ti_pic">
                                <img src="${pageContext.request.contextPath}/resources/img/testimonial/testimonial-2.jpg" alt="">
                            </div>
                            <div class="ti_text">
                                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
                                    incididunt<br /> ut labore et dolore magna aliqua. Quis ipsum suspendisse ultrices
                                    gravida. Risus commodo<br /> viverra maecenas accumsan lacus vel facilisis.</p>
                                <h5>Marshmello Gomez</h5>
                                <div class="tt-rating">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <br><br>
        <div class="container">
            <div class="map">
                <iframe
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d791.3414890413405!2d127.032555728512!3d37.49928606222652!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca1c32408f9b7%3A0x4e3761a4f356d1eb!2z7IyN7Jqp6rWQ7Jyh7IS87YSw!5e0!3m2!1sko!2skr!4v1717566091159!5m2!1sko!2skr"
                    height="550" style="border:0;" allowfullscreen=""></iframe>
            </div>
        </div>
    </section>
    <!-- Testimonial Section End -->

    <!-- Footer Section Begin -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <!-- Footer Section End -->

	<!-- Js Plugins -->
	<jsp:include page="/WEB-INF/views/common/js_plugins.jsp"/>
	
</body>
</html>