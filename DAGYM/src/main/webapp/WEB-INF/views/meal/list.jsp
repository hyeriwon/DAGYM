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
// DOMContentLoaded 이벤트 리스너를 추가하여 DOM이 완전히 로드된 후에 실행됩니다.
document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar'); // 캘린더 요소를 가져옵니다.

  var calendar = new FullCalendar.Calendar(calendarEl, { // FullCalendar 객체를 초기화합니다.
    selectable: true, // 날짜 선택 가능
    height: 'auto', // 캘린더 높이 자동 조절
    width:'auto', // 캘린더 너비 자동 조절
    headerToolbar: { // 캘린더 헤더 설정
      left: 'prev,next today', // 왼쪽에 이전, 다음, 오늘 버튼 배치
      center: 'title', // 중앙에 타이틀 배치
      right: 'dayGridMonth' // 오른쪽에 월별 보기 버튼 배치
    },
    dateClick: function(info) { // 날짜 클릭 이벤트 핸들러
      var selectedDate = info.dateStr; // 클릭한 날짜를 문자열로 가져옵니다.
      window.location.href = '${pageContext.request.contextPath}/meal/mealWriteForm.do?meal_date='+selectedDate; // 클릭한 날짜로 이동합니다.
    }
  });
  calendar.render(); // 캘린더를 렌더링합니다.
});
</script>
</head>
<body>
<div class="page-main">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/><!-- 헤더 JSP 파일을 포함합니다. -->
    <p>
    <jsp:include page="/WEB-INF/views/common/usercontrolHeader.jsp"/><!-- 사용자 제어 헤더 JSP 파일을 포함합니다. -->
    <div class="content-main">
    <div class="align-right">
    <input type="button" value="목록보기" onclick="location.href='${pageContext.request.contextPath}/meal/mealDetail.do'"><!-- 목록보기 버튼 클릭 시 목록 페이지로 이동 -->
    <div><p></div>
    </div>
    <div id="calendar"></div><!-- 캘린더를 표시할 div 요소 -->
    </div>
     
</div>
</body>
</html>
