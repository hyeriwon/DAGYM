<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBERSHIP</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('write_form');
	//이벤트 연결
	myForm.onsubmit=function(){
		const title = document.getElementById('qab_title');
		if(title.value.trim()==''){
			alert('제목을 입력하세요');
			title.value = '';
			title.focus();
			return false;
		}
		const contact = document.getElementById('contact');
		if(contact.value.trim()==''){
			alert('연락처를 입력하세요');
			contact.value = '';
			contact.focus();
			return false;
		}
		const content = document.getElementById('qab_content');
		if(content.value.trim()==''){
			alert('내용을 입력하세요');
			content.value = '';
			content.focus();
			return false;
		}
		// 연락처와 내용을 합쳐서 qab_content에 저장
		content.value = '연락처: ' + contact.value + ' \n내용: ' + content.value;
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
                        <h2>Membership</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <span>Membership</span>
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
                    		<span>Membership</span>
                            <h2>회원권 상담신청</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<form id="write_form" action="paymentCounseling.do" method="post">
						<ul>
							<li>
								<label for="qab_type">문의종류</label>
								<span>회원권 상담신청</span>
							</li>
							<li>
								<label for="qab_title">제목</label>
								<input type="text" name="qab_title" id="qab_title" maxlength="50">
							</li>
							<li>
								<label for="contact">연락처</label>
								<input type="text" name="contact" id="contact">
							</li>
							<li>
								<label for="qab_content">내용</label>
								<textarea rows="10" cols="50" name="qab_content" id="qab_content"></textarea>
							</li>
						</ul>
						<br>
						<div class="align-center">
							<input type="submit" value="등록">
							<input type="button" value="취소" onclick="location.href='paymentInfo.do'">
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