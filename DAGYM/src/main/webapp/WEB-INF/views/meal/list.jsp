<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음식 목록</title>
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/index.global.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new FullCalendar.Calendar(calendarEl, {
    selectable: true,
    height: 'auto',
    width:'auto',
    headerToolbar: {
      left: 'prev,next today',
      center: 'title',
      right: 'dayGridMonth'
    },
    dateClick: function(info) {
    	 var selectedDate = info.dateStr;
         window.location.href = '${pageContext.request.contextPath}/meal/mealWriteForm.do?meal_date='+selectedDate;
       }
  });
  calendar.render();
});
</script>
</head>
<body>
<div class="page-main">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <p>
    <jsp:include page="/WEB-INF/views/common/usercontrolHeader.jsp"/>
    <div class="content-main">
    <div class="align-right">
    <input type="button" value="목록보기" onclick="location.href='${pageContext.request.contextPath}/meal/mealDetail.do'">
    <div><p></div>
    </div>
    <div id="calendar"></div>
    </div>
     
</div>
</body>
</html>
