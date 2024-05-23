<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css' rel='stylesheet' />
<script src="${pageContext.request.contextPath}/js/index.global.min.js"></script>
<script>
      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth',
          dateClick: function(info) {
              var title = prompt('Enter event title:');
              if (title) {
                  calendar.addEvent({
                      title: title,	
                      start: info.dateStr,
                      allDay: true
                  });
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
	<div id="calendar"></div>
	<input type="button" value="음식기록 등록" onclick="location.href='mealWriteForm.do'">
	</div>
</div>
</body>
</html>