<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>안내</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작 -->
	<div class="content-main">
		<h3 class="subtitle">안내</h3>
		<div class="result-display">
			<div class="align-center">
				<c:if test="${!empty accessMsg}">
					${accessMsg}
				</c:if>
				<c:if test="${empty accessMsg}">
				<div class="result-display message">
					<img src="../images/cancel.jpg" width="250" height="250">
					<br>
					<span>잘못된 접속입니다.</span>
				</div>
				</c:if>
				<p>
				<c:if test="${!empty accessUrl}">
				<input type="button" value="이동"
				  onclick="location.href='${accessUrl}'">
				</c:if>
				<c:if test="${empty accessUrl}">
				<input type="button" value="이동"
				 onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
				</c:if>
			</div>
		</div>
	</div>
	<!-- 내용 끝 -->
</div>
</body>
</html>



