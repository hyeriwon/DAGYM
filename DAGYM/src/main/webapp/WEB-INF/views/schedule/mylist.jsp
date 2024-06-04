<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PT 수강 내역</title>
<style>
    .fc-event {
        cursor: pointer;
    }
    .completed-event {
        background-color: #32CD32; /* 진한 연두색 */
        color: white;
        border: none; /* 테두리 제거 */
    }
    .pending-event {
        background-color: #CC9966;
        color: white;
        border: none; /* 테두리 제거 */
    }
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/LJY.css" type="text/css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/index.global.min.js"></script>
<script>

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('his_calendar');

    // 현재 로그인한 사용자의 ID를 JavaScript 변수에 저장
    var currentUserId = '${sessionScope.user_id}';

    var calendar = new FullCalendar.Calendar(calendarEl, {
        selectable: true,
        width: 'auto',
        height: 'auto',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth'
        },
        initialView: 'dayGridMonth',
        events: [
            <c:forEach var="schedule" items="${schedules}">
                <c:set var="formattedTime">
                    <fmt:formatNumber value="${schedule.sch_time}" pattern="00"/>
                </c:set>
                {
                    title: '${formattedTime}시 (<c:choose><c:when test="${schedule.mem_id == null}">대기중</c:when><c:otherwise>${schedule.mem_id}</c:otherwise></c:choose>)',
                    start: '${schedule.sch_date}',
                    allDay: true,
                    extendedProps: {
                        mem_id: '${schedule.mem_id}',
                        sch_num: '${schedule.sch_num}',
                        sch_time: '${schedule.sch_time}',
                        mem_num: '${schedule.mem_num}',
                        sch_status: '${schedule.sch_status}',
                        his_status: '${schedule.his_status}' // 추가된 부분
                    }
                },
            </c:forEach>
        ],
        eventDidMount: function(info) {
            if (info.event.extendedProps.his_status == '2') {
                info.el.classList.add('completed-event');
            }
            if (info.event.extendedProps.sch_status == 0) {
                info.el.classList.add('pending-event');
            }
        },
        eventMouseEnter: function(info) {
            if (info.event.extendedProps.his_status) {
                info.el.style.cursor = 'pointer';
                info.el.style.transform = 'scale(1.1)';
                info.el.style.transition = 'transform 0.2s';
            }
        },
        eventMouseLeave: function(info) {
            if (info.event.extendedProps.his_status) {
                info.el.style.transform = 'scale(1)';
            }
        },
        eventClick: function(info) {
            // 완료된 PT 일정일 경우 후기 등록으로 이동
            if (info.event.extendedProps.his_status == '2') {
                var redirectUrl = '${pageContext.request.contextPath}/review/writeReviewForm.do?sch_num=' + encodeURIComponent(info.event.extendedProps.sch_num);
                window.location.href = redirectUrl;
            }
            
            // 수강 예정인 PT 일정일 경우 PT 일정 취소
            if (info.event.extendedProps.his_status == '0') {
                if (confirm('선택하신 일정을 취소하시겠습니까?')) {
                    var schNum = info.event.extendedProps.sch_num;
                    location.href = 'scheduleDeleteForm.do?sch_num=' + schNum;
                }
            }
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
        <h2 align="center">PT 수강 내역</h2>
        
        <div class="align-right">
            <input type="button" value="스케줄 등록" onclick="location.href='list.do'">
        </div>

        <div id="his_calendar"></div>
       
        <input type="hidden" value="" name="date" id="date" maxlength="30">
        
    </div>
</div>
</body>
</html>
