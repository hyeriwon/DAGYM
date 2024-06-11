<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/WHR.css" type="text/css">
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
                            <h2>문의내역</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table2 line">
					
					<!-- content 시작 -->			
					<%-- 질문시작 --%>	
					<div class="question-header">
						<p class="qab_type">[
							<c:if test="${qaboard.qab_type==1}">PT</c:if>
							<c:if test="${qaboard.qab_type==2}">다이어트</c:if>
							<c:if test="${qaboard.qab_type==3}">상담</c:if>
							<c:if test="${qaboard.qab_type==4}">회원권 상담</c:if>
							<c:if test="${qaboard.qab_type==5}">기타</c:if>]
						</p>	
						<h3>${qaboard.qab_title}</h3><br>
						<div class="content-header">
							<div class="align-left">
								<c:if test="${!empty qaboard.qab_modify_date}">
									최근 수정일 &nbsp;${qaboard.qab_modify_date} &nbsp;&nbsp;&nbsp;&nbsp;
								</c:if>
								작성일 &nbsp;${qaboard.qab_reg_date}
							</div>
							<div class="align-right">
								<c:if test="${empty answerBoard}">
									<input type="button" value="수정" onclick="location.href='userUpdateForm.do?qab_num=${qaboard.qab_num}'">
								</c:if>
								<input type="button" value="삭제" id="delete">
							</div>
						</div>
						<hr size="1" noshade="noshade" width="100%">
					</div>
					<%-- 내용 --%>
					<div class="question-content">
						<div class="content-text">
							${qaboard.qab_content}<br>
						</div>
						<%-- 첨부파일이 있을 경우 --%>	
						<c:if test="${!empty qaboard.qab_filename}">
						<div class="align-left">
							<br>
							<img src="${pageContext.request.contextPath}/upload/${qaboard.qab_filename}" class="detail-img" width="400">
						</div>
						</c:if>
					</div><br>
					<hr size="1" noshade="noshade" width="100%">
					<br>
					<%-- 문의답변 --%>
					<c:if test="${answerBoard!=null}">
						<div id="answer-div">
							<p id="answer_content">${answerBoard.qab_content}</p><br>
							<hr size="1" noshade="noshade" width="100%">
							<div class="align-right">
								<c:if test="${!empty answerBoard.qab_modify_date}">
									최근 수정일 &nbsp;${answerBoard.qab_modify_date}&nbsp;|
								</c:if>
								작성일 &nbsp;${answerBoard.qab_reg_date}
							</div>
						</div>
					</c:if>
					<!-- content 끝 -->
					</div>
					<div class="align-center">
						<input type="button" value="목록" onclick="location.href='userQuestionList.do'">
					</div>
				</div>
			</div>
	      </div>
	  </section>
  	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<jsp:include page="/WEB-INF/views/common/js_plugins.jsp"/>
	
</body>
</html>