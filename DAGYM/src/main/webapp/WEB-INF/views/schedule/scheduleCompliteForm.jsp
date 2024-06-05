<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SCHEDULE</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
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
                            <a href="#">Class</a>
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
                            <h2>PT신청</h2>
                        </div>
                 </div>
             </div>
          </div>
            <div class="row">
                <div class="col-lg-12">    
                    <div class="chart-table">
                    
                    <!-- content 시작 -->
                    <form action="${pageContext.request.contextPath}/schedule/scheduleComplite.do" method="post">
                        <input type="hidden" name="sch_num" value="${sch_num}">
                        <input type="hidden" name="his_num" value="${his_num}">
                        <input type="hidden" name="tra_num" value="${param.tra_num}">
                        <input type="hidden" name="his_date" value="${param.his_date}">
                        <input type="hidden" name="sch_time" value="${param.sch_time}">
                        <div class="align-center">
                            <h4>PT 진행 날짜 : ${param.sch_date}</h4>
                        </div>
                        <ul>
                            <li>
                                <label for="tra_name">PT 진행 시간</label>
                                <c:set var="sch_time" value="${param.sch_time}" />
                                <c:choose>
                                    <c:when test="${sch_time < 12}">
                                        <input type="text" name="sch_time_display" id="sch_time" value="오전 ${sch_time}시" readonly>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="pm_time" value="${sch_time - 12}" />
                                        <input type="text" name="sch_time_display" id="sch_time" value="오후 ${pm_time == 0 ? 12 : pm_time}시" readonly>
                                    </c:otherwise>
                                </c:choose>
                                <label for="tra_name">회원ID</label>
                                <input type="text" name="tra_name" id="tra_name" value="${param.mem_name}" readonly>
                            </li>
                            <li>
                                <label for="his_part">운동 부위(희망)</label>
                                <select name="his_part">
                                    <option value="${param.his_part}" disabled selected>${param.his_part}</option>
                                    <option>어깨</option>
                                    <option>가슴</option>
                                    <option>등</option>
                                    <option>하체</option>
                                    <option>팔</option>
                                    <option>유산소</option>
                                </select>
                                
                            </li>
                            <li>
                                <label for="remainingPT">잔여 PT</label>
                                <input type="text" name="remainingPT" value="${remainingPT}" readonly>
                            </li>
                        </ul>
                        <div class="align-center">
                            <input type="submit" value="PT 완료">
                            <input type="button" value="목록" onclick="location.href='mylist.do'">
                        </div>
                    </form>
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
