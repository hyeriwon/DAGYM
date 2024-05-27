<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출석체크 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/index.global.min.js"></script>
<script>

	document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	
		var calendar = new FullCalendar.Calendar(calendarEl, {
	    		headerToolbar: {
		        left: 'prev,next today',
		        center: 'title',
		        right: 'dayGridMonth,timeGridWeek,timeGridDay'
	    		},
			initialDate: new Date().toISOString().slice(0, 10), // 오늘 날짜로 설정
			navLinks: true, // can click day/week names to navigate views
			selectable: true,
			selectMirror: true,
			select: function(arg) {
				// 오늘 날짜	
				var today = new Date();
		        var selectedDate = arg.start;
		
		     	// 정확한 날짜 비교를 위해 시간을 00:00:00으로 설정
		        today.setHours(0, 0, 0, 0);
		        selectedDate.setHours(0, 0, 0, 0);
		
		        if (selectedDate.getTime() === today.getTime()) {
		        		if (confirm('출석하시겠습니까?')) {
		                // (출석등록) 선택한 날짜를 write.do로 리다이렉트
		                location.href = 'write.do?date=' + arg.start.toISOString();
	                }
				} else {// 오늘 날짜만 선택 가능
		            alert('오늘 날짜만 선택할 수 있습니다.');
				}
		        calendar.unselect()
			},
			eventClick: function(arg) {
		    		if (confirm('출석을 취소하시겠습니까?')) {
		    			// (출석삭제) events의 title에서 att_num 가져와서 delete.do로 리다이렉트
		    			var att_num = arg.event.title;
		    			location.href = 'delete.do?att_num=' + att_num;
		        }
			},
			editable: true,
			dayMaxEvents: true, // allow "more" link when too many events
			events: [
				// (출석목록) DB에서 list형식으로 가져오기
		    		<c:forEach var="attend" items="${list}">
		    		{
		        		title: '${attend.att_num}',
		            start: '${attend.att_date}'
		     	}
		    		<c:if test="${!attend_last}">,</c:if>
		        </c:forEach>
			],
			eventDidMount: function(info) {
				// 이벤트 타이틀 숨기기
				var titleElement = info.el.querySelector('.fc-event-title');
				if (titleElement) {
					titleElement.style.display = 'none';
				}
				// 이벤트를 동그라미로 표시
				info.el.style.backgroundColor = 'transparent';
				info.el.style.border = 'none';
				info.el.innerHTML = '<div class="event-circle"></div>';
				// 동그라미를 가운데로 정렬
				info.el.style.display = 'flex';
				info.el.style.alignItems = 'center';
				info.el.style.justifyContent = 'center';
			}
	    });
	
	    calendar.render();
	});

</script>
<style>

	#calendar {
		margin: 40px 10px;
	    padding: 0;
	    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	    font-size: 14px;
	    max-width: 1100px;
	    margin: 0 auto;
	}
	/* 수직 스크롤바 숨기기 */
	.fc-scroller::-webkit-scrollbar {
	    display: none;
	}
	.fc-scroller {
	    -ms-overflow-style: none;  /* IE and Edge */
	    scrollbar-width: none;  /* Firefox */
	}
	/* 이벤트 동그라미 스타일 */
	.event-circle {
	    width: 25px;
	    height: 25px;
	    background-color: #3788d8; /* 이벤트 색상 */
	    border-radius: 50%;
	    margin: 0 auto;
	}

</style>
</head>
<body>

	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="content-main">
			<br>
			<div id="calendar"></div>
			<br>
			<h3>이번 달 출석일수 : ${attendCount}일</h3>
		</div>
	</div>

</body>
</html>