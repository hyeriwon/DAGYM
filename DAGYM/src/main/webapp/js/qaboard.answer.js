/*----------댓글 등록----------*/

/*----------댓글 수정----------*/
$(document).ready(function(){
	$(document).on('click','#update_answer_btn', function(){
		//댓글번호..?
		var answer_num = "${answerBoard.qab_num}";
		//접근할 태그
		  let answerContent = $(this).closest('#answer-div').find('p').text().replace(/<br>/gi,'\n');
	
		let modifyUI = '<form id="mre_form">';
		modifyUI += '<input type="hidden" name="re_num" id="mre_num" value="' + answer_num + '">';
		modifyUI += '<textarea rows="3" cols="50" name="re_content" '
						+'id="mre_content" class="rep-content">'+answerContent+'</textarea>';
		modifyUI += '<div id="mre_second" class="align-right">';
		modifyUI += '<input type="submit" value="수정">';
		modifyUI += '<input type="button" value="취소" class="re-reset">';
		modifyUI += '</div>';
		modifyUI += '<hr size="1" noshade width="96%">';
		modifyUI += '</form>';
		
		// 기존 댓글 내용을 수정 폼으로 대체
        $('#answer-div').html(modifyUI);
    });
	
	  $(document).on('submit', '#mre_form', function(event){
        event.preventDefault();

        // 수정된 댓글 내용
        let qab_num = $('#answer_num').val();
        let qab_content = $('#answer_content').val();

        // AJAX 요청
        $.ajax({
            url: 'adminUpdateAnswer.do',
            type: 'POST',
            data: { qab_num: qab_num, qab_content: qab_content },
            dataType: 'json',
            success: function(data) {
                if (data.result == 'WEB-INF/member/loginForm.do') {
                    alert('로그인이 필요합니다.');
                    window.location.href = 'login.jsp';
                } else if (data.result === 'success') {
                    alert('답변이 성공적으로 업데이트되었습니다.');
                    location.reload();
                } else if (data.result === 'wrongAccess') {
                    alert('권한이 없습니다.');
                } else {
                    alert('오류가 발생했습니다.');
                }
            },
            error: function() {
                alert('서버와의 통신 중 오류가 발생했습니다.');
            }
        });
    });

    // 수정 폼 취소 버튼 클릭 시 원래 상태로 복원
    $(document).on('click', '.re-reset', function(){
        location.reload();
    });
});//end of document