<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EXERCISE</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
window.onload = function(){
	const myForm = document.getElementById('write_form');
	myForm.onsubmit = function(){
		const items = document.querySelectorAll('input[type="number"], input[type="text"]');
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim()== ''){
			const label = document.querySelector('label[for="'+items[i].id+'"]');
			alert(label.textContent + '항목은 필수 입력');
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
                        <h2>Exercise</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">MyPage</a>
                            <span>Exercise</span>
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
                    		<span>Exercise</span>
                            <h2>운동내역 등록</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->	
					<form id="write_form" action="exerciseWrite.do" method="post" enctype= "multipart/form-data">
					<input type="hidden" id="exe_date" name="exe_date" value="${param.exe_date}">
					<ul>
						<li>
							<label for="exe_type">운동 타입</label>
							<input type="text" id="exe_type" name="exe_type">
						</li>
						<li>
							<label for="exe_content">운동내역(상세)</label>
							<input type="text" id="exe_content" name="exe_content">
						</li>
						<li>
							<label for="exe_time">운동시간(분)</label>
							<input type="number" id="exe_time" name="exe_time">
						</li>
						
						<li>
						<div class="align-center">
						<input type="submit" value="등록">
						<input type="button" value="취소" onclick="${pageContext.request.contextPath}/exercise/exerciseList.do">
						</div>
						</li>
					</ul>
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