<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${check}">
	<!DOCTYPE html>
	<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<!-- 내용 시작 -->
		<div class="content-main">
			<div class="result-display">
				<div class="align-center">
					<h3>아이디 찾기</h3>
					<span>회원님의 아이디는 ${id}입니다.
					</span><br>
					<br>
					<br> <input type="button" value="로그인" 
						onclick="location.href='${pageContext.request.contextPath}/member/loginForm.do'">
				</div>
			</div>
		</div>
		<!-- 내용 끝 -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
	</html>
</c:if>
<c:if test="${!check}">
	<script>
		alert('입력하신 정보와 일치하는 회원 정보가 없습니다.');
		history.go(-1);
	</script>
</c:if>