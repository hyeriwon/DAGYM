<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PT 신청 목록</title>
<style>
    #fc-dom-1 {
        margin-right: 100px;
    }
    .fc-event {
        cursor: pointer;
    }
    .completed-event {
        background-color: #32CD32; /* 진한 연두색 */
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
                    title: '${formattedTime}시 (${schedule.mem_id})',
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
            if (info.event.extendedProps.his_status == '1') {
                info.el.classList.add('completed-event');
            }
            // 기존 eventDidMount 내용 유지
        },
        eventMouseEnter: function(info) {
            // 기존 eventMouseEnter 내용 유지
        },
        eventMouseLeave: function(info) {
            // 기존 eventMouseLeave 내용 유지
        },
        eventClick: function(info) {
            if (info.event.extendedProps.his_status == '1') {
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/review/writeReviewsForm.do';
                form.style.display = 'none';
                
                // 스케줄 번호를 전달
                var schNumInput = document.createElement('input');
                schNumInput.type = 'hidden';
                schNumInput.name = 'sch_num';
                schNumInput.value = info.event.extendedProps.sch_num;
                form.appendChild(schNumInput);
                
                document.body.appendChild(form);
                form.submit();
            } else {
                // 기존 eventClick 내용 유지
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
        <h2 align="center">PT 신청 목록</h2>
        
        <div class="align-right">
         <input type="button" value="PT등록" onclick="location.href='list.do'">
        </div>

        <div id="his_calendar"></div>
       
        <input type="hidden" value="" name="date" id="date" maxlength="30">
        
    </div>
</div>
</body>
</html>
