<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/main.css">
<style>
@import
	url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap')
	;
</style>
</head>
<body>
	<div class="page-main"></div>
	<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<!-- header 끝 -->

	<!-- content 시작 -->
	<div class="main-img">
		<img src="../images/병원외관.jpg">
	</div>
	<div class="main">
		<h1 class="main-content-title">쌍용 정형외과의 특색</h1>
		<div class="main-div">
			<img src="${pageContext.request.contextPath}/images/main02.jpg">
			<div class="main-div-content">
				<ul>
					<h3 class="main-content-subtitle">1. 노하우로 축적된 비수술 치료</h3>
					<li class="main-content">비수술적 치료에는 물리치료, 도수치료, 주사치료, 약물치료,
						고정치료 등이 있습니다. 쌍용 정형외과는 주사 치료의 남용을 방지하려고 노력하고 있습니다. 본원은 목, 척추, 어깨에
						관하여 <span class="highlight">비수술적 치료를 지향</span>하며, 치료 방법에 있어서 어떤 병원보다 많은 노하우를 가지고 있습니다.</li>
				</ul>
			</div>
		</div><br>
		<div class="main-div">
			<div class="main-div-content">
				<ul>
					<h3 class="main-content-subtitle">2. 다양한 수술 경험</h3>
					<li class="main-content">비수술적 치료를 우선으로 하지만 그 자신감은 <span class="highlight">풍부한 수술 경험</span>에
						있습니다. 본원 의료진들은 다년간의 수술에 참여하였으며, 그만큼 폭넓은 지식이 있기 때문에 필요한 경우가 아니라면
						비수술적 치료에 초점을 둡니다.</li>
				</ul>
			</div>
			<img src="${pageContext.request.contextPath}/images/main03.png">
		</div><br>
		<div class="main-div">
			<img src="${pageContext.request.contextPath}/images/main01.png">
			<div class="main-div-content">
				<ul>
					<h3 class="main-content-subtitle">3. 환자 맞춤형 상담과 치료</h3>
					<li class="main-content">환자가 최대한 이해할 수 있도록 <span class="highlight">환자의 상태를 어렵거나 복잡하지
						않게 설명</span>합니다. 또한, 수술로 치료했을 경우와 비수술로 치료했을 경우의 차이점, 수술 난이도나 위험성도 환자에게
						상세하게 제시합니다.</li>
				</ul>
			</div>
		</div>
		
		<div class="content-sub">
		<h2 class="content-sub-title">진료과목</h2>
		<p>해당 분야에 숙련된 의료진들이 풍부한 수술경험과 노하우로 정확한 진단과 치료를 제시합니다.</p>
	   		<div class="disease-main">
				<ul>
					<li class="box">
						<img src="../images/neck.png" width="200" height="200">
						<p>목질환</p>
					</li>
					<li class="box">
						<img src="../images/hurt.png" width="200" height="200">
						<p>허리질환</p>
					</li>
					<li class="box">
						<img src="../images/body.png" width="200" height="200">
						<p>어깨질환</p>
					</li>
				</ul>							
			</div>	
		</div>
	</div>
	<!-- <div class="main">
		<h1 class="content-main-title">쌍용 정형외과</h1>
		<p>정형외과는 자세의 유지와 신체 운동에 관계되는 척추, 사지의 뼈, 관절, 근육 및 힘줄, 인대 등의 근골격계 질환을 진료하고 치료합니다.
		   정형외과의 영역은 주로 사지나 몸의 골간을 이루는 부위의 각종 질환과 외상입니다. 즉 뼈, 관절, 근육, 힘줄, 인대 등의 운동 기관을 
		   비롯하여 이것들을 지배하는 혈관, 척수, 말초 신경의 기형과 변형, 염증, 종양, 대사 질환 등의 여러 질환과 골절, 탈구, 염좌, 담열, 
		   타박상 등 외상 진단과 치료를 담당합니다.</p>
		<br><br>
		<p class="content-main-p">정형외과는 정확한 진단, 올바른 치료를 목표로 과도한 검사 없는 진료실	을 운영하고 있으며 
		   환자 각각의 상황에 맞는 맞춤 치료로 건강하고 행복한 100세 시대를 열어갈 수 있도록 합니다.</p>
    </div>
	
	<div class="content-sub2">
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
	</div> -->
	<!-- content 끝 -->

	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<!-- footer 끝 -->
	</div>
</body>
</html>