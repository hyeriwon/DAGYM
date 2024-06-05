<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>PT 완료</title>
</head>
<body>
    <script type="text/javascript">
        // JSP에서 전달된 메시지와 URL을 JavaScript 변수로 저장
        var resultMsg = '<%= request.getAttribute("result_msg") %>';
        var redirectUrl = '<%= request.getAttribute("redirect_url") %>';

        // alert 메시지를 띄운 후 지정된 URL로 이동
        alert(resultMsg);
        window.location.href = redirectUrl;
    </script>
</body>
</html>
