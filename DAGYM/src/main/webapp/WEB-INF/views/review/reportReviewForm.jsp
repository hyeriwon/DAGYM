<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>REVIEW</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<script type="text/javascript">
window.onload = function(){
	let report = document.getElementById('reportForm');
	report.onsubmit = function(){
		const content = document.getElementById('content');
		if(content.value.trim()==''){
			alert('신고 사유 필수 입력!');
			content.value = '';
			content.focus();
			return false; 
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
                        <h2>Review</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">About</a>
                            <span>Review</span>
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
                    		<span>Review</span>
                            <h2>후기신고</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<form id="reportForm" action="reportReview.do" method="post">
						<input type="hidden" name="rev_num" value="${rev_num}">
						<input type="hidden" name="mem_num" value="${user_num}">
						<h4>신고사유</h4>
						<div class="align-center">
							<ul>
								<li>
									<textarea rows="5" cols="50" name="report_content" id="content" placeholder="신고할 내용을 입력해주세요."></textarea>
								</li>
							</ul>		
							<br>
							<input type="submit" value="신고">
							<input type="button" value="취소" onclick="history.go(-1)">
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