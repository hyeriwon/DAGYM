<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>REVIEW</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$(document).on('click','[id^=updateRev]',function(){
		var index = $(this).attr('id').replace('updateRev', '');
		var selectedRevNum = $(this).data('rev');
		$.ajax({
			url:'changeReviewReport.do',
			type:'post',
			dataType:'json',
			data:{rev_num:$(this).attr('data-rev'),mem_num:$(this).attr('data-mem')},
			success:function(param){
				if(param == 'notExistReport'){
					alert('해당 글에 존재하는 신고 내역이 없습니다.');
				}else{
					toggleButton(param,index);
					toggleRow(param,selectedRevNum);
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
	
	$(document).on('click','[id^=recoverRev]',function(){
		var index = $(this).attr('id').replace('recoverRev', '');
		var selectedRevNum = $(this).data('rev');
		$.ajax({
			url:'changeReviewReport.do',
			type:'post',
			dataType:'json',
			data:{rev_num:$(this).attr('data-rev'),mem_num:$(this).attr('data-mem')},
			success:function(param){
				if(param.result=='logout'){
					alert('1');
				}else if(param.result=='notAutority'){
					alert('2');
				}else if(param.result=='notExistReport'){
					alert('3');
				}else if(param.result == 'success'){
					toggleButton(param,index);
					toggleRow(param,selectedRevNum);
				}else{
					alert('4');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
	
 	function toggleButton(param,index){
		if(param.status == 'reportYes'){
			$('#updateRev'+index).attr('disabled',true);
			$('#recoverRev'+index).attr('disabled',false);
			alert('신고가 정상처리 되었습니다.');
			if(param.count=='blind'){
				alert('후기를 블라인드 처리합니다!');
			}
		}else{
			$('#updateRev'+index).attr('disabled',false);
			$('#recoverRev'+index).attr('disabled',true);
			alert('신고가 취소되었습니다.');
			if(param.count=='clearBlind'){
				alert('블라인드 처리를 취소합니다!');
			}
		}
	}
 	
 	function toggleRow(param,selectedRevNum){
 		if(param.count=='blind'){
			$('tr').each(function(){
				var row = $(this);
				var revNum = row.find('[data-rev]').data('rev');
				if(revNum == selectedRevNum && row.find('input[type="button"][id^=recoverRev]').is(':disabled')){
          row.hide();
        }
			});
		}else{
			$('tr').each(function(){
				var row = $(this);
				var revNum = row.find('[data-rev]').data('rev');
				if(revNum == selectedRevNum){
	      	row.show();
	      }
			});
		}
 	}
});
</script>
</head>
<body>
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
                            <a href="#">Mypage</a>
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
                            <h2>신고내역</h2>
                    	</div>
                 </div> 
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
					<form id="search_form" action="adminReportList.do" method="get">
						<ul class="search">
							<li>
								<select name="keyfield">
									<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>원본 제목</option>
									<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>신고 사유</option>
									<option value="3" <c:if test="${param.keyfield == 3}">selected</c:if>>후기 번호</option>
								</select>					
							</li>
							<li>
								<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}">
							</li>
							<li>
								<input type="submit" value="검색">
							</li>
						</ul>
					</form>
					<c:if test="${count == 0}">
						<div class="result-display">
							표시할 신고 내역이 없습니다.
						</div>
					</c:if>
					<c:if test="${count > 0}">
					<br>
						<table>
							<thead>
								<tr>
									<th>원본 글번호</th>
									<th>원본 제목</th>
									<th>신고한 회원ID</th>
									<th>신고사유</th>
									<th>신고처리</th>
								</tr>
							</thead>
							<c:forEach var="report" items="${list}" varStatus="sta">
							<tr id="report${sta.index}">
								<td>${report.rev_num}</td>
								<td>
									<a href="detailReview.do?rev_num=${report.rev_num}">
									${report.rev_title}</a>
								</td>
								<td>${report.mem_id}</td>
								<td title="${report.report_content}">
									${fn:substring(report.report_content,0,10)}...
								</td>
								<td>		
									<input type="button" value="승인" data-rev="${report.rev_num}" 
										data-mem="${report.mem_num}" id="updateRev${sta.index}" <c:if test="${report.report_del == 1}">disabled</c:if>>
									<input type="button" value="취소" data-rev="${report.rev_num}" 
										data-mem="${report.mem_num}" id="recoverRev${sta.index}" <c:if test="${report.report_del == 0}">disabled</c:if>>
								</td>
							</tr>
							</c:forEach>
						</table>
						<br>
						<div class="align-center">
							<div class="blog-pagination">
								${page}
							</div>
						</div>
					</c:if>
					<div class="expiredReport"></div>
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