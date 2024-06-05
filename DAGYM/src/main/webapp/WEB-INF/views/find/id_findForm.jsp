<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FIND</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
	//회원 정보 등록 유효성 체크
	$('#find_form').submit(function(){
		const items = document.querySelectorAll('.input-check');
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim()==''){
				const label = document.querySelector('label[for="'+items[i].id+'"]');
				alert(label.textContent + ' 항목은 필수 입력');
				items[i].value = '';
				items[i].focus();
				return false;
			}
			
			if(items[i].id == 'phone' && !/^\d{3}-\d{4}-\d{4}$/.test($('#phone').val())){
				alert('전화번호는 000-0000-0000 형식으로 입력');
				$('#phone').val('').focus();
				return false;
			}
		}
	});
});//end of function
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
                        <h2>FIND</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <span>find</span>
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
                    		<span>IDFIND</span>
                            <h2>아이디 찾기</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<form id="find_form" action="idFind.do" method="post">
						<ul>
							<li>
								<label for="name">이름</label>
								<input type="text" name="name" id="name" maxlength="10" class="input-check">
							</li>
							<li>
								<label for="phone">전화번호</label>
								<input type="text" name="phone" id="phone" maxlength="13" class="input-check">
								<div class="form-notice">* 000-0000-0000 형식으로 입력</div>
							</li>
							<li>
								<label for="email">이메일</label>
								<input type="email" name="email" id="email" maxlength="50" class="input-check">
							</li>
						</ul>
						<br>
						<div class="align-center">
							<input type="submit" value="확인">
							<input type="button" value="취소" onclick="history.go(-1)">
							<br><br>
							<a href="${pageContext.request.contextPath}/member/registerUserForm.do">회원가입 | </a>
							<a href="${pageContext.request.contextPath}/find/pwFindForm.do">비밀번호 찾기</a>
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