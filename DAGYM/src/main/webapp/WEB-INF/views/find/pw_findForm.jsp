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
			if(items[i].id == 'id' && !/^(?=.*[a-zA-Z])(?=.*[0-9]).{6,12}$/.test($('#id').val())){
				alert('아이디는 영문, 숫자 혼합하여 6~12자 사이로 입력하세요');
				$('#id').val('').focus();
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
                            <span>Find</span>
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
                    		<span>PW FIND</span>
                            <h2>비밀번호 찾기</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<form id="find_form" action="pwFind.do" method="post">
						<ul>
							<li>
								<label for="name">이름</label>
								<input type="text" name="name" id="name" maxlength="10" class="input-check">
							</li>
							<li>
								<label for="id">아이디</label>
								<input type="text" name="id" id="id" maxlength="12" autocomplete="off" class="input-check">
								<div class="form-notice">* 영문 숫자 혼합(6자~12자)</div>
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
							<a href="${pageContext.request.contextPath}/find/idFindForm.do">아이디 찾기</a>
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