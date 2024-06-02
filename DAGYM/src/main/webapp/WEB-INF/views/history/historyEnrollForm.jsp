<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PT 예약</title>
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
    <div class="page-main">
        <jsp:include page="/WEB-INF/views/common/header.jsp" />
        <div class="content-main">
            <div class="align-center">
                <h2>PT 예약</h2>
            </div>
            <form action="${pageContext.request.contextPath}/history/historyEnroll.do" method="post">
                <input type="hidden" name="sch_num" value="${param.sch_num}">
                <input type="hidden" name="tra_num" value="${param.tra_num}">
                <input type="hidden" name="his_date" value="${param.his_date}">
                <input type="hidden" name="sch_time" value="${param.sch_time}">
                <div class="align-center">
                    <h2>선택한 날짜: ${param.his_date}</h2>
                </div>
                <ul>
                    <li>
                        <label for="tra_name">선택한 시간</label>
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
                        <label for="tra_name">트레이너 : </label>
                        <input type="text" name="tra_name" id="tra_name" value="${param.tra_name}" readonly>
                    </li>
                    <li>
                        <label for="his_part">운동 부위(희망) : </label>
                        <select name="his_part">
                            <option>어깨</option>
                            <option>가슴</option>
                            <option>등</option>
                            <option>하체</option>
                            <option>팔</option>
                            <option>유산소</option>
                        </select>
                    </li>
                    <li>
                        <label for="remainingPT">잔여 PT : </label>
                        <input type="text" name="remainingPT" value="${remainingPT}" readonly>
                    </li>
                </ul>
                <div class="align-center">
                    <input type="submit" value="수강 신청">
                    <input type="button" value="취소" onclick="location.href='list.do'">
                </div>
            </form>
        </div>
    </div>
</body>
</html>
