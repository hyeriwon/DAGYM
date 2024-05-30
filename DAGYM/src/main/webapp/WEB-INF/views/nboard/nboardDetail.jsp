<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지글 상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="page-main">
		<h2>${nboard.nbo_title}</h2>
		<ul class="detail-info">
			<li>
				관리자<br>
				조회수 : ${nboard.nbo_hit}
			</li>
		</ul>
		<hr size="1" noshade="noshade" width="100%">
		<c:if test="${!empty nboard.nbo_filename}">
		<div class="align-center">
		<img src="${pageContext.request.contextPath}/upload/${nboard.nbo_filename}" class="detail-img">
		</div>
		</c:if>
		<p>
			${nboard.nbo_content}
		</p>
		<hr size="1" noshade="noshade" width="100%">
		<ul class="align-right detail-sub">
			<li>
				
				<c:if test="${!empty nboard.nbo_modify_date}">
				최근 수정일 : ${nboard.nbo_reg_date}
				</c:if>
				작성일 : ${nboard.nbo_reg_date}
				<c:if test="${user_num == nboard.mem_num}">
					<input type="button" value="수정" onclick="location.href='nboardUpdateForm.do?nbo_num=${nboard.nbo_num}'">
					<input type="button" value="삭제" id="delete_btn">
					<script type="text/javascript">
						const delete_btn = document.getElementById('delete_btn');
						//이벤트 연결
						delete_btn.onclick=function(){
							let choice = confirm('삭제하시겠습니까?');
							if(choice){
								location.replace('nboardDelete.do?nbo_num=${nboard.nbo_num}');
							}
						};
					</script>
				</c:if>
			</li>
		</ul>
	</div>
</div>
</body>
</html>