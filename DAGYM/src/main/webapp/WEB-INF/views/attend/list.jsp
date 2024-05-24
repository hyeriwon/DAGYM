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
      initialDate: '2024-05-24',
      navLinks: true, // can click day/week names to navigate views
      selectable: true,
      selectMirror: true,
      select: function(arg) {
//        var title = prompt('출석 체크:');
//        if (title) {
//          calendar.addEvent({
//            title: title,
//            start: arg.start,
//            end: arg.end,
//            allDay: arg.allDay
//          })
//        }

//        if (title && confirm('출석을 확인하시겠습니까?')) {
//            // 선택한 날짜를 writeForm.jsp로 리다이렉트합니다.
//            location.href = 'writeForm.do?date=' + arg.start.toISOString();
//        }

        if (confirm('출석하시겠습니까?')) {
            // 선택한 날짜를 writeForm.jsp로 리다이렉트합니다.
            location.href = 'writeForm.do?date=' + arg.start.toISOString();
        }
        calendar.unselect()
      },
      eventClick: function(arg) {
        if (confirm('출석을 취소하시겠습니까?')) {
          arg.event.remove()
        }
      },
      editable: true,
      dayMaxEvents: true, // allow "more" link when too many events
      events: [
        {
          title: '출석체크1',
          start: '2024-05-24'
        },
        {
          title: '출석체크2',
          start: '2024-05-25',
        },
        {
          groupId: 999,
          title: 'Repeating Event',
          start: '2024-05-09T16:00:00'
        },
        {
          title: 'Conference',
          start: '2024-05-13',
          end: '2024-05-16'
        }
      ]
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

</style>
</head>
<body>

	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<div class="content-main">

			<br>
			<c:if test="${count == 0}">
				<div class="result-display">
					표시할 게시물이 없습니다.
				</div>
			</c:if>
			<c:if test="${count > 0}">
				<!-- 목록 출력 시작 -->
				<table>
					<tr>
						<th>출석번호</th>
						<th>출석일자</th>
						<th>출석삭제</th>
					</tr>
					<c:forEach var="attend" items="${list}">
					<tr>
						<td>${attend.att_num}</td>
						<td>${attend.att_date}</td>
						<td><input type="button" value="삭제" onclick=""></td>
					</tr>
					</c:forEach>
				</table>
				<!-- 목록 출력 끝 -->
			</c:if>	
			<br>
			
			<div id="calendar"></div>
		</div>
	</div>

</body>
</html>