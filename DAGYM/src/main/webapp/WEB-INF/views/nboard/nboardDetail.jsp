<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NOTICE</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SHG.css" type="text/css">
</head>
<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	
	<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="${pageContext.request.contextPath}/resources/img/breadcrumb-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb-text">
                        <h2>Notice</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">C/S</a>
                            <span>Notice</span>
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
	                    		<span>Notice</span>
	                            <h2>공지상세</h2>
	                    	</div>
	                 </div>
	             </div>
	          </div>
	          	<div class="row">
					<div class="col-lg-12">    
						<div class="chart-table3">
						 
						<!-- content 시작 -->
						<%-- 글 헤더--%>
						<div class="nbo-header">
						<p class="nbo_type">[
							<c:if test="${nboard.nbo_type==0}">공지</c:if>
							<c:if test="${nboard.nbo_type==1}">이벤트</c:if>
							<c:if test="${nboard.nbo_type==2}">기타</c:if>]
						</p>
						<h2>${nboard.nbo_title}</h2>
						<div class="align-right">조회수 : ${nboard.nbo_hit}</div>
						<hr size="1" noshade="noshade" width="100%">
						</div>
						
						<%-- 내용 --%>
						<div class="nbo-content">
						<div class="content-img">
						<c:if test="${!empty nboard.nbo_filename}">
						<div class="align-center">
						<img src="${pageContext.request.contextPath}/upload/${nboard.nbo_filename}" class="detail-img">
						</div>
						<br>
						</c:if>
						</div>
						<div class="content-text">
							<br>${nboard.nbo_content}<br>
						</div>
						</div>
						<hr size="1" noshade="noshade" width="100%">
						
						<div class="align-right">
							작성일 ${nboard.nbo_reg_date}&nbsp;&nbsp;
							<c:if test="${!empty nboard.nbo_modify_date}">
							|&nbsp;&nbsp; 최근 수정일 ${nboard.nbo_modify_date}&nbsp;&nbsp;
							</c:if>
						</div>
						<div class="align-center">
							<input type="button" value="목록" onclick="location.href='nboardList.do'">
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