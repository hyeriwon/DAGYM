<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>INBODY</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet"href="${pageContext.request.contextPath}/css/HJW.css" type="text/css">
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
	      window.location.href = '${pageContext.request.contextPath}/inbody/inbodyWriteForm.do?inb_date='+selectedDate; // 클릭한 날짜로 이동합니다.
	    }
	  });
	  calendar.render(); // 캘린더를 렌더링합니다.
	});
	function searchByMemNum() {
		  var client_num = document.getElementById('client_num').value.trim();
		  if(client_num == '회원번호입력' || client_num ==''){
			  alert('회원번호를 입력하세요');
			  return;
		  }
		  window.location.href = '${pageContext.request.contextPath}/inbody/inbodyList.do?client_num='+client_num;
	}
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
                        <h2>Inbody</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">MyPage</a>
                            <span>Inbody</span>
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
                    		<span>Inbody</span>
                            <h2>인바디 등록</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->	
					<p>
				    <c:if test="${user_auth == 9}">
				    </c:if>
				    <div class="align-right">
				    <c:if test="${user_auth != 9}">
				    	<input type="button" value="목록보기" id ="view_List"onclick="location.href='${pageContext.request.contextPath}/inbody/inbodyList.do'"><!-- 목록보기 버튼 클릭 시 목록 페이지로 이동 -->
				    </c:if>
				    <c:if test="${user_auth == 9 }">
				    <label for="client_num"></label>
				     <input type="search"  id="client_num" value="회원번호입력" autocomplete="off"
				     onfocus="if(this.value=='회원번호입력') this.value='';" onblur="if(this.value=='') this.value='회원번호입력';">
				     <input type="submit" value="검색" onclick="searchByMemNum()"><!-- 목록보기 버튼 클릭 시 목록 페이지로 이동 -->
				    </c:if>
				    <div><p></div>
				    </div>
				    <div id="calendar"></div><!-- 캘린더를 표시할 div 요소 -->
				    <c:if test="${user_auth == 9}">
				    <table>
							<tr>
								<th>회원번호</th>
								<th>아이디</th>
								<th>이름</th>
								<th>가입일</th>
							</tr>
							<c:forEach var="member" items="${list}">
							<tr>
								<td>${member.mem_num}</td>
								<td>${member.mem_id}</td>
								<td>${member.mem_name}</td>
								<td>${member.mem_reg_date}</td>
							</tr>
							</c:forEach>
						</table>
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
