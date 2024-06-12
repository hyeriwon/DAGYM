<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>recommendMenu</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
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
                        <h2>Home</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
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
                    		<span>Home</span>
                            <h2>오늘의 추천 메뉴</h2>
                    	</div>
                 </div>
             </div>
          </div>
    </div>
	<br><br>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-4 col-md-8">
                     <div class= "align-center"><h4>오늘의 아침</h4></div>
                     <br>
                     <div class="image-box">
                    <a href="${pageContext.request.contextPath}/tmenu/tmenuDetail.do?tme_num=${breakfast.tme_num}">
                       <img class="menu-image2"  src="${pageContext.request.contextPath}/upload/${breakfast.tme_photo}">
                    </a>
                    <br><br>
                    	<div class= "align-center"><b>${breakfast.tme_name}</b></div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-8">
					<div class= "align-center"><h4>오늘의 점심</h4></div>
					<br>
					<div class="image-box">
                         <a href="${pageContext.request.contextPath}/tmenu/tmenuDetail.do?tme_num=${lunch.tme_num}">
                       <img class="menu-image2" src="${pageContext.request.contextPath}/upload/${lunch.tme_photo}">
                    </a>
					</div>
					<br>
					<div class= "align-center"><b>${lunch.tme_name}</b></div>
                </div>
                <div class="col-lg-4 col-md-8">
                    	<div class= "align-center"><h4>오늘의 저녁</h4></div>
                    	<br>
                    	<div class="image-box">
                    	 <a href="${pageContext.request.contextPath}/tmenu/tmenuDetail.do?tme_num=${dinner.tme_num}">
                       <img class="menu-image2" src="${pageContext.request.contextPath}/upload/${dinner.tme_photo}">
                    </a>
                    </div>
                    <br>
                    	<div class= "align-center"><b>${dinner.tme_name}</b></div>
                </div>
				<div class="align-center">
					<br>
					<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
				</div>
            </div>
        </div>
    </section>
	  
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<jsp:include page="/WEB-INF/views/common/js_plugins.jsp"/>

</body>
</html>