<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진료 / 치료 선택</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reservation.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작 -->
	<jsp:include page="/WEB-INF/views/reservation/lnb.jsp"/>
	<div class="content-main">
		<div class="subContHeader">
			<h3 class=subtitle>진료 / 치료 선택</h3>
		</div>
		<div class="type">
			<div class="care">
				<h4><a href="${pageContext.request.contextPath}/reservation/care.do">진료 예약</a></h4>
				<p>
				직접 선택하신 의료진의
				<br>
				진료일정을 확인하실 수
				<br>
				있습니다.
				</p>
			</div>
			<div class="therapy">
				<h4><a href="${pageContext.request.contextPath}/reservation/therapy.do">치료 예약</a></h4>
				<p>
				내원하시면 바로
				<br>
				치료를 받으실 수
				<br>
				있습니다.
				</p>
				<p class="note">
				*의료진과 대면하지
				<br>
				않을 수 있음
				</p>
			</div>
		</div>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>