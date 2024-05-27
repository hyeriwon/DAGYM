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
            <h2 align="center">스케줄 등록</h2>

            <form action="${pageContext.request.contextPath}/schedule/scheduleEnroll.do" method="post">
                <input type="hidden" name="sch_date" value="${sch_date}">
                
                <label for="title">아래 날짜로 스케줄을 등록합니다.</label><br>
                <p>선택한 날짜: ${sch_date}</p>
                
                <label>
                    <input type="checkbox" name="time_period" value="morning"> 오전 (09시 - 11시)
                </label><br>
                <label>
                    <input type="checkbox" name="time_period" value="afternoon"> 오후 (13시 - 20시)
                </label><br>
                
                <button type="submit">등록</button>
                <input type="button" value="목록" onclick="location.href='list.do'">
            </form>
        </div>
    </div>
</body>
</html>
