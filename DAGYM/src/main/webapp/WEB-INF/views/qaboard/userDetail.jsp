<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#delete').click(function(){
		if(confirm("정말 삭제하시겠습니까?")){
			location.href='userDelete.do?qab_num='+"${qaboard.qab_num}";
		}
	});
});
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
                        <h2>Q&A</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">MyPage</a>
                            <span>Q&A</span>
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
                    		<span>Q&A</span>
                            <h2>문의상세</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->			
					<h2>${qaboard.qab_title}</h2>
					<div class="align-right">
						<input type="button" value="수정" onclick="location.href='userUpdateForm.do?qab_num=${qaboard.qab_num}'">
						<input type="button" value="삭제" id="delete">
						<input type="button" value="목록" onclick="location.href='userQuestionList.do'">
					</div>
					<hr size="1" noshade="noshade" width="100%">
					<%-- 내용 --%>
					<p>${qaboard.qab_content}</p><br>
					<%-- 첨부파일이 있을 경우 --%>	
					<c:if test="${!empty qaboard.qab_filename}">
					<div class="align-left">
						<img src="${pageContext.request.contextPath}/upload/${qaboard.qab_filename}" class="detail-img">
					</div>
					</c:if>
					<hr size="1" noshade="noshade" width="100%">
					<%-- 등록일, 수정일 --%>
					<div class="align-right">
						<c:if test="${!empty qaboard.qab_modify_date}">
							최근 수정일 : ${qaboard.qab_modify_date}
						</c:if>
						작성일 : ${qaboard.qab_reg_date}
					</div>
					<%-- 문의답변 --%>
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