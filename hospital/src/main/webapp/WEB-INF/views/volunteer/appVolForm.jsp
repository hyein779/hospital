<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/volunteer.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('.appvolform').submit(function(){
			if($('#name').val().trim()==''){
				alert('이름을 입력하세요');
				$('#name').val('').focus();
				return false;
			}
			if($('#address').val().trim()==''){
				alert('주소를 입력하세요');
				$('#address').val('').focus();
				return false;
			}
			if($('#phone').val().trim()==''){
				alert('휴대폰 번호를 입력하세요');
				$('#phone').val('').focus();
				return false;
			}
			if($('#content').val().trim()==''){
				alert('지원 동기를 입력하세요');
				$('#content').val('').focus();
				return false;
			}
		})
	})
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작  -->
	<jsp:include page="/WEB-INF/views/volunteer/lnb.jsp"/>
	<div class="content-main">
		<h3 class="subtitle">봉사 지원</h3>
		<hr size="2" noshade="noshade" width="100%">
		<div class="align-center">
			<p class="apptitle"><b>자원봉사 지원</b></p>
			<p>모집기간 : ${board.reg_date}</p>
		</div>
		<hr size="2" noshade="noshade" width="100%">
		<form class="appvolform" action="appVolWrite.do" method="post">
			<input type="hidden" name="board_num" value="${board.board_num}">
			<div class="div1">
				<ul>
					<li>
						<label for="name">이름</label>
						<input type="text" size="5" name="name" id="name" maxlength="10">
					</li>
					<li>
						<label for="address">주소</label>
						<input type="text" size="5" name="address" id="address" maxlength="50">
					</li>
					<li>
						<label for="phone">휴대폰</label>
						<input type="text" size="5" name="phone" id="phone">
					</li>
				</ul>
			</div>
			<div class="div2">
				<ul>
					<li>
						<label for="content">지원동기</label>
						<textarea rows="12" cols="80" name="content" id="content"></textarea>
					</li>
					<li>
						<input type="submit" value="지원하기">
						<input type="button" value="뒤로가기" onclick="location.href='volDetail.do'" class="home">
					</li>
				</ul>
			</div>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>