<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){

		// 비밀번호 수정 유효성 체크
		$('#findUserPw_form').submit(function(){
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
		});//end of submit
	});
</script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<!-- 내용 시작 -->
		<div class="content-mainn">
			<h2 class="logreg-e">비밀번호 재설정</h2>
			<hr size="1" noshade="noshade" width="50%">
			<form id="findUserPw_form" action="findUserPw.do" method="post">
				<ul>
					<li>
						<label for="id">아이디</label>
						<input type="text" name="id" id="id" maxlength="10" placeholder=" 아이디를 입력해주세요">
					</li>
					<li>
						<label for="name">이름</label>
						<input type="text" name="name" id="name" maxlength="10" placeholder=" 이름을 입력해주세요">
					</li>
					<li>
						<label for="phone">전화번호</label>
						<input type="text" name="phone" id="phone" maxlength="15" placeholder=" ex.01012345678">
					</li>			
				</ul>
				<div class="align-center">
					<input type="submit" value="비밀번호찾기" id="btn_bk">
					<input type="button" value="로그인" onclick="location.href='loginForm.do'" id="btn_w">
				</div>
			</form>
		</div>
		<!-- 내용 끝 -->
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>