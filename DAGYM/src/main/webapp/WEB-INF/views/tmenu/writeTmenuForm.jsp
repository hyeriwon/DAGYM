<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MENU</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">	
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('write_form');
	myForm.onsubmit=function(){
		const items = document.querySelectorAll('.input-check');
		for (let i = 0; i < items.length; i++) {
			if (items[i].value.trim() == '') {
				const label = document.querySelector('label[for="'+ items[i].id + '"]');
					alert(label.textContent + '항목은 필수 입력');
					items[i].value = '';
					items[i].focus();
					return false;
					}
		}
		const content = document.getElementById('menu_content');
		if(content.value.trim()==''){
			alert('내용을 입력하세요');
			content.value = '';
			content.focus();
			return false;
		}
	}
}
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
                        <h2>Menu</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">Mypage</a>
                            <span>Menu</span>
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
                    		<span>Menu</span>
                            <h2>메뉴등록</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<form id="write_form" action="tmenuWrite.do" method="post"  enctype="multipart/form-data">
						<ul>
							<li>
								<label for="menu_name">메뉴 이름</label>
								<input type="text" name="menu_name" id="menu_name" class="input-check">
							</li>
							<li>
								<label for="filename">메뉴 사진</label>
								<input type="file" name="filename" id="filename" class="input-check"  accept="image/gif,image/png,image/jpeg">
							</li>
							<li>
								<label for="menu_kcal">칼로리(Kcal)</label>
								<input type="number" name="menu_kcal" id="menu_kcal" class="input-check">
							</li>
							<li>
								<label for="menu_crabs">탄수화물(g)</label>
								<input type="number" name="menu_crabs" id="menu_crabs" class="input-check">
							</li>
							<li>
								<label for="menu_protein">단백질(g)</label>
								<input type="number" name="menu_protein" id="menu_protein" class="input-check">
							</li>
							<li>
								<label for="menu_lipid">지방(g)</label>
								<input type="number" name="menu_lipid" id="menu_lipid" class="input-check">
							</li>
							<li><label for="menu_type">식사분류 </label>
								<input type="radio" name="tme_type" value="0" id="tme_type0" checked>아침 
								<input type="radio" name="tme_type" value="1" id="tme_type1">점심 
								<input type="radio" name="tme_type" value="2" id="tme_type2">저녁 
								<input type="radio" name="tme_type" value="3" id="tme_type3">간식
								<input type="radio" name="tme_type" value="4" id="tme_type4">검색용메뉴
							</li>
							<li>
								<label for="menu_content">메뉴 설명</label>
								<textarea rows="5" cols="40" name="menu_content" id="menu_content" maxlength="1300"></textarea>
							</li>
						</ul>
						<div class="align-center">
							<input type="submit" value="등록"> <input type="button" value="목록" onclick="location.href='tmenuList.do'">
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
