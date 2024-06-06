<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEAL</title>
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
    width:'auto', // 캘린더 너비 자동 조절
    headerToolbar: { // 캘린더 헤더 설정
      left: 'prev,next today', // 왼쪽에 이전, 다음, 오늘 버튼 배치
      center: 'title', // 중앙에 타이틀 배치
      right: 'dayGridMonth' // 오른쪽에 월별 보기 버튼 배치
    },
    selectAllow: function(selectInfo) {
        var today = new Date().toISOString().split('T')[0];
        return selectInfo.startStr <= today;
      },
      dateClick: function(info) {
	      var today = new Date();
	      var clickedDate = new Date(info.dateStr);

	      // 클릭된 날짜가 오늘 이전인지 확인
	      if (clickedDate >= today.setDate(today.getDate())) {
	          alert('오늘 이후의 식사내역을 등록할 수 없습니다.');
	          window.location.reload();
	      } else {
	        var selectedDate = info.dateStr; // 클릭한 날짜를 문자열로 가져옵니다.
	        window.location.href = '${pageContext.request.contextPath}/meal/mealWriteForm.do?meal_date='+selectedDate; // 클릭한 날짜로 이동합니다.
	      }
	    }
  });
  calendar.render(); // 캘린더를 렌더링합니다.
});
window.onload=function(){
	const myForm = document.getElementById('search_form');
	//이벤트 연결
	myForm.onsubmit=function(){
		const keyword = document.getElementById('keyword');
		if(keyword.value.trim()==''){//아무것도 입력하지 않은 경우
			alert('검색어를 입력하세요');
			keyword.value='';
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
                        <h2>Meal</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">Mypage</a>
                            <span>Meal</span>
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
                    		<span>Meal</span>
                            <h2>식사등록</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
				    <div class="align-left">
				    </div>
				    <div class="align-right">
					    <c:if test="${user_auth ==2}">
					    	<input type="button" value="목록보기" onclick="location.href='${pageContext.request.contextPath}/meal/mealDetail.do'"><!-- 목록보기 버튼 클릭 시 목록 페이지로 이동 -->
					    </c:if>
				    </div>
				    <c:if test="${user_auth ==2}">
				    <div id="calendar"></div><!-- 캘린더를 표시할 div 요소 -->
				    </c:if>
				    <c:if test="${user_auth >=8}">
				    <form id="search_form" action="list.do" method="get">
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
				    <table>
				    		<thead>
							<tr>
								<th>회원번호</th>
								<th>아이디</th>
								<th>이름</th>
								<th>가입일</th>
							</tr>
						</thead>
						<c:forEach var="member" items="${list}">
							<tr>
								<td><a href="${pageContext.request.contextPath}/meal/mealDetail.do?client_num=${member.mem_num}">${member.mem_num}</a></td>
								<td>${member.mem_id}</td>
								<td>${member.mem_name}</td>
								<td>${member.mem_reg_date}</td>
							</tr>
						</c:forEach>
					</table>
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
