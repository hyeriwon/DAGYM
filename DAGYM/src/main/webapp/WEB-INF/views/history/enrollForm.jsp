<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
    <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
    <div class="content-main">
        <h2>수강신청</h2>
        <form action="enroll.do" method="post">
        <ul>
			<li>
           	<label for="sch_num">수강 날짜 : </label>
			<input type="text" name="sch_num" id="sch_num" value="${mapAjax.schdule.sch_date}" readonly>
			</li>
			<li>
			<label for="tra_num">트레이너 번호 : </label>
			<input type="text" name="tra_num" id="tra_num" value="${mapAjax.schedule.mem_num}" readonly>
			</li>
			<li>
			<label for="his_part">운동 부위 : </label>
			<select name="his_part">
				<option>어깨</option>
				<option>가슴</option>
				<option>등</option>
				<option>하체</option>
			</select>
			</li>
			<li>
			<label for="mem_num">회원번호 : </label>
            <input type="text" name="mem_num" value="${sessionScope.usernum}">
			</li>
			<%-- 남은 회원권 계산하는 메서드 만들기 --%>
			<%-- 
			<li>
			<label for="">남은 회원권 : </label>
            <input type="text" name="" value="${}" readonly> 
			</li>
			--%>
			<li>
			<label for="sch_date">시간 선택 : </label>
			<input type="radio" name="sch_date" > <!-- value에 시간 -->
			</li>
			</ul>
			<div>
			<input type="submit" value="수강 신청">
			<input type="button" value="취소" onclick="location.href='historyList.do'">
			</div> 
        </form>
    </div>
</div>
</body>
</html>