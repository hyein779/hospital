<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>치료 예약</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reservation.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작 -->
	<jsp:include page="/WEB-INF/views/reservation/lnb.jsp"/>
	<div class="content-main">
		<div class="subContHeader">
			<h3 class=subtitle>치료 예약</h3>
		</div>
		<div class="subHeader">
			<h4>치료 선택</h4>
			<p><a href="${pageContext.request.contextPath}/reservation/select.do">돌아가기</a></p>
		</div><br>
		<div class="therapy-wrap">
			<span class="therapy_img">
				<a href="#"><img src="../images/통증치료.jpg"></a>
			</span>
			<p>
				<span class="therapy-text">
				<b>통증치료</b><br><br>
				반복적인 근수축에 따라 근육 대사를 증진시켜<br>
				통증을 완화시키는 치료
				</span>
			</p>
		</div>
		<div class="therapy-wrap">
			<span class="therapy_img">
				<a href="#"><img src="../images/도수치료.jpg"></a>
			</span>
			<p>
				<span class="therapy-text">
				<b>도수치료</b><br><br>
				손이나 장비 등을 이용하여 전문 물리치료사가<br>
				감각수용체를 직접 자극시키는 치료
				</span>
			</p>
		</div>
		<div class="therapy-wrap">
			<span class="therapy_img">
				<a href="#"><img src="../images/재활치료.jpg"></a>
			</span>
			<p>
				<span class="therapy-text">
				<b>재활치료</b><br><br>
				근육, 관절 등의 인체 조직에 자극을 가하여<br>
				신경을 완화시키는 치료
				</span>
			</p>
		</div>
		<div class="therapy-wrap">
			<span class="therapy_img">
				<a href="#"><img src="../images/특수치료.jpg"></a>
			</span>
			<p>
				<span class="therapy-text">
				<b>특수치료</b><br><br>
				환자에게 알맞은 방법을 선정하여<br>
				체외충격파치료, 극저온자극치료를 시행
				</span>
			</p>
		</div>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>