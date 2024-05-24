<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
    <jsp:include page="/WEB-INF/views/common/header.jsp"></jsp:include>
    <div class="content-main">
        <h2>수강신청</h2>
        <form action="enrollProcess.do" method="post">
            <!-- 수강 신청 폼 요소들 -->
            <!-- 예: 수강할 스케줄 선택, 수강 기간 선택, 추가 정보 입력 등 -->
            <label for="schedule">수강할 스케줄 선택:</label>
            <select id="schedule" name="schedule">
                <!-- 여기에 스케줄 옵션을 동적으로 생성하거나 서버로부터 받아온 스케줄 목록을 표시할 수 있습니다. -->
                <option value="1">스케줄 1</option>
                <option value="2">스케줄 2</option>
                <!-- 추가적인 스케줄 옵션들... -->
            </select>
            <!-- 추가적인 수강 신청 폼 요소들 추가 -->
            <!-- 예: 수강 기간, 수강자 정보 입력 등 -->
            <input type="submit" value="수강 신청">
        </form>
    </div>
</div>
</body>
</html>
