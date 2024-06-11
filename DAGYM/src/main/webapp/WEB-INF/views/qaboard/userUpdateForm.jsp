<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<script type="text/javascript">
window.onload=function(){
	const myForm = document.getElementById('write_form');
	myForm.onsubmit=function(){
		const type = document.getElementById('qab_type');
		if(type.value.trim()==''){
			alert('질문 유형을 선택하세요');
			type.value='';
			type.focus();
			return false;
		}
		const title = document.getElementById('qab_title');
		if(title.value.trim()==''){
			alert('제목을 입력하세요');
			title.value='';
			title.focus();
			return false;
		}
		const content = document.getElementById('qab_content');
		if(content.value.trim()==''){
			alert('내용을 입력하세요');
			content.value='';
			content.focus();
			return false;
		}
	};
};
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
                            <h2>문의수정</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->		
					<form id="write_form" action="userUpdate.do" method="post" enctype="multipart/form-data">
						<input type="hidden" name="qab_num" value="${qaboard.qab_num}">
						<ul>
							<li>
								<label for="qab_type">카테고리</label>
								<select name="qab_type" id="qab_type">
									<option value="" selected disabled>-질문 유형-</option>
									<option value="1" <c:if test="${qaboard.qab_type == 1}">selected</c:if>>PT</option>
									<option value="2" <c:if test="${qaboard.qab_type == 2}">selected</c:if>>다이어트</option>
									<option value="3" <c:if test="${qaboard.qab_type == 3}">selected</c:if>>상담</option>
									<option value="4" <c:if test="${qaboard.qab_type == 4}">selected</c:if>>회원권 상담</option>
									<option value="5" <c:if test="${qaboard.qab_type == 5}">selected</c:if>>기타</option>
								</select>
							</li>
							<li>
								<label for="qab_title">제목</label>
								<input type="text" name="qab_title" id="qab_title" value="${qaboard.qab_title}" 
								maxlength="50">
							</li>
							<li>
								<label for="qab_content">내용</label>
								<textarea rows="10" cols="50" name="qab_content" id="qab_content">${qaboard.qab_content}</textarea>
							</li>
							<li>
								<label for="qab_filename">이미지</label>
								<input type="file" name="qab_filename" id="qab_filename" accept="image/gif,image/png,image/jpeng">
								<%-- 점부이미지가 있는 경우 --%>
								<c:if test="${!empty qaboard.qab_filename}">
									<div id="file_detail">
									<img src="${pageContext.request.contextPath}/upload/${qaboard.qab_filename}" width="150" class="my-photo2">
									<input type="button" value="파일 삭제" id="file_del">
									</div>
									<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
									<script type="text/javascript">
									$(function(){
										$('#file_del').click(function(){
											let choice = confirm('삭제하시겠습니까?');
											if(choice){
												$.ajax({
													url:'userDeleteFile.do',
													type:'post',
													data:{qab_num:${qaboard.qab_num}},
													dataType:'json',
													success:function(param){
														if(param.result == 'logout'){
															alert('로그인 후 사용하세요');
														}else if(param.result == 'success'){
															$('#file_detail').hide();
														}else if(param.result == 'wrongAccess'){
															alert('잘못된 접속입니다.');
														}else{
															alert('파일 삭제 오류 발생');
														}
													},
													error:function(){
														alert('네트워크 오류 발생');
													}
												});
											}
										});
									});
									</script>
								</c:if>
							</li>
						</ul>
						<br>
						<div class="align-center">
							<input type="submit" value="등록">
							<input type="button" value="목록" onclick="location.href='userQuestionList.do'">
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