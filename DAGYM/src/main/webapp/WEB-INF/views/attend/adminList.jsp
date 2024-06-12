<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ATTEND</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<script src="${pageContext.request.contextPath}/js/index.global.min.js"></script>
<script>

	document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    var monthHeader = document.getElementById('monthHeader');
	
	    function updateMonthHeader(date) {
	        var year = date.getFullYear();
	        var month = date.getMonth() + 1; // 월은 0부터 시작하므로 +1
	        //monthHeader.innerText = month + '월 출석일수 : ${attendCount}일';
	        monthHeader.innerText = '이번달 출석일수 : ${attendCount}일';
	    }

	    function updateCalendarTitle(date) {
	        var year = date.getFullYear();
	        var month = date.getMonth() + 1; // 월은 0부터 시작하므로 +1
/* 	        var formattedTitle = year + '년 ' + month + '월';  //영어 -> 한글
	        document.querySelector('.fc-toolbar-title').innerText = formattedTitle; */
    		} 
	    
		var calendar = new FullCalendar.Calendar(calendarEl, {
		    selectable: true, // 날짜 선택 가능
		    height: 'auto', // 캘린더 높이 자동 조절
		    width: 'auto', // 캘린더 너비 자동 조절
	    		headerToolbar: {
		        left: 'prev,next',
		        center: 'title',
		        right: 'today'
	    		},
			initialDate: new Date().toISOString().slice(0, 10), //오늘 날짜로 설정
			navLinks: true, //can click day/week names to navigate views
			selectable: false, //관리자 모드에서는 선택 비활성화
			selectMirror: false,
			eventClick: function(arg) {
				//출석 취소 비활성화
			},
			editable: false,
			dayMaxEvents: true, //allow "more" link when too many events
			events: [
				<c:forEach var="attend" items="${list}">
				{
					title: '${attend.att_num}',
					start: '${attend.att_date}'
				}
				<c:if test="${!attend_last}">,</c:if>
				</c:forEach>
			],
			eventDidMount: function(info) {
				var titleElement = info.el.querySelector('.fc-event-title');
				if (titleElement) {
					titleElement.style.display = 'none';
				}
				info.el.style.backgroundColor = 'transparent';
				info.el.style.border = 'none';
				info.el.innerHTML = '<div class="event-circle"></div>';
				info.el.style.display = 'flex';
				info.el.style.alignItems = 'center';
				info.el.style.justifyContent = 'center';
			},
			<!-- 월 추출 -->
	        datesSet: function(info) {
	            var viewStart = info.view.currentStart;
	            updateMonthHeader(viewStart);
	            updateCalendarTitle(viewStart);
	        }
	    });
	    
	    calendar.render();
	    updateMonthHeader(new Date());
	    updateCalendarTitle(new Date());
	});

</script>
<style>

	/* 수직 스크롤바 숨기기 */
	.fc-scroller::-webkit-scrollbar {
	    display: none;
	}
	.fc-scroller {
	    -ms-overflow-style: none;  /* IE and Edge */
	    scrollbar-width: none;  /* Firefox */
	}
	/* 이벤트 동그라미 스타일 */
	.event-circle {
	    width: 15px;
	    height: 15px;
	    background-color: white; /* 이벤트 색상 */
	    border-radius: 50%;

	}

</style>
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/breadcrumb-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb-text">
                        <h2>Attend</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">Member</a>
                            <span>Attend</span>
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
                    		<span>Attend</span>
                          <h2>출석체크<c:if test="${user_auth >=8}"> (관리자)</c:if></h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="class-timetable">
					
					<!-- content 시작 -->
		            <h4 id="monthHeader" style="text-align: right;"></h4>			
		            <div id="calendar"></div>
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