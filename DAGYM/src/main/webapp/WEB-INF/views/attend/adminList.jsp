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
		        left: 'prev,next',
		        center: 'title',
		        right: 'dayGridMonth'
	    		},
			initialDate: new Date().toISOString().slice(0, 10), //오늘 날짜로 설정
			navLinks: true, //can click day/week names to navigate views
			selectable: false, //관리자 모드에서는 선택 비활성화
			selectMirror: false,
			eventClick: function(arg) {
				//출석 취소 비활성화
			},
			editable: false,
			dayMaxEvents: true, //allow "more" link when too many events
			events: [
				<c:forEach var="attend" items="${list}">
				{
					title: '${attend.att_num}',
					start: '${attend.att_date}'
				}
				<c:if test="${!attend_last}">,</c:if>
				</c:forEach>
			],
			eventDidMount: function(info) {
				var titleElement = info.el.querySelector('.fc-event-title');
				if (titleElement) {
					titleElement.style.display = 'none';
				}
				info.el.style.backgroundColor = 'transparent';
				info.el.style.border = 'none';
				info.el.innerHTML = '<div class="event-circle"></div>';
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
	.fc-scroller::-webkit-scrollbar {
	    display: none;
	}
	.fc-scroller {
	    -ms-overflow-style: none;
	    scrollbar-width: none;
	}
	.event-circle {
	    width: 25px;
	    height: 25px;
	    background-color: #3788d8;
	    border-radius: 50%;
	    margin: 0 auto;
	}
</style>
</head>
<body>

	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="content-main">
			<h2 style="text-align: left;">출석체크</h2>
			<%
				String month = (String)request.getAttribute("month");
				String[] parts = month.split("-");
				String monthString = parts[1];
			%>
			<h3 style="text-align: right;"><%=monthString%>월 출석일수 : ${attendCount}일</h3>
			<div id="calendar"></div>
			<br>
		</div>
	</div>

</body>
</html>