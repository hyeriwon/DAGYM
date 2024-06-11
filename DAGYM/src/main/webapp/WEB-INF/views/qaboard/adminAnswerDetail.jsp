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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/qaboard.answer.js"></script>
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
                            <a href="#">Member</a>
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
					<div class="chart-table">
					
					<!-- content 시작 -->	
					<%-- 질문 시작 --%>
					<input type="hidden" value="${qaboard.qab_num}" name="qab_num">
					<div class="question-header">
						<p class="qab_type">[
							<c:if test="${qaboard.qab_type==1}">PT</c:if>
							<c:if test="${qaboard.qab_type==2}">다이어트</c:if>
							<c:if test="${qaboard.qab_type==3}">상담</c:if>
							<c:if test="${qaboard.qab_type==4}">회원권 상담</c:if>
							<c:if test="${qaboard.qab_type==5}">기타</c:if>]
						</p>
						<h3>${qaboard.qab_title}</h3><br>
						<div class="align-left">
							<span style="color:#e8e8e8">${qaboard.mem_id}</span> &nbsp;&nbsp;&nbsp;&nbsp; 작성일 &nbsp;${qaboard.qab_reg_date} &nbsp;&nbsp;&nbsp;&nbsp;
							<c:if test="${!empty qaboard.qab_modify_date}">
								최근 수정일 &nbsp;${qaboard.qab_modify_date}
							</c:if>
						</div>
					<hr size="1" noshade="noshade" width="100%">
					</div>
					
					
					<%-- 내용 --%>
					<div class="question-content">
						<div class="content-text">
							<br>${qaboard.qab_content}<br>
						</div>
						<%-- 첨부파일이 있을 경우 --%>	
						<c:if test="${!empty qaboard.qab_filename}">
						<div class="content-img align-left">
							<br>
							<img src="${pageContext.request.contextPath}/upload/${qaboard.qab_filename}" class="detail-img" width="300">
							<br>
						</div>
						</c:if>
					</div><br>
					<hr size="1" noshade="noshade" width="100%">
					<%-- 질문 끝 --%>
					<br>
					
					<!-- 답변시작 -->
					<%-- 문의미답변, 답변등록 --%>
					<c:if test="${answerBoard==null}">
						<div id="answerForm-div">
						<span class="answer-title">답변 등록</span>
							<form id="answer_form" action="adminWriteAnswer.do" method="post">
								<input type="hidden" name="qab_num" value="${qaboard.qab_num}" id="qab_num"><!-- 문의글 번호 -->
								<input type="hidden" name="qab_type" value="${qaboard.qab_type}" id="qab_type"><!-- 문의글 타입 -->
									<textarea rows="5" name="answer_content" id="answer_content"></textarea>
								<input type="submit" value="등록">				
							</form>
						</div>
					</c:if>
					<%-- 문의답변 완료 --%>
					<c:if test="${answerBoard!=null}">
						<div id="answer-div">
							<c:if test="${user_num == answerBoard.mem_num}">
							<div class="align-right">
								<input type="button" id="update_answer_btn" value="수정" data-num="${answerBoard.qab_num}" data-qnum="${answerBoard.qab_ref}">&nbsp;
								<input type="button" id="delete_answer_btn" value="삭제" data-num="${answerBoard.qab_num}" data-qnum="${answerBoard.qab_ref}">
							</div>
							</c:if>
							<p id="answer_content">${answerBoard.qab_content}</p><br>
							<div class="align-right">
								<c:if test="${!empty answerBoard.qab_modify_date}">
									최근 수정일 &nbsp;${answerBoard.qab_modify_date}&nbsp;&nbsp;&nbsp;&nbsp;
								</c:if>
								작성일 &nbsp;${answerBoard.qab_reg_date}&nbsp;&nbsp;&nbsp;&nbsp; 작성자 &nbsp; ${answerBoard.mem_id}
								
							</div>
						</div>
					</c:if>
					<!-- 답변 끝 -->
					<%-- 질문리스트 목록 --%>
					<br>
					<div class="align-center">
						<input type="button" value="목록" onclick="location.href='adminAnswerList.do'">
					</div>
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
</body>
</html>