<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NOTICE</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<script type="text/javascript">
window.onload = function() {
	const myForm = document.getElementById('write_form');
    const nbo_type = document.getElementById('nbo_type');
    const nbo_title = document.getElementById('nbo_title');
    
    //게시글 종류 변경 시 제목 필드 업데이트
    nbo_type.onchange = function() {
        const prefix = "[" + nbo_type.value + "] ";
        if (!nbo_title.value.startsWith(prefix)) {
            nbo_title.value = prefix;
        }
    };
    
	//이벤트 연결
	myForm.onsubmit=function(){
		const nbo_title = document.getElementById('nbo_title');
		if(nbo_title.value.trim()==''){
			alert('제목을 입력하세요');
			nbo_title.value = '';
			nbo_title.focus();
			return false;
		}
		const content = document.getElementById('nbo_content');
		if(nbo_content.value.trim()==''){
			alert('내용을 입력하세요');
			nbo_content.value = '';
			nbo_content.focus();
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
                        <h2>Notice</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">C/S</a>
                            <span>Notice</span>
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
	                    		<span>Notice</span>
	                            <h2>공지작성</h2>
	                    	</div>
	                 </div>
	             </div>
	          </div>
	          	<div class="row">
					<div class="col-lg-12">    
						<div class="chart-table">
						
						<!-- content 시작 -->
						<form id="write_form" action="nboardWrite.do" method="post" enctype="multipart/form-data">
							<ul>
								<li>
									<label for="nbo_type">게시글 종류</label>
									<select name="nbo_type" id="nbo_type">
										<option value="" selected disabled>--선택--</option>
										<option value="공지">공지</option>
										<option value="이벤트">이벤트</option>
										<option value="기타">기타</option>
									</select>
								</li>
								<li>
									<label for="nbo_title">제목</label>
									<input type="text" name="nbo_title" id="nbo_title" maxlength="50">
								</li>
								<li>
									<label for="nbo_content">내용</label>
									<textarea rows="5" cols="40" name="nbo_content" id="nbo_content"></textarea>
								</li>
								<li>
									<label for="nbo_filename">이미지</label>
									<input type="file" name="nbo_filename" id="nbo_filename" accept="image/gif,image/png,image/jpeg">
								</li>
							</ul>
							<br>
							<div class="align-center">
								<input type="submit" value="등록">
								<input type="button" value="목록" onclick="location.href='nboardList.do'">
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