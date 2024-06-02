<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGIN</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#login_form').submit(function(){
		if($('#id').val().trim()==''){
			alert('아이디를 입력하세요').
			$('#id').val('').focus();
			return false;
		}
		if($('#passwd').val().trim()==''){
			alert('비밀번호를 입력하세요').
			$('#passwd').val('').focus();
			return false;
		}
	});
});
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
                        <h2>Login</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <span>Login</span>
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
                    		<span>Login</span>
                            <h2>로그인</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<form id="login_form" action="login.do" method="post">
						<ul>
							<li class="floating-label">
								<label for="id">아이디</label>
								<input type="text" class="form-input" placeholder="아이디" name="id" id="id" maxlength="12" autocomplete="off">
							</li>
							<li class="floating-label">
								<label for="passwd">비밀번호</label>
								<input type="password" class="form-input" placeholder="비밀번호" name="passwd" id="passwd" maxlength="12">
							</li>
						</ul>
						<br>
						<div class="align-center">
							<input type="submit" value="로그인">
							<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
							<br><br>
							<a href="${pageContext.request.contextPath}/member/registerUserForm.do">회원가입</a>
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