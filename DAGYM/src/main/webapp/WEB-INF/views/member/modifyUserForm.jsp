<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
$(function(){
	let emailCheck = 1;
	//유효성 체크
	$('#modify_form').submit(function(){
		//새 비밀번호, 생년월일, 성별, 프로필 사진 제외 유효성 체크
		const items = document.querySelectorAll('.input-check');
		for(let i=0;i<items.length;i++){
			if(items[i].value.trim() == ''){
				const label = document.querySelector('label[for="'+items[i].id+'"]');
				alert(label.textContent+' 항목 필수 입력!');
				items[i].value = '';
				items[i].focus();
				return false;
			}
			//이메일 중복 체크 여부 확인
			if(items[i].id == 'email' && emailCheck == 0){
				alert('이메일 중복 체크 필수!');
				return false;
			}
		}
		//새 비밀번호와 새 비밀번호 확인 일치 여부(폼 전송시)
		if($('#newPw').val() != $('#newCpw').val()){
			alert('새 비밀번호와 새 비밀번호 확인이 불일치합니다.');
			$('#newPw').val('').focus();
			$('#newCpw').val('');
			return false;
		}
		//새 비밀번호 자리수 체크
		if(!/^[0-9][a-z][A-Z]{8,12}$/.test($('#newPw').val())){
			alert('비밀번호는 숫자와 영문을 혼용하여 8~12자리로 작성해주세요.');
			$('#newPw').val('').focus();
			$('#newCpw').val('');
			return false;
		}
		//전화번호 자리수 체크
		if(!/^\d{3}-\d{4}-\d{4}$/.test($('#phone').val())){
			alert('전화번호는 000-0000-0000 형식으로 입력해주세요.');
			$('#phone').val('').focus();
			return false;
		}
	});
	//새 비밀번호와 새 비밀번호 확인 일치 여부
	$('#newCpw').keyup(function(){
		if($('#newPw').val() == $('#newCpw').val()){
			$('#check-msg').text('새 비밀번호와 새 비밀번호 확인이 일치합니다.').css('color','blue');
		}
	});
	
	//동적으로 이메일 중복체크 버튼 생성
	$('#email').keyup(function(){
		$('#email_check').show();
		/* if($('#email').val() == ${member.mem_email}){
			$('#email_check').hide();
		} */
	});
	//이메일 중복 체크
	$('#email_check').click(function(){
		$.ajax({
			url:'checkDuplicatedEmail.do',
			type:'post',
			data:{email:$('#email').val()},
			dataType:'json',
			success:function(param){
				if(param.result == 'emailNotFound'){
					emailCheck = 1;
					$('#email_msg').text('사용가능한 이메일 주소입니다.').css('color','blue');
				}else if(param.result == 'emailDuplicated'){
					emailCheck = 0;
					alert('중복된 이메일입니다.');
					$('#email').val('').focus();
				}else{
					emailCheck = 0;
					alert('이메일 중복 체크 오류 발생');
				}
			},
			error:function(){
				emailCheck = 0;
				alert('네트워크 오류 발생');
			}
		});
	});
	//이메일 입력창에 데이터 입력시 중복 체크 정보 초기화
	$('#email').
});
</script> 
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="content-main">
		<h2>회원정보 수정</h2>
		<form id="modify_form" action="modifyUser.do" method="post" enctype="multipart/form-data">
			<ul>
				<li>
					<label for="name">이름</label>
					<input type="text" name="mem_name" id="name" class="input-check"
							value="${member.mem_name}" maxlength="10">
				</li>
				<li>
					<label for="photo">프로필 사진</label>
					<input type="file" name="mem_photo" id="photo" value="${member.mem_photo}" accept="image/gif,image/png,image/jpeg"><br>
					<c:if test="${empty member.mem_photo}">
						<img src="${pageContext.request.contextPath}/images/face.png">
					</c:if>
					<c:if test="${!empty member.mem_photo}">
						<img src="${pageContext.request.contextPath}/upload/${member.mem_photo}">
					</c:if>				
				</li>
				<li>
					<label for="nowPw">현재 비밀번호</label>
					<input type="password" maxlength="12" name="mem_nowPw" id="nowPw" class="input-check">
				</li>
				<li>
					<label>새 비밀번호</label>
					<input type="password" maxlength="12" name="mem_newPw" id="newPw" maxlength="12">
				</li>
				<li>
					<label>새 비밀번호 확인</label>
					<input type="password" id="newCpw" maxlength="12"><br>
					<span id="check-msg"></span>
				</li>
				<li>
					<label for="phone">전화번호</label>
					<input type="text" name="mem_phone" id="phone" value="${member.mem_phone}" maxlength="15" class="input-check">
				</li>
				<li>
					<label for="email">이메일</label>
					<input type="email" name="mem_email" id="email" value="${member.mem_email}" maxlength="50" class="input-check">
					<input type="button" value="중복체크" id="email_check" style="display:none;">
					<span id="email_msg"></span>
				</li>
				<li>
					<label>성별</label>
					<input type="radio" name="mem_gender" value="0" <c:if test="${member.mem_gender == 0}">checked</c:if>>남성
					<input type="radio" name="mem_gender" value="1" <c:if test="${member.mem_gender == 1}">checked</c:if>>여성
				</li>
				<li>
					<label>생년월일</label>
					<input type="date" name="mem_birth" id="birth" value="${member.mem_birth}">
				</li>
				<li>
					<label for="zipcode">우편번호</label>
					<input type="text" name="mem_zipcode" id="zipcode" value="${member.mem_zipcode}" maxlength="5" autocomplete="off" class="input-check">
					<input type="button" value="우편번호 찾기" onclick="execDaumPostcode()">
				</li>
				<li>
					<label for="address1">주소</label>
					<input type="text" name="mem_address1" id="address1" class="input-check" value="${member.mem_address1}" maxlength="30">
				</li>
				<li>
					<label for="address2">상세 주소</label>
					<input type="text" name="mem_address2" id="address2" class="input-check" value="${member.mem_address2}" maxlength="30">
				</li>
			</ul>
			<div class="align-center">
				<input type="submit" value="수정">
				<input type="button" value="취소" onclick="location.href='myPage.do'">
			</div>
		</form>
			<!-- 다음 우편번호 API 시작 -->
			<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
			<div id="layer"
				style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
					id="btnCloseLayer"
					style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
					onclick="closeDaumPostcode()" alt="닫기 버튼">
			</div>

			<script
				src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    //(주의)address1에 참고항목이 보여지도록 수정
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //(수정) document.getElementById("address2").value = extraAddr;
                
                } 
                //(수정) else {
                //(수정)    document.getElementById("address2").value = '';
                //(수정) }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                //(수정) + extraAddr를 추가해서 address1에 참고항목이 보여지도록 수정
                document.getElementById("address1").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>
			<!-- 다음 우편번호 API 끝 -->
	</div>
</div>
</body>
</html>