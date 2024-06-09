<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EXERCISE</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
<script src="${pageContext.request.contextPath}/js/index.global.min.js"></script>
<script>
	// DOMContentLoaded 이벤트 리스너를 추가하여 DOM이 완전히 로드된 후에 실행됩니다.
	document.addEventListener('DOMContentLoaded', function() {
	  var calendarEl = document.getElementById('calendar'); // 캘린더 요소를 가져옵니다.
	
	  var calendar = new FullCalendar.Calendar(calendarEl, { // FullCalendar 객체를 초기화합니다.
	    selectable: true, // 날짜 선택 가능
	    height: 'auto', // 캘린더 높이 자동 조절
	    width: 'auto', // 캘린더 너비 자동 조절
	    headerToolbar: { // 캘린더 헤더 설정
	      left: 'prev,next', // 왼쪽에 이전, 다음, 오늘 버튼 배치
	      center: 'title', // 중앙에 타이틀 배치
	      right: 'today' // 오른쪽에 월별 보기 버튼 배치
	    },
	    dateClick: function(info) {
	      var today = new Date();
	      var clickedDate = new Date(info.dateStr);

	      // 클릭된 날짜가 오늘 이전인지 확인
	      if (clickedDate >= today.setDate(today.getDate())) {
	          alert('오늘 이후의 운동기록를 등록할 수 없습니다.');
	          window.location.reload();
	      } else {
	        var selectedDate = info.dateStr; // 클릭한 날짜를 문자열로 가져옵니다.
	        window.location.href = '${pageContext.request.contextPath}/exercise/exerciseWriteForm.do?exe_date=' + selectedDate; // 클릭한 날짜로 이동합니다.
	      }
	    }
	  });
	  calendar.render(); // 캘린더를 렌더링합니다.
	});
	window.onload = function() {
		const myForm = document.getElementById('search_form');
		// 이벤트 연결
		myForm.onsubmit = function() {
			const keyword = document.getElementById('keyword');
			if (keyword.value.trim() == '') { // 아무것도 입력하지 않은 경우
				alert('검색어를 입력하세요');
				keyword.value = '';
				keyword.focus();
				return false;
			}
		};
	};
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
                        <h2>Exercise</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">
	                            <c:if test="${user_auth == 2}">MyPage</c:if>
	                            <c:if test="${user_auth >= 8}">Member</c:if>
                            </a>
                            <span>Exercise</span>
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
                    		<span>Exercise</span>
                            <h2> <c:if test="${user_auth == 2}">운동등록</c:if></h2>
                            <h2> <c:if test="${user_auth >= 8}">회원목록 (운동기록)</c:if></h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					
					<!-- content 시작 -->	
				    <c:if test="${user_auth == 2}">
				    <div class="align-right">
				    	<input type="button" value="목록보기" id ="view_List" onclick="location.href='${pageContext.request.contextPath}/exercise/exerciseList.do'"><!-- 목록보기 버튼 클릭 시 목록 페이지로 이동 -->
				    </div>
				    </c:if>
				    
				    <c:if test="${user_auth == 2}">
				    <div class="class-timetable">
				    		<div id="calendar"></div><!-- 캘린더를 표시할 div 요소 -->
				    </div>
				    </c:if>
				    
				    <c:if test="${user_auth >= 8}">
				    <div class="chart-table">
				    <form id="search_form" action="exerciseMain.do" method="get">
						<ul class="search">
							<li>
								<select name="keyfield">
									<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>이름</option>
									<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>아이디</option>
								</select>
							</li>
							<li>
								<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}">
							</li>
							<li>
								<input type="submit" value="검색">
							</li>
						</ul>
					</form>
					<br><br>
					
				    <table>
				    		<thead>
							<tr>
								<th>아이디</th>
								<th>이름</th>
								<th>전화번호</th>
								<th>등급</th>
							</tr>
						</thead>
						<c:forEach var="member" items="${list}">
							<tr>
								<c:if test="${member.mem_auth > 0}">
								<td><a href="${pageContext.request.contextPath}/exercise/exerciseList.do?client_num=${member.mem_num}">${member.mem_id}</a></td>
								</c:if>
								<c:if test="${member.mem_auth == 0}">
								<td>${member.mem_id}</td>
								</c:if>
								<td>${member.mem_name}</td>
								<td>${member.mem_phone}</td>
								<td>
									<c:if test="${member.mem_auth == 0}">탈퇴</c:if>
									<c:if test="${member.mem_auth == 1}">정지</c:if>
									<c:if test="${member.mem_auth == 2}">일반</c:if>
								</td>
							</tr>
						</c:forEach>
					</table>
					</div>
					<br>
					
					<div class="align-center">
						<div class="blog-pagination">
							${page}
						</div>
					</div>
				    </c:if>
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
