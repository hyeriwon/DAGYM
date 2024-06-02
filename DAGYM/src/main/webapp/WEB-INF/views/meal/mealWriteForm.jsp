<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEAL</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('write_form');
	myForm.onsubmit=function(){
		const title = document.getElementById('menu_name');
		if(title.value.trim()==''){
			alert('메뉴를 입력하세요');
			return false;
		}
		const radio = document.querySelectorAll('input[type="radio"]:checked');
		if(radio.length<1){
			alert('식사분류를 선택하세요!');
			return false;
		}
	
	}
	
	const modal = document.querySelector("#modal");
	const btn = document.querySelector("#modal-btn");
	const close = document.querySelector(".close");
	const search = document.querySelector("#search_btn");

	// 모달창 열기
	btn.onclick = function() {
	  modal.style.display = "block";
	}

	// 모달창 닫기
	close.onclick = function() {
	  modal.style.display = "none";
	}
	
	search.onclick = function(){
		$.ajax({
			url:'SearchTmenu.do',
			type:'post',
			data: {tmenu_name:$('#tmenu_name').val()}, // 데이터를 객체로 전달
			dataType:'json',
			success:function(param){
				let tableContent ='<tr><th>메뉴</th><th>칼로리</th>선택<th></th></tr>';
				$(param.tmenuList).each(function(index,item){
					tableContent += '<tr><td>'+item.tme_name+'</td>';
					tableContent +='<td>'+item.tme_kcal+'</td><td><button type="button" onclick="selectMenu(\''+item.tme_name+'\')">선택</button></td></tr>';
				});
				$('#table_menu').html(tableContent);
			},	
			error:function(){
				alert('메뉴검색중 오류 발생');
			}
		});
	}
}

// 메뉴 선택 시 처리 함수
function selectMenu(tme_name) {
	$('#menu_name').val(tme_name);
	$('#modal').hide();
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
                        <h2>Meal</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">Mypage</a>
                            <span>Meal</span>
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
                    		<span>Meal</span>
                            <h2>식사등록</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<form id="write_form" action="mealWrite.do" method="post">
						<input type="hidden" id="meal_date" name="meal_date" value="${param.meal_date}">
						<h3>${param.meal_date}</h3>
						<ul>
							<li><label for="menu_name">메뉴 검색</label>
							
							<input type="text" name="menu_name" id="menu_name" value="${menu_name}"  readonly>
							<input type="button" id="modal-btn" value="검색">
							</li>
							
							<li><label for="menu_type">식사분류</label>
							<input type="radio" name="meal_time" value="0" id="meal_time0">아침 
							<input type="radio" name="meal_time" value="1" id="meal_time1">점심 
							<input type="radio" name="meal_time" value="2" id="meal_time2">저녁 
							<input type="radio" name="meal_time" value="3" id="meal_time3">간식
							</li>
						</ul>
						<div class="align-center">
							<input type="submit" value="등록"> <input type="button" value="취소" onclick="location.href='list.do'">
						</div>
					</form>
					<div id="modal" class="dialog">
						<div class="tb">
							<div class="inner" style="max-width:600px;">
								<div class="top">
									<div class="title">메뉴검색</div>
									<a href="#" class="close">닫기</a>
								</div>
								<div class="ct">
									<div align="right">
										<input type="text" size="16" name="tmenu_name" id="tmenu_name" >
										<input type="button" id="search_btn" value="검색">
									</div>
									<table id="table_menu">
										<tr>
											<th>메뉴</th>
											<th>칼로리</th>
											<th>선택</th>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
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
