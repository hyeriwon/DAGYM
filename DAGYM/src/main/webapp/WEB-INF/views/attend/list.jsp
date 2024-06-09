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
/* 	        var formattedTitle = year + '년 ' + month + '월'; //영어 -> 한글
	        document.querySelector('.fc-toolbar-title').innerText = formattedTitle; */
	    }
	    
		var calendar = new FullCalendar.Calendar(calendarEl, {
		    selectable: true, // 날짜 선택 가능
		    height: 'auto', // 캘린더 높이 자동 조절
		    width: 'auto', // 캘린더 너비 자동 조절
	    		headerToolbar: {
		        //left: 'prev,next today',
		        left: 'prev,next',
		        center: 'title',
		        //right: 'dayGridMonth,timeGridWeek,timeGridDay'
		        right: 'today'
	    		},
			initialDate: new Date().toISOString().slice(0, 10), // 오늘 날짜로 설정
			navLinks: true, //can click day/week names to navigate views
			selectable: true,
			selectMirror: true,
			selectAllow: function(selectInfo) {//오늘 날짜만 선택 가능
				var today = new Date();
				today.setHours(0, 0, 0, 0);
				return selectInfo.start.getTime() === today.getTime();
			},
			select: function(arg) {
				//오늘 날짜	
				var today = new Date();
		        var selectedDate = arg.start;
		
		     	//정확한 날짜 비교를 위해 시간을 00:00:00으로 설정
		        today.setHours(0, 0, 0, 0);
		        selectedDate.setHours(0, 0, 0, 0);
		
		        if (selectedDate.getTime() === today.getTime()) {
		        	if (confirm('출석하시겠습니까?')) {
		            	//(출석등록) 선택한 날짜를 write.do로 리다이렉트
		                location.href = 'write.do?date=' + arg.start.toISOString();
	                }
				}
		        calendar.unselect()
			},
			eventClick: function(arg) {
				//오늘 날짜
				var today = new Date();
				var eventDate = arg.event.start;
				
				//정확한 날짜 비교를 위해 시간을 00:00:00으로 설정
				today.setHours(0, 0, 0, 0);
				eventDate.setHours(0, 0, 0, 0);
				
				if (eventDate.getTime() !== today.getTime()) {
					// 클릭 이벤트 무시
					return false;
				}
				
		    	if (confirm('출석을 취소하시겠습니까?')) {
		    		//(출석삭제) events의 title에서 att_num 가져와서 delete.do로 리다이렉트
		    		var att_num = arg.event.title;
		    		location.href = 'delete.do?att_num=' + att_num;
		        }
			},
			editable: true,
			dayMaxEvents: true, //allow "more" link when too many events
			events: [
				//(출석목록) DB에서 list형식으로 가져오기
		    		<c:forEach var="attend" items="${list}">
		    		{
		        		title: '${attend.att_num}',
		            start: '${attend.att_date}'
		     	}
		    		<c:if test="${!attend_last}">,</c:if>
		        </c:forEach>
			],
			eventDidMount: function(info) {
				//이벤트 타이틀 숨기기
				var titleElement = info.el.querySelector('.fc-event-title');
				if (titleElement) {
					titleElement.style.display = 'none';
				}
				//이벤트를 동그라미로 표시
				info.el.style.backgroundColor = 'transparent';
				info.el.style.border = 'none';
				info.el.innerHTML = '<div class="event-circle"></div>';
				//동그라미를 가운데로 정렬
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
                            <a href="#">Mypage</a>
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
                            <h2>출석체크</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="class-timetable">
					
					<!-- content 시작 -->
		            <h4 id="monthHeader" style="text-align: right;"></h4>
		            <br>
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