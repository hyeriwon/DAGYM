<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SCHEDULE</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet"	href="${pageContext.request.contextPath}/css/LJY.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/index.global.min.js"></script>
<script>
//redirectMain 변수가 true일 때만 alert를 표시하고 메인 페이지로 이동
<c:if test="${requestScope.redirectMain == true}">
    alert("${error}");
    window.location.href = "${pageContext.request.contextPath}/main/main.do";
</c:if>

document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('his_calendar');

    // 현재 로그인한 사용자의 ID를 JavaScript 변수에 저장
    var currentUserId = '${sessionScope.user_id}';

    var calendar = new FullCalendar.Calendar(calendarEl, {
        selectable: true,
        width: 'auto',
        height: 'auto',
        headerToolbar: {
            left: 'prev,next',
            center: 'title',
            right: 'today'
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
                        sch_status: '${schedule.sch_status}'
                    }
                },
            </c:forEach>
        ],
        eventDidMount: function(info) {
            // sch_status가 1인 경우 배경색을 빨간색으로 설정하고 커서를 기본 화살표로 설정
            if (info.event.extendedProps.sch_status === '1') {
                info.el.style.backgroundColor = 'red';
                info.el.style.color = 'white'; // 글자 색상을 흰색으로 설정
                info.el.style.cursor = 'default'; // 커서를 기본 화살표로 설정
            } else {
                // 마우스를 올리면 포인터로 변경
                info.el.style.cursor = 'pointer';
            }
            
            // 테두리 없애기
            info.el.style.border = 'none';
        },
        eventMouseEnter: function(info) {
            // sch_status가 1이 아닌 경우에만 이벤트가 커지는 효과를 적용
            if (info.event.extendedProps.sch_status !== '1') {
                info.el.style.transform = 'scale(1.1)';
                info.el.style.transition = 'transform 0.2s';
            }
        },
        eventMouseLeave: function(info) {
            // sch_status가 1이 아닌 경우에만 원래 크기로 돌아가도록 적용
            if (info.event.extendedProps.sch_status !== '1') {
                info.el.style.transform = 'scale(1)';
            }
        },
        
        eventClick: function(info) {
            // sch_status가 1인 경우 클릭 이벤트를 무시
            if (info.event.extendedProps.sch_status === '1') {
                return;
            }
            
            var today = new Date();
            var eventDate = new Date(info.event.startStr);
            
            // 클릭된 이벤트 날짜가 오늘 이전인지 확인
            if (eventDate <= today.setDate(today.getDate() - 1)) {
                alert('오늘 이후로 PT 신청할 수 있습니다.');
                return;
            }

            var sch_time = parseInt(info.event.extendedProps.sch_time);
            var tra_name = info.event.extendedProps.mem_id;
            var sch_num = info.event.extendedProps.sch_num;
            var tra_num = info.event.extendedProps.mem_num;

            // 폼 생성
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/history/historyEnrollForm.do?sch_date=' + info.event.startStr + '&sch_time=' + sch_time + '&tra_name=' + tra_name;
            form.style.display = 'none'; // 폼을 보이지 않게 설정
            
            // 스케줄 번호를 전달
            var schNumInput = document.createElement('input');
            schNumInput.type = 'hidden';
            schNumInput.name = 'sch_num';
            schNumInput.value = sch_num;
            form.appendChild(schNumInput);
            
            // 트레이너 번호를 전달
            var traNumInput = document.createElement('input');
            traNumInput.type = 'hidden';
            traNumInput.name = 'tra_num';
            traNumInput.value = tra_num;
            form.appendChild(traNumInput);

            // 폼을 body에 추가하고 제출
            document.body.appendChild(form);
            form.submit();
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
                        <h2>Schedule</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">Class</a>
                            <span>Schedule</span>
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
                    		<span>Schedule</span>
                            <h2>스케줄</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="class-timetable">
					
					<!-- content 시작 -->
					<div class="align-right">
			        	<input type="button" value="수강내역" onclick="location.href='${pageContext.request.contextPath}/history/mylist.do'">
			        </div>
			        <div id="his_calendar"></div>
			        <input type="hidden" value="" name="date" id="date" maxlength="30">
					<br>
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
