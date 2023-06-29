<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){

		// 비밀번호 수정 유효성 체크
		$('#password_form').submit(function(){
			let items = document.querySelectorAll('input[type="text"],input[type="password"]');
			for(let i=0;i<items.length;i++){
				if(items[i].value.trim()==''){
					let label = document.querySelector('label[for="'+items[i].id+'"]');
					alert(label.textContent + ' 항목 필수 입력');
					items[i].value = '';
					items[i].focus();
					return false;
				}//end of if
			}//end of for
			if($('#passwd').val()!=$('#cpasswd').val()){
				alert('새비밀번호와 새비밀번호확인이 불일치합니다.');
				$('#passwd').val('').focus();
				$('#cpasswd').val('');
				return false;
			}
		});//end of submit
	});
</script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<jsp:include page="/WEB-INF/views/member/memberLnb.jsp"/>
		<!-- 내용 시작 -->
		<div class="content-main">
			<h3 class="myPagest">비밀번호 변경</h3>
			<hr size="1" noshade="noshade" width="90%">
			<form id="password_form" action="modifyPassword.do" method="post">
				<ul>
					<li>
						<label for="id">아이디</label>
						<input type="text" name="id" id="id" maxlength="12" autocomplete="off">
					</li>
					<li>
						<label for="origin_passwd">현재 비밀번호</label>
						<input type="password" name="origin_passwd" id="origin_passwd" maxlength="12">
					</li>
					<li>
						<label for="passwd">새 비밀번호</label>
						<input type="password" name="passwd" id="passwd" maxlength="12">
					</li>
					<li>
						<label for="cpasswd">새 비밀번호 확인</label>
						<input type="password" name="cpasswd" id="cpasswd" maxlength="12">
					</li>
				</ul>
				<div class="align-center">
					<input type="submit" value="비밀번호 수정" id="btn_bk">
					<input type="button" value="MY페이지" onclick="location.href='myPage.do'" id="btn_w">
				</div>
			</form>
		</div>
		<!-- 내용 끝 -->
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>