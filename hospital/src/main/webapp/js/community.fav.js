$(function(){	
	//좋아요 등록(및 삭제) 이벤트 처리
	$('.output_fav').click(function(){
		let clicked = $(this);
		$.ajax({
			url:'favWrite.do',
			type:'post',
			data:{rev_num:$(this).attr('data-num')},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인 후 좋아요를 눌러주세요');
				}else if(param.result == 'success'){
					displayFav(param,clicked);
				}else{
					alert('좋아요 표시 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
	
	//좋아요 표시 
	function displayFav(param,clicked){
		let output;
		if(param.status=='noFav'){
			output = '../images/like01.png';
		}else{
			output = '../images/like02.png';
		}
		//문서 객체 설정
		clicked.attr('src',output);
		clicked.parent().find('.output_fcount').text(param.count);
		
	}
});



