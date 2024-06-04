<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>INBODY</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
window.onload = function(){
	const myForm = document.getElementById('write_form');
	myForm.onsubmit = function(){
		const items = document.querySelectorAll('input[type="number"]');
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
	//인바디 사진 미리보기
	let photo_path = $('.my-photo').attr('src');
	$('#inb_photo').change(function(){
		let photo = this.files[0];
		//선택된 사진이 없을 때 마지막으로 수정된 이미지로 되돌리기
		if(!photo){
			$('.my-photo').attr('src',photo_path);
		}
		const reader = new FileReader();
		reader.readAsDataURL(photo);
		reader.onload = function(){
			$('.my-photo').attr('src',reader.result);
		};
	});
	
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
                        <h2>Inbody</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">MyPage</a>
                            <span>Inbody</span>
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
                    		<span>Inbody</span>
                            <h2>인바디 등록</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->	
					<form id="write_form" action="inbodyWrite.do" method="post" enctype= "multipart/form-data">
					<input type="hidden" id="inb_date" name="inb_date" value="${param.inb_date}">
					<ul>
						<li>
							<label for="inb_hei">키(cm)</label>
							<input type="number" id="inb_hei" name="inb_hei">
						</li>
						<li>
							<label for="inb_wei">몸무게(kg)</label>
							<input type="number" id="inb_wei" name="inb_wei">
						</li>
						<li>
							<label for="inb_mus">골격근량(kg)</label>
							<input type="number" id="inb_mus" name="inb_mus">
						</li>
						<li>
								<label for="inb_photo">인바디 사진</label>
								<input type="file" name="inb_photo" id="inb_photo" accept="image/gif,image/png,image/jpeg"><br>
								<c:if test="${empty inbody.inb_photo}">
									<img src="${pageContext.request.contextPath}/images/face.png" width="200" height="200" class="my-photo">
								</c:if>
								<c:if test="${!empty inbody.inb_photo}">
									<img src="${pageContext.request.contextPath}/upload/${inbody.inb_photo}" width="200" height="200" class="my-photo">
								</c:if>				
							</li>
						<li>
						<div class="align-center">
						<input type="submit" value="등록">
						<input type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}/inbody/inbodyList.do'">
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