<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HISTORY</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet"	href="${pageContext.request.contextPath}/css/LJY.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/index.global.min.js"></script>
<script>

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('his_calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
        timeZone: 'UTC',
        initialView: 'listWeek',
        views: {
            listDay: { buttonText: 'list day' },
            listWeek: { buttonText: 'list week' },
            listMonth: { buttonText: 'list month' }
        },
        headerToolbar: {
            left: 'title',
            center: '',
            right: 'listDay,listWeek,listMonth'
        },
        eventTimeFormat: { // 시간 형식을 설정
            hour: '2-digit',
            minute: '2-digit',
            hour12: false
        },
        events: [
            <c:forEach var="schedule" items="${schedules}">
                <c:set var="formattedTime">
                    <fmt:formatNumber value="${schedule.sch_time}" pattern="00"/>
                </c:set>
                {
                    title: '트레이너: ${schedule.trainerId} / 회원: ${schedule.memberId}',
                    start: '${schedule.sch_date}T${formattedTime}:00:00',
                    allDay: false,
                    extendedProps: {
                        trainerId: '${schedule.trainerId}',
                        sch_num: '${schedule.sch_num}',
                        sch_time: '${schedule.sch_time}',
                        mem_num: '${schedule.mem_num}',
                        sch_status: '${schedule.sch_status}',
                        his_status: '${schedule.his_status}',
                        his_part : '${schedule.his_part}',
                        his_num : '${schedule.his_num}',
                        memberId: '${schedule.memberId}',
                        mem_num_history: '${schedule.mem_num}' // history의 mem_num도 가져오기 위해 추가

                    }
                },
            </c:forEach>
        ],
        
        eventDidMount: function(info) {
            if (info.event.extendedProps.his_status == '2') {
             	// 도트 색상 변경
	        	var dotEl = info.el.getElementsByClassName('fc-list-event-dot')[0];
		        if (dotEl) {
		            dotEl.style.setProperty('--fc-event-border-color', '#32CD32');
		        }
            } else if(info.event.extendedProps.memberId == '') {
            	// 도트 색상 변경
	        	var dotEl2 = info.el.getElementsByClassName('fc-list-event-dot')[0];
		        if (dotEl2) {
		            dotEl2.style.setProperty('--fc-event-border-color', '#CC9966');
		        }
            }
        },
        eventMouseEnter: function(info) {
            if (info.event.extendedProps.his_status) {
                info.el.style.cursor = 'pointer';
                info.el.style.transform = 'scale(1.1)';
                info.el.style.transition = 'transform 0.2s';
                info.el.style.color = 'black';
            }
        },
        eventMouseLeave: function(info) {
            if (info.event.extendedProps.his_status) {
                info.el.style.transform = 'scale(1)';
                info.el.style.color = '';
            }
        },
        eventClick: function(info) {
            // 완료된 PT 일정일 경우 후기 등록으로 이동
            if (info.event.extendedProps.his_status == '2') {
                var redirectUrl = '${pageContext.request.contextPath}/review/writeReviewForm.do?sch_num=' + encodeURIComponent(info.event.extendedProps.sch_num);
                window.location.href = redirectUrl;
            }
            
            // 수강 예정인 PT 일정일 경우 PT 완료 처리 및 일정 취소로 이동
            if (info.event.extendedProps.sch_status == '1') {
                // 진행 중인 PT 일정일 경우 일정 완료 폼으로 이동
                var sch_time = parseInt(info.event.extendedProps.sch_time);
                var mem_name = info.event.extendedProps.mem_id;
                var sch_num = info.event.extendedProps.sch_num;
                var mem_num = info.event.extendedProps.mem_num;
                var his_part = info.event.extendedProps.his_part;
                var his_num = info.event.extendedProps.his_num;
                var mem_num_history = info.event.extendedProps.mem_num_history; // history의 mem_num 값 가져오기
                var trainerId = info.event.extendedProps.trainerId;
                var memberId = info.event.extendedProps.memberId;

                // 날짜 부분만 추출
                var sch_date = info.event.startStr.split('T')[0];

                // 폼 생성
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/schedule/adminScheduleCompleteForm.do?sch_date=' + encodeURIComponent(sch_date) 
                    + '&sch_time=' + encodeURIComponent(sch_time) 
                    + '&his_part=' + encodeURIComponent(his_part) 
                    + '&trainer_id=' + encodeURIComponent(trainerId) 
                    + '&member_id=' + encodeURIComponent(memberId)
                    + '&mem_num_history=' + encodeURIComponent(mem_num_history);
                
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
            }
            
            // 수강 예정인 PT 일정일 경우 PT 일정 취소
            if (info.event.extendedProps.sch_status == '0') {
                if (confirm('선택하신 스케줄을 취소하시겠습니까?')) {
                    var schNum = info.event.extendedProps.sch_num;
                    location.href = '${pageContext.request.contextPath}/schedule/adminScheduleDeleteForm.do?sch_num=' + schNum;
                }
            }
        }
    });

    calendar.render();
});
</script>
</head>
<body>

    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    
    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/breadcrumb-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb-text">
                        <h2>History</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">Mypage</a>
                            <span>History</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

 <section class="team-section team-page spad">
      <div class="container">
          <div class="row">
             <div class="col-lg-12">
                <div class="team-title">
                        <div class="section-title">
                            <span>History</span>
                            <h2>수강내역(관리자)</h2>
                        </div>
                 </div>
             </div>
          </div>
            <div class="row">
                <div class="col-lg-12">    
                    <div class="class-timetable">
                    
                    <!-- content 시작 -->
                    <!-- <div class="align-right">
                        <input type="button" value="PT신청" onclick="location.href='list.do'">
                    </div> -->
                    <div id="his_calendar"></div>
                    <input type="hidden" value="" name="date" id="date" maxlength="30">
                    <!-- content 끝 -->
                    
                    </div>
                </div>
            </div>
          </div>
      </section>
      
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    <jsp:include page="/WEB-INF/views/common/js_plugins.jsp"/>
    
</body>
</html>
