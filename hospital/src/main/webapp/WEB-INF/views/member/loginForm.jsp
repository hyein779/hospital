<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#login_form').submit(function(){
			if($('#id').val().trim()==''){
				alert('아이디를 입력하세요');
				$('#id').val('').focus();
				return false;
			}
			if($('#passwd').val().trim()==''){
				alert('비밀번호를 입력하세요');
				$('#passwd').val('').focus();
				return false;
			}
		});
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작 -->
	<div class="content-main">
		<h1 class="logreg-e">로그인</h1>
		<hr size="1" noshade="noshade" width="40%">
		<form id="login_form" action="login.do" method="post">
			<input type="hidden" name="page_url" value="${page_url}">
			<ul >
				<li>
					<input type="text" name="id" id="id" maxlength="12" autocomplete="off" placeholder=" 아이디를 입력해주세요">
				</li>
				<li>
					<input type="password" name="passwd" id="passwd" maxlength="12" placeholder=" 비밀번호를 입력해주세요">
				</li>
				<li><a href="${pageContext.request.contextPath}/member/registerUserForm.do" id="regigo">회원가입</a></li>
				<li>
					<input type="submit" value="로그인" class="loginbtn">
				</li>
			</ul>
			<div class="align-center">
				
			</div>
		</form>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div> 
</body>
</html>