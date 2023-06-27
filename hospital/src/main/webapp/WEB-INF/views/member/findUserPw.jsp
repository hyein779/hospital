<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<% String passwd = (String)request.getAttribute("passwd"); %>
<c:if test="${check}">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임시비밀번호 발급</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작 -->
	<div class="content-main">
		<div class="result-display">
			<div class="align-center">
				<h3>임시비밀번호 발급</h3>
				<span>회원님의 비밀번호는 <%= passwd %>입니다.</span><br><br><br>
				<input type="button" value="로그인" onclick="location.href='${pageContext.request.contextPath}/member/loginForm.do'">
			</div>
		</div>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
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