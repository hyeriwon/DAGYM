<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강후기 작성하기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SYJ.css" type="text/css">
<script type="text/javascript">
window.onload = function(){
	const myForm = document.getElementById('writeForm');
	
	myForm.onsubmit = function(){
		const items = document.querySelectorAll('.input-check');
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim()==''){
				const label = document.querySelector('label[for="'+items[i].id+'"]');
				alert(label.textContent+' 항목 필수 입력');
				items[i].value = '';
				items[i].focus();
				return false;
			}
		}
		
		//별점 유효성 체크
		const radio = document.querySelectorAll('input[type="radio"]:checked');
		if(radio.length<1){
			alert('별점을 선택하세요!');
			return false;
		}
	};
	const gradeInput = document.querySelectorAll('.star-rating input');
	const gradeScore = document.getElementById('grade');
	
	for(let i=0;i<gradeInput.length;i++){
      gradeInput[i].onclick = function(){
		gradeScore.textContent = '(' + this.value + '점을 선택했습니다.)';
	  };
  	}
};
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<h2>수강후기 작성</h2>
	<div class="content-main">
		<form id="writeForm" action="writeReview.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="mem_num" value="${history.mem_num}">
			<ul>
				<li>
					<label for="title">후기 제목</label>
					<input type="text" name="rev_title" id="title" maxlength="20" class="input-check">
				</li>
				<li>
					<label for="reg_date">진행 날짜</label>${history.sch_date}
					<input type="hidden" name="sch_num" value="${history.sch_num}">
				</li>
				<li>
					<label>트레이너</label>${trainer.mem_name}
					<input type="hidden" name="tra_num" value="${history.tra_num}">
				</li>
				<li>
					<label for="star">별점</label> 
					<div class="star-rating" id="star">
						<input type="radio" name="rev_grade" value="5" id="star5"><label for="star5">★</label>
						<input type="radio" name="rev_grade" value="4" id="star4"><label for="star4">★</label>
						<input type="radio" name="rev_grade" value="3" id="star3"><label for="star3">★</label>
						<input type="radio" name="rev_grade" value="2" id="star2"><label for="star2">★</label>
						<input type="radio" name="rev_grade" value="1" id="star1"><label for="star1">★</label>					
					</div>
					<span id="grade"></span>	
				</li>
				<li>
					<label for="filename1">파일(Before)</label>
					<input type="file" name="rev_filename1" id="filename1" accept="image/gif,image/png,image/jpeg">
				</li>
				<li>
					<label for="filename2">파일(After)</label>
					<input type="file" name="rev_filename2" id="filename2" accept="image/gif,image/png,image/jpeg">
				</li>
				<li>
				    <label for="content">수강후기</label><br><br>
					<textarea cols="50" rows="5" id="content" name="rev_content" class="input-check"></textarea>
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="등록">
				<input type="button" value="목록" onclick="location.href='listReview.do'">
			</div>
		</form>
	</div>
</div>
</body>
</html>