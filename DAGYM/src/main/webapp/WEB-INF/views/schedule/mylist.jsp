<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PT 수강 내역</title>
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
                        his_status: '${schedule.his_status}',
                        his_part : '${schedule.his_part}',
                        his_num : '${schedule.his_num}',
                        mem_num_history: '${schedule.mem_num}' // history의 mem_num도 가져오기 위해 추가
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
            if (info.event.extendedProps.his_status == '2') {
                // 완료된 PT 일정일 경우 후기 등록으로 이동
                var redirectUrl = '${pageContext.request.contextPath}/review/writeReviewForm.do?sch_num=' + encodeURIComponent(info.event.extendedProps.sch_num);
                window.location.href = redirectUrl;
            } else if (info.event.extendedProps.sch_status == '1') {
                // 진행 중인 PT 일정일 경우 일정 완료 폼으로 이동
                var sch_time = parseInt(info.event.extendedProps.sch_time);
                var mem_name = info.event.extendedProps.mem_id;
                var sch_num = info.event.extendedProps.sch_num;
                var mem_num = info.event.extendedProps.mem_num;
                var his_part = info.event.extendedProps.his_part;
                var his_num = info.event.extendedProps.his_num;
                var mem_num_history = info.event.extendedProps.mem_num_history; // history의 mem_num 값 가져오기

                // 폼 생성
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/schedule/scheduleCompleteForm.do?sch_date=' + info.event.startStr + '&sch_time=' + sch_time + '&mem_name=' + mem_name + '&his_part=' + his_part;
                form.style.display = 'none'; // 폼을 보이지 않게 설정
                
                // 스케줄 번호를 전달
                var schNumInput = document.createElement('input');
                schNumInput.type = 'hidden';
                schNumInput.name = 'sch_num';
                schNumInput.value = sch_num;
                form.appendChild(schNumInput);
                
                // 트레이너 번호(tra_num)를 전달
                var memNumInput = document.createElement('input');
                memNumInput.type = 'hidden';
                memNumInput.name = 'mem_num';
                memNumInput.value = mem_num;
                form.appendChild(memNumInput);

                // 운동 부위를 전달
                var hisPartInput = document.createElement('input');
                hisPartInput.type = 'hidden';
                hisPartInput.name = 'his_part';
                hisPartInput.value = his_part;
                form.appendChild(hisPartInput);
                
             	// 히스토리 번호를 전달
                var hisNumInput = document.createElement('input');
                hisNumInput.type = 'hidden';
                hisNumInput.name = 'his_num';
                hisNumInput.value = his_num;
                form.appendChild(hisNumInput);

                // 스케줄을 등록한 회원 번호(mem_num)을 전달
                var memNumHistoryInput = document.createElement('input');
                memNumHistoryInput.type = 'hidden';
                memNumHistoryInput.name = 'mem_num_history';
                memNumHistoryInput.value = mem_num_history;
                form.appendChild(memNumHistoryInput);

                // 폼을 body에 추가하고 제출
                document.body.appendChild(form);
                form.submit();
            } else if (info.event.extendedProps.his_status == '0' && info.event.extendedProps.sch_status == '0') {
                // 수강 예정인 PT 일정일 경우 PT 일정 취소
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
