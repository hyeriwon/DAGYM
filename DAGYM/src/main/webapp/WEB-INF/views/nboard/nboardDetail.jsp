<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NOTICE</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
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
						<div class="chart-table">
						
						<!-- content 시작 -->
						<p>[
							<c:if test="${nboard.nbo_type==0}">공지</c:if>
							<c:if test="${nboard.nbo_type==1}">이벤트</c:if>
							<c:if test="${nboard.nbo_type==2}">기타</c:if>]
						</p>
						<h2>${nboard.nbo_title}</h2>
						<p>조회수 : ${nboard.nbo_hit}</p>
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
						
						<div class="align-right">
							<%-- 작성자 관리자&nbsp;| --%>
							<c:if test="${!empty nboard.nbo_modify_date}">
							최근 수정일 ${nboard.nbo_reg_date}&nbsp;|
							</c:if>
							작성일 &nbsp;${nboard.nbo_reg_date}
						</div>
						<div class="align-center">
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
							<input type="button" value="목록" onclick="location.href='nboardList.do'">
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