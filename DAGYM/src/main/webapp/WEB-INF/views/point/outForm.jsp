<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>POINT</title>
<jsp:include page="/WEB-INF/views/common/font_css.jsp"/>
<script type="text/javascript">

    window.onload=function(){
        const myForm = document.getElementById('out_form');
        //이벤트 연결
        myForm.onsubmit=function(){
            const poi_type = document.getElementById('poi_type');
            if(poi_type.value.trim()==''){
                alert('포인트 사용 종류를 입력하세요');
                poi_type.value = '';
                poi_type.focus();
                return false;
            }
            const poi_out = document.getElementById('poi_out');
            if(poi_out.value.trim()==''){
                alert('사용할 포인트를 입력하세요');
                poi_out.value = '';
                poi_out.focus();
                return false;
            }
            if (isNaN(poi_out.value.trim())) {
                alert('숫자로 입력하세요');
                poi_out.value = '';
                poi_out.focus();
                return false;
            }
        };
        
        const poiTypeSelect = document.getElementById('poi_type');
        const poiOutInput = document.getElementById('poi_out');
        // selectbox 변경 시 poi_out 필드 값 설정
        poiTypeSelect.onchange = function() {
            const poiType = poiTypeSelect.value;
            let poiOutValue = '';

            switch (poiType) {
                case '안마기 사용':
                    poiOutValue = '250';
                    break;
                case '장비 대여':
                    poiOutValue = '300';
                    break;
                case '식품 구매':
                    poiOutValue = '150';
                    break;
                case '수건 대여':
                    poiOutValue = '100';
                    break;
                case '용품 구매':
                    poiOutValue = '200';
                    break;
                default:
                    poiOutValue = '';
            }

            poiOutInput.value = poiOutValue;
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
                        <h2>Point</h2>
                        <div class="bt-option">
                            <a href="${pageContext.request.contextPath}/main/main.do">Home</a>
                            <a href="#">Member</a>
                            <span>Point</span>
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
                    		<span>Point</span>
                            <h2>포인트 사용</h2>
                    	</div>
                 </div>
             </div>
          </div>
          	<div class="row">
				<div class="col-lg-12">    
					<div class="chart-table">
					
					<!-- content 시작 -->
		            <form id="out_form" action="out.do" method="post" enctype="multipart/form-data">
		                <!-- hidden 필드로 회원 ID를 전달 -->
		                <input type="hidden" name="mem_num" value="${param.mem_num}">
		                <ul>
		                    <li>
		                        <label for="poi_type">사용 종류</label>
		                        <select name="poi_type" id="poi_type">
		                            <option value="">--- 선택 ---</option>
		                            <option value="안마기 사용">안마기 사용</option>
		                            <option value="장비 대여">장비 대여</option>
		                            <option value="식품 구매">식품 구매</option>
		                            <option value="수건 대여">수건 대여</option>
		                            <option value="용품 구매">용품 구매</option>
		                        </select>
		                    </li>
		                    <li>
		                        <label for="poi_out">사용 포인트</label>
		                        <input type="text" name="poi_out" id="poi_out" maxlength="30">
		                    </li>          
		                </ul>
		                <br>
		                
		                <div class="align-center">
		                    <input type="submit" value="확인">
		                    <input type="button" value="취소" onclick="location.href='adminList.do?mem_num=${param.mem_num}'">
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