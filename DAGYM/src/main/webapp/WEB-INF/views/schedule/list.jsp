<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스케줄 목록</title>
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/index.global.min.js"></script>
<script>

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('sch_calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
        selectable: true,
        width: 'auto',
        height: 'auto',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        initialView: 'dayGridMonth',
        events: [
            <c:forEach var="schedule" items="${schedules}">
                {
                    title: '${schedule.sch_time}' + '시',
                    start: '${schedule.sch_date}', // schDate는 데이터베이스에서 가져온 날짜 필드의 이름입니다.
                    allDay: true
                },
            </c:forEach>
        ],
        dateClick: function(info) {
            var dateStr = info.dateStr;
            var url = '${pageContext.request.contextPath}/schedule/scheduleEnrollForm.do?sch_date=' + dateStr;
            window.location.href = url;
        }
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
