<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SCHEDULE</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<script type="text/javascript">
    <c:if test="${not empty message}">
        alert("${message}");
        window.location.href = "${pageContext.request.contextPath}/schedule/list.do";
    </c:if>
    <c:if test="${not empty error}">
        alert("${error}");
    </c:if>
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
                        <h2>Schedule</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">Mypage</a>
                            <span>Schedule</span>
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
                    		<span>Schedule</span>
                            <h2>스케줄 등록</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
			        <div class="align-center">
			            <form action="${pageContext.request.contextPath}/schedule/scheduleEnroll.do" method="post">
			                <input type="hidden" name="sch_date" value="${sch_date}">
			                <h2>선택한 날짜 ${sch_date}</h2>
			                <br>
			                <div class="time-period-container">
			                    <div class="time-period">
			                        <h3>오전 시간 일괄 등록</h3>
			                        <br>
			                        <label>
			                            <input type="checkbox" name="time_period" value="morning"> 오전 (09시 - 11시)
			                        </label>
			                    </div>
								<br>
			                    <div class="time-period">
			                        <h3>오후 시간 일괄 등록</h3>
			                        <br>
			                        <label>
			                            <input type="checkbox" name="time_period" value="afternoon"> 오후 (13시 - 20시)
			                        </label>
			                    </div>
			                </div>
			                <br>
			                <div class="time-period-container">
			                		<div class="time-period">
			                			<h3>오전 시간 등록</h3>
			                			<br>
			                  		<label>
			                    			<input type="checkbox" name="hourly_time_period" value="09"> 09시
			                			</label><br>
			               			<label>
			                    			<input type="checkbox" name="hourly_time_period" value="10"> 10시
			                			</label><br>
			                	
			                			<label>
			                    			<input type="checkbox" name="hourly_time_period" value="11"> 11시
			               			</label><br>
			                 	</div>
			                 	<br>
				                <div class="time-period">
					                <h3>오후 시간 등록</h3>
					                <br>
					                <label>
					                    	<input type="checkbox" name="hourly_time_period" value="13"> 13시
					               	</label><br>
					                	<label>
					                    	<input type="checkbox" name="hourly_time_period" value="14"> 14시
					                	</label><br>
					                	<label>
					                    	<input type="checkbox" name="hourly_time_period" value="15"> 15시
					                	</label><br>
						            	<label>
						            		<input type="checkbox" name="hourly_time_period" value="16"> 16시
						            </label><br>
						            <label>
						                <input type="checkbox" name="hourly_time_period" value="17"> 17시
						            </label><br>
						            <label>
						                <input type="checkbox" name="hourly_time_period" value="18"> 18시
						            </label><br>
						            <label>
						                <input type="checkbox" name="hourly_time_period" value="19"> 19시
						            </label><br>
						            <label>
						                <input type="checkbox" name="hourly_time_period" value="20"> 20시
						            </label>
				                </div>
			                </div>
			                <br><button type="submit">등록</button>
			            		<input type="button" value="목록" onclick="location.href='list.do'">
			            </form>
			        </div>
			        
			        <div id="sch_calendar"></div>
			        <input type="hidden" value="" name="date" id="date" maxlength="30">
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
