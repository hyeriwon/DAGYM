<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MYPAGE</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<script type="text/javascript">
window.onload = function(){
	const deleteForm = document.getElementById('delete_form');
	deleteForm.onsubmit = function(){
		const items = document.querySelectorAll('.input-check');	
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim()==''){
				const label = document.querySelector('label[for="'+items[i].id+'"]');
				alert(label.textContent+' 항목 필수 입력!');
				items[i].value = '';
				items[i].focus();
				return false;
			}
		}
	};	
};
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
                        <h2>Mypage</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <span>Mypage</span>
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
                    		<span>Mypage</span>
                            <h2>회원탈퇴</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<form action="deleteUser.do" method="post" id="delete_form">
						<ul>
							<li>
								<label for="id">아이디</label>
								<input type="text" autocomplete="off" maxlength="12" id="id" name="mem_id" class="input-check">
							</li>
							<li>
								<label for="pw">비밀번호</label>
								<input type="password" autocomplete="off" maxlength="12" id="pw" name="mem_pw" class="input-check">
							</li>
						</ul>
						<br>
						<div class="align-center">
							<input type="submit" value="탈퇴하기">
							<input type="button" value="취소" onclick="location.href='myPage.do'">
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