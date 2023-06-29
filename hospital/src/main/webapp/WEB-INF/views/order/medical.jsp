<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진료 예약</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/reservation/lnb.jsp"/>
	<!-- content 시작 -->
	<div class="content-main">
		<div class="subContHeader">
			<h3 class=subtitle>의료진</h3>
		</div>
		<div class="medical-int">
			<ul>
				<li class="medical-center">
					<img class="medical-photo" src="../images/장원호.jpg">
				</li>
				<li class="medical-left">
					<b>전문분야</b><br><br>
					목디스크<br>
					경추관절증후군<br>
					허리디스크<br>
					척추압박골절<br>
					<br>
					<b>학력 및 경력</b><br><br>
					서울대학교 의과대학 졸업<br>
					서울대학교 의과대학원 졸업<br>
					서울대학교병원 정형외과 전공의 수료<br>
					정형외과 전문의<br>					
				</li>
				<li class="medical-center">
				<input type="button" class="doc_res" value="예약" onclick="location.href='${pageContext.request.contextPath}/reservation/careRes.do?doc_num=1'"/>
				</li>
			</ul>
		</div>
		<div class='v-line'></div>
		<div class="medical-int">
			<ul>
				<li class="medical-center">
					<img class="medical-photo" src="../images/임유니스.jpg"><br>
				</li>
				<li class="medical-left">
					<b>전문분야</b><br><br>
					퇴행성관절<br>
					관절내시경<br>
					외상성질환<br>
					<br><br>
					<b>학력 및 경력</b><br><br>
					순천향대학교 의과대학 졸업<br>
					순천향대학교 외과대학원 졸업<br>
					정형외과 전공의 수료<br>
					대한정형외과학호 정회원<br>
				</li>
				<li class="medical-center">
				<input type="button" class="doc_res" value="예약" onclick="location.href='${pageContext.request.contextPath}/reservation/careRes.do?doc_num=2'"/>
				</li>
			</ul>
		</div>
		<div class='v-line'></div>
		<div class="medical-int">
			<ul>
				<li class="medical-center">
					<img class="medical-photo" src="../images/이승흠.jpg"><br>
				</li>
				<li class="medical-left">
					<b>전문분야</b><br><br>
					하지골절<br>
					발목관절경<br>
					근육 및 인대 손상<br>
					무지외반증<br>
					<br>
					<b>학력 및 경력</b><br><br>
					원광대학교 의과대학 졸업<br>
					올바른병원 정형외과 전임의<br>
					올바른병원 외래교수<br>
					대한관절학회 정회원<br>	
				</li>
				<li class="medical-center">
				<input type="button" class="doc_res" value="예약" onclick="location.href='${pageContext.request.contextPath}/reservation/careRes.do?doc_num=3'"/>
				</li>
			</ul>
		</div>
</div>
	<!-- content 끝 -->

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	
</div>
</body>
</html>