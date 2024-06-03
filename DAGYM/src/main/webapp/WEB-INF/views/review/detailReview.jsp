<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>REVIEW</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SYJ.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
	//초기데이터 호출
	getReviewLikes();
	//좋아요 등록,취소
	$('.like_img').click(function(){
		$.ajax({
			url:'changeReviewLike.do',
			type:'post',
			data:{rev_num:$(this).attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 좋아요를 누를 수 있습니다.');					
				}else if(param.result == 'success'){
					displayLike(param);
					showCount(param);
				}else{
					alert('좋아요 등록/취소 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});	
	function displayLike(param){
		if(param.status == 'noLikes'){
			$('.like_img').css('color','#ddd');
		}else if(param.status == 'yesLikes'){
			$('.like_img').css('color','red');
		}		
	}
	function showCount(param){
		$('.rev_like').text(param.count);
	}
	function getReviewLikes(){
		$.ajax({
			url:'getLikeStatus.do',
			type:'post',
			data:{rev_num:$('.like_img').attr('data-num')},
			dataType:'json',
			success:function(param){
				displayLike(param);
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	}
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
                        <h2>Review</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">About</a>
                            <span>Review</span>
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
                    		<span>Review</span>
                            <h2>후기상세</h2>
                    	</div>
                 </div> 
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<div>
						<ul>
							<li>
								<h2>${review.rev_title}</h2>
								<div class="align-right">
										<label>조회수</label> ${review.rev_hit}<br>
										<span class="like_img" data-num="${review.rev_num}">♥</span> <label>좋아요</label>
										<span class="rev_like">${review.rev_like}</span>
								</div>
							</li>
							<li>
								<c:if test="${mem_num != member.mem_num && member.mem_auth!=9}">
									<c:set var="len" value="${fn:length(member.mem_id)}"/>
									<c:set var="maskedId" value="${fn:substring(member.mem_id, 0, 4)}"/>
									<c:set var="maskedId" value="${maskedId}${fn:substring('********', 0, len-4)}"/>
									${maskedId} 님 
								</c:if>
								<c:if test="${mem_num == member.mem_num || member.mem_auth==9}">
									${member.mem_id} 님
								</c:if>
							</li>
							<li>
								<label>진행 날짜</label> ${history.sch_date}시
								<label>트레이너</label> ${trainer.mem_name}
							</li>
							<li>
								<label>별점</label>
								<c:forEach var="i" begin="1" end="5">
									<c:if test="${i <= review.rev_grade}">
										<span style="color:#ff5500;">★</span>
									</c:if>
									<c:if test="${i > review.rev_grade}">
										<span style="color: #ddd;">★</span>
									</c:if>
								</c:forEach>
							</li>
							<li>
								${review.rev_content}
							</li>
							<li style="display:inline-block;padding-right:100px;">
								<c:if test="${!empty review.rev_filename1}">
									<label for="before">before 사진</label><br>
									<img src="${pageContext.request.contextPath}/upload/${review.rev_filename1}" id="before" width="200" height="200">
								</c:if>
							</li>
							<li style="display:inline-block;">
								<c:if test="${!empty review.rev_filename2}">
									<label for="after">after 사진</label><br>
									<img src="${pageContext.request.contextPath}/upload/${review.rev_filename2}" id="after" width="200" height="200">
								</c:if>
							</li>	
							<li class="align-right">
								<label>작성일</label> ${review.rev_reg_date}
								<c:if test="${!empty review.rev_modify_date}">
									<label>수정일</label> ${review.rev_modify_date}
								</c:if>	
							</li>	
						</ul>
						<hr size="1" noshade="noshade" width="80%">
						<div class="align-center">
							<c:if test="${member.mem_num == mem_num}">
								<input type="button" value="수정" onclick="location.href='updateReviewForm.do?rev_num=${review.rev_num}'">
								<input type="button" value="삭제" id="delReview">
								<script type="text/javascript">
									$(function(){
										$('#delReview').click(function(){
											let choice = confirm('후기를 삭제하시겠습니까?');
											if(choice){
												$.ajax({
													url:'deleteReview.do',
													type:'post',
													data:{rev_num:${review.rev_num}},
													dataType:'json',
													success:function(param){
														if(param.result == 'logout'){
															alert('로그인 후 이용해주세요!');
															location.replace('../member/loginForm.do');
														}else if(param.result == 'wrongAccess'){
															alert('잘못된 접근입니다.');
														}else if(param.result == 'success'){
															alert('삭제되었습니다');
															location.href('listReview.do');
														}else{
															alert('후기 삭제 오류');
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
							<input type="button" value="목록" onclick="location.href='listReview.do'">
						</div>
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