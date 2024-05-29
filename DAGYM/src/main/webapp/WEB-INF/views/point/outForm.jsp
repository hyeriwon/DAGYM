<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트 차감</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript">

    window.onload=function(){
        const myForm = document.getElementById('out_form');
        //이벤트 연결
        myForm.onsubmit=function(){
            const poi_type = document.getElementById('poi_type');
            if(poi_type.value.trim()==''){
                alert('포인트 차감 종류를 입력하세요');
                poi_type.value = '';
                poi_type.focus();
                return false;
            }
            const poi_out = document.getElementById('poi_out');
            if(poi_out.value.trim()==''){
                alert('차감할 포인트를 입력하세요');
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

    <div class="page-main">
        <jsp:include page="/WEB-INF/views/common/header.jsp"/>
        <div class="content-main">
            <h2>포인트 차감</h2>
            <form id="out_form" action="out.do" method="post" enctype="multipart/form-data">
                <!-- hidden 필드로 회원 ID를 전달 -->
                <input type="hidden" name="mem_num" value="${param.mem_num}">
                <ul>
                    <li>
                        <label for="poi_type">종류</label>
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
                        <label for="poi_out">포인트</label>
                        <input type="text" name="poi_out" id="poi_out" maxlength="30">
                    </li>          
                </ul>
                <div class="align-center">
                    <input type="submit" value="확인">
                    <input type="button" value="취소" onclick="location.href='adminList.do'">
                </div>
            </form>
        </div>
    </div>
    
</body>
</html>