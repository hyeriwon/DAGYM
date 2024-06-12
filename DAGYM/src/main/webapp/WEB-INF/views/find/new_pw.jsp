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
	let emailCheck = 1;
	//유효성 체크
	$('#modify_form').submit(function(){
		
		const items = document.querySelectorAll('.input-check');
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim() == ''){
				const label = document.querySelector('label[for="'+items[i].id+'"]');
				alert(label.textContent+' 항목 필수 입력!');
				items[i].value = '';
				items[i].focus();
				return false;
			}
		}
		//새 비밀번호와 새 비밀번호 확인 일치 여부(폼 전송시)
		if($('#newPw').val() != $('#newCpw').val()){
			alert('새 비밀번호와 새 비밀번호 확인이 불일치합니다.');
			$('#newPw').val('').focus();
			$('#newCpw').val('');
			return false;
		}
		//새 비밀번호 자리수 체크
		if($('#newPw').val() != '' && !/^(?=.*[0-9])(?=.*[a-zA-Z]).{8,12}$/.test($('#newPw').val())){
			alert('비밀번호는 숫자와 영문을 혼용하여 8~12자리로 작성해주세요.');
			$('#newPw').val('').focus();
			$('#newCpw').val('');
			$('#check-msg').text('');
			return false;
		}
	});
	//새 비밀번호와 새 비밀번호 확인 일치 여부
	$('#newCpw').keyup(function(){
		if($('#newPw').val() == $('#newCpw').val()){
			$('#check-msg').text('새 비밀번호와 새 비밀번호 확인이 일치합니다.').css('color','yellow');
		}else{
			$('#check-msg').text('');
		}		
	});
	
	//새 비밀번호 확인까지 한 후 다시 새 비밀번호를 수정하려고 하면 새 비밀번호 확인을 초기화
	$('#newPw').keyup(function(){
		$('#newCpw').val('');
		$('#check-msg').text('');
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
                    		<span>PWFIND</span>
                            <h2>새로운 비밀번호 설정</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<form id="modify_form" action="newPw.do" method="post">
						<input type="hidden" name="mem_id" value="${mem_id}">
						<ul>
							<li>
								<label>새 비밀번호</label>
								<input type="password" maxlength="12" name="mem_newPw" id="newPw" maxlength="12">
							</li>
							<li>
								<label>새 비밀번호 확인</label>
								<input type="password" id="newCpw" maxlength="12"><br>
								<span id="check-msg" style="padding:10px 0 0 130px;"></span>
							</li>
						</ul>
						<br>
						<div class="align-center">
							<input type="submit" value="새로운 비밀번호 설정">
							<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
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