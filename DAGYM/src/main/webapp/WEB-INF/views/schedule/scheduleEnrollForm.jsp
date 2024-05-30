<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스케줄 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
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
    <div class="page-main">
        <jsp:include page="/WEB-INF/views/common/header.jsp" />
        <div class="align-center">
            <h2>스케줄 등록</h2>

            <form action="${pageContext.request.contextPath}/schedule/scheduleEnroll.do" method="post">
                <input type="hidden" name="sch_date" value="${sch_date}">
                <h2>선택한 날짜: ${sch_date}</h2>
                
                <div class="time-period-container">
                    <div class="time-period">
                        <h3>오전 시간 일괄 등록</h3>
                        <label>
                            <input type="checkbox" name="time_period" value="morning"> 오전 (09시 - 11시)
                        </label>
                    </div>

                    <div class="time-period">
                        <h3>오후 시간 일괄 등록</h3>
                        <label>
                            <input type="checkbox" name="time_period" value="afternoon"> 오후 (13시 - 20시)
                        </label>
                    </div>
                </div>
                 <div class="time-period-container">
                  <div class="time-period">
                   <h3>오전 시간 등록</h3>
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
                  <div class="time-period">
                   <h3>오후 시간 등록</h3>
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
    </div>
</body>
</html>
