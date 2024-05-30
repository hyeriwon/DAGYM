<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강후기 수정</title>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<form id="updateForm" action="updateReview.do" method="post" enctype="multipart/form-data">
			<ul>
				<li>
					<label for="title">후기 제목</label>
					<input type="text" name="rev_title" id="title" 
							maxlength="20" class="input-check" value="${review.rev_title}">
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
					<textarea cols="50" rows="5" id="content" name="rev_content" class="input-check">${review.rev_content}</textarea>
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="수정">
				<input type="button" value="목록" onclick="location.href='listReview.do'">
			</div>
		</form>
	</div>
</div>
</body>
</html>