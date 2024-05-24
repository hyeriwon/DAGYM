<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PT 신청</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/index.global.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('his_calendar');

  var calendar = new FullCalendar.Calendar(calendarEl, {
    selectable: true,
    headerToolbar: {
      left: 'prev,next today',
      center: 'title',
      right: 'dayGridMonth,timeGridWeek,timeGridDay'
    },
    dateClick: function(info) {
        var dateStr = info.dateStr; //클릭한 날짜 정보
        // 수강신청 폼으로 리다이렉션
        window.location.href = 'enrollForm.do?date=' + dateStr;
    }
 });

  calendar.render();
});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
	<div class="content-main">
		<h2>수강신청</h2>
		<div id="his_calendar"></div>
	</div>
</div>
</body>
</html>