<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>
<div class="page-main">
	<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- header 끝 -->
	
	<!-- content 시작 -->
		<div class="content-main">
	
		<img src="../images/병원외관.jpg">
	<div class="content-main-title">
		<h1 class="content-main-title">쌍용 정형외과</h1>
		<p>정형외과는 자세의 유지와 신체 운동에 관계되는 척추, 사지의 뼈, 관절, 근육 및 힘줄, 인대 등의 근골격계 질환을 진료하고 치료합니다.
		   정형외과의 영역은 주로 사지나 몸의 골간을 이루는 부위의 각종 질환과 외상입니다. 즉 뼈, 관절, 근육, 힘줄, 인대 등의 운동 기관을 
		   비롯하여 이것들을 지배하는 혈관, 척수, 말초 신경의 기형과 변형, 염증, 종양, 대사 질환 등의 여러 질환과 골절, 탈구, 염좌, 담열, 
		   타박상 등 외상 진단과 치료를 담당합니다.</p>
		<br><br>
		<p class="content-main-p">정형외과는 정확한 진단, 올바른 치료를 목표로 과도한 검사 없는 진료실	을 운영하고 있으며 
		   환자 각각의 상황에 맞는 맞춤 치료로 건강하고 행복한 100세 시대를 열어갈 수 있도록 합니다.</p>
    </div>
	<div class="content-sub-title1">
		<h2>진료과목</h2>
		<p>풍부한 수술경험과 노하우로 정확한 진단과 치료를 제시합니다.</p>
	   	<table class="table-main">
			<tr>
				<td><img src="../images/목질환.png" width="200" height="200"></td>
				<td><img src="../images/허리질환.png" width="200" height="200"></td>
				<td><img src="../images/어깨질환.png" width="200" height="200"></td>
			</tr>
			<tr>
				<th>목질환</th>
				<th>허리질환</th>
				<th>어깨질환</th>
			</tr>
		</table>	
	</div>
		
	<div class="content-sub-title2">
		<h2 class="content-sub-title">치료종류</h2>
		<p>몸에 부담과 위험이 가장 작은 치료를 제일의 원칙으로 삼고 있습니다.</p>
	   	<table class="table-main">
			<tr>
				<td><img src="../images/도수치료.png" width="200" height="200"></td>
				<td><img src="../images/물리치료.png" width="200" height="200"></td>
				<td><img src="../images/충격파치료.png" width="200" height="200"></td>
			</tr>
			<tr>
				<th>도수치료</th>
				<th>물리치료</th>
				<th>충격파치료</th>
			</tr>
		</table>
	</div>
	</div>
	<!-- content 끝 -->
	
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>




