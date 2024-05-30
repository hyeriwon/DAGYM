<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PT예약</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
		<div class="content-main">
			<div class="align-center">
				<h2>PT예약</h2>
				<form action="${pageContext.request.contextPath}/history/historyEnroll.do"	method="post">
					<input type="hidden" name="his_date" value="${his_date}">
					<h2>선택한 날짜: ${his_date}</h2>					
					
							
				</form>
			</div>


				<form action="${pageContext.request.contextPath}/history/historyEnroll.do"	method="post">
					<input type="hidden" name="his_time" value="${his_time}">
					<ul>
						<li>
							<label for="sch_date">선택한 시간 : </label> 
							<input type="text" name="his_time" id="his_time" value="${his_time}" readonly>
						</li>
						<li>
							<label for="tra_name">트레이너 : </label>
							 <input	type="text" name="tra_name" id="tra_name" value="${schedule.tra_id}">
						 </li>
						<li>
						<label for="his_part">운동 부위(희망) : </label> 
							<select	name="his_part">
									<option>어깨</option>
									<option>가슴</option>
									<option>등</option>
									<option>하체</option>
									<option>유산소</option>
							</select>
						</li>
						

						<li><label for="">잔여 PT : </label> 
						<input type="text" name="" value="" readonly></li>
						</ul>

					<div class="align-center">
						<input type="submit" value="수강 신청"> <input type="button"
							value="취소" onclick="location.href='list.do'">
					</div>
				</form>
			</div>
	</div>
</body>
</html>