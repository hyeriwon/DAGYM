<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PT 목록</title>
<style>
    #fc-dom-1 {
        margin-right: 100px;
    }
</style>
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
                {
                    title: '${schedule.sch_time}시 (${schedule.mem_id})',
                    start: '${schedule.sch_date}',
                    allDay: true,
                    extendedProps: {
                        mem_id: '${schedule.mem_id}',
                        sch_num: '${schedule.sch_num}'
                    }
                },
            </c:forEach>
        ],
        eventDidMount: function(info) {
            /* // 등록한 사람의 ID와 현재 사용자의 ID가 다르면 배경색을 빨간색으로 설정
            if (info.event.extendedProps.mem_id !== currentUserId) {
                info.el.style.backgroundColor = 'red';
            } */
            // 테두리 없애기
            info.el.style.border = 'none';
            
        	// 마우스를 올리면 포인터로 변경
            info.el.style.cursor = 'pointer';
        },
        eventMouseEnter: function(info) {
            // 이벤트가 커지는 효과를 위해 크기를 증가시킵니다.
            info.el.style.transform = 'scale(1.1)';
            info.el.style.transition = 'transform 0.2s';
        },
        eventMouseLeave: function(info) {
            // 마우스가 이벤트에서 벗어나면 다시 원래 크기로 돌아갑니다.
            info.el.style.transform = 'scale(1)';
        },
        dateClick: function(info) {
            var today = new Date();
            var clickedDate = new Date(info.dateStr);
            
            // 클릭된 날짜가 오늘 이전인지 확인
            if (clickedDate <= today.setDate(today.getDate() - 1)) {
                alert('오늘 이후로 PT 신청할 수 있습니다.');
                window.location.reload();
            }
        },
        eventClick: function(info) {
            // 이벤트 클릭하여 PT 신청 폼으로 이동
            var url = '${pageContext.request.contextPath}/history/historyEnrollForm.do?his_date=' + info.event.startStr;
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
        <h2 align="center">PT 등록</h2>

        <div id="his_calendar"></div>

        <input type="hidden" value="" name="date" id="date" maxlength="30">
    </div>
</div>
</body>
</html>
