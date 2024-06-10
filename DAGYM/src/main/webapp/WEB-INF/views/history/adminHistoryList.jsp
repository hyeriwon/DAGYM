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
                        memberId: '${schedule.memberId}'
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
            if (info.event.extendedProps.sch_status == '1') {
                if (confirm('선택하신 PT 일정을 취소하시겠습니까?')) {
                    var schNum = info.event.extendedProps.sch_num;
                    location.href = 'adminHistoryDeleteForm.do?sch_num=' + schNum;
                }
            }
            
         // 수강 예정인 PT 일정일 경우 PT 일정 취소
            if (info.event.extendedProps.sch_status == '0') {
                if (confirm('선택하신 스케줄을 취소하시겠습니까?')) {
                    var schNum = info.event.extendedProps.sch_num;
                    location.href = 'adminScheduleDeleteForm.do?sch_num=' + schNum;
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
