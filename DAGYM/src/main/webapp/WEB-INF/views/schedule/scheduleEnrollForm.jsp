<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/index.global.min.js"></script>
<script>

document.addEventListener('DOMContentLoaded', function() {
	  var calendarEl = document.getElementById('sch_calendar');

	  var calendar = new FullCalendar.Calendar(calendarEl, {
	    selectable: true,
	    headerToolbar: {
	      left: 'prev,next today',
	      center: 'title',
	      right: 'dayGridMonth,timeGridWeek,timeGridDay'
	    },
	    dateClick: function(info) {
	    	var dateStr = info.dateStr;
	    	var confirmation = confirm(dateStr + '\n선택하신 날짜로 스케줄 등록?');
	    	  if (confirmation) {
	    	    // 확인 버튼이 눌렸을 때 실행될 코드
	    	    document.getElementById('date').value = dateStr;
	    	    alert('등록 완료!'); // 예를 들어, 콘솔에 'Confirmed!'를 출력하거나,
	    	    
	    	  } else {
	    	    // 취소 버튼이 눌렸을 때 실행될 코드
	    	    alert('등록 취소!'); // 예를 들어, 콘솔에 'Cancelled!'를 출력하거나,
	    	  }
	  
	      
	      
	    },
	    /* select: function(info) {
	      confirm('selected ' + info.startStr + ' to ' + info.endStr);
	    } */
	  });

	  calendar.render();
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
	<h2 align="center">스케줄 등록</h2>
	
	<div id="sch_calendar"></div>
		
	<input type="hidden" value="" name="date" id="date" maxlength="30">
					
		
	
	</div>
</div>
</body>
</html>