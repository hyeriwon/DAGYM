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
function searchByMemNum() {
	  var client_num = document.getElementById('client_num').value;
	  window.location.href = '${pageContext.request.contextPath}/meal/mealDetail.do?client_num='+client_num;
	}
</script>
</head>
<body>
<div class="page-main">
    <jsp:include page="/WEB-INF/views/common/header.jsp"/><!-- 헤더 JSP 파일을 포함합니다. -->
    <p>
    <jsp:include page="/WEB-INF/views/common/usercontrolHeader.jsp"/><!-- 사용자 제어 헤더 JSP 파일을 포함합니다. -->
    <div class="content-main">
    <div class="align-left">
    
    </div>
    <div class="align-right">
    <c:if test="${user_auth !=9}">
    <input type="button" value="목록보기" id ="search_client"onclick="location.href='${pageContext.request.contextPath}/meal/mealDetail.do'"><!-- 목록보기 버튼 클릭 시 목록 페이지로 이동 -->
    </c:if>
    <c:if test="${user_auth ==9 }">
    <label for="client_num"></label>
     <input type="text"  id="client_num" value="회원번호검색" 
     onfocus="if(this.value=='회원번호검색') this.value='';" onblur="if(this.value=='') this.value='회원번호검색';">
     <input type="submit" value="검색" onclick="searchByMemNum()"><!-- 목록보기 버튼 클릭 시 목록 페이지로 이동 -->
    </c:if>
    <div><p></div>
    </div>
    <c:if test="${user_auth !=9}">
    <div id="calendar"></div><!-- 캘린더를 표시할 div 요소 -->
    </c:if>
    <c:if test="${user_auth ==9}">
    <table>
			<tr>
				<th>회원번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>담당트레이너</th>
				<th>가입일</th>
			</tr>
			<c:forEach var="member" items="${list}">
			<tr>
				<td>${member.mem_num}</td>
				<td>${member.mem_id}</td>
				<td>${member.mem_name}</td>
				<td><%-- 담당트레이너 데이터 --%></td>
				<td>${member.mem_reg_date}</td>
			</tr>
			</c:forEach>
		</table>
    </c:if>
    </div>
     
</div>
</body>
</html>
