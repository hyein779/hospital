<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진료 예약</title>
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
			<h3 class=subtitle>진료 예약</h3>
		</div>
		<div class="subHeader">
			<h4>의료진 선택</h4>
			<p><a href="${pageContext.request.contextPath}/reservation/select.do">돌아가기</a></p>
		</div>
		<div class="selDoc">
			<form>
				<div class="doc_list">
					<img class="doc_img" src="../images/장원호.jpg">
					<p class="doc_name">장원호 교수</p>
					<p class="doc_cont">
						목, 허리 질환
						<br>
						(목디스크, 경추관절증후군, 허리디스크, 척추압박골절 등)
					</p>  
					<input type="button" class="doc_res" value="예약"  onclick="location.href='${pageContext.request.contextPath}/reservation/careRes.do?doc_num=1'"/>
				</div>
			</form>
			<hr width = "100%" color = "#d6d6d6">
			<form>
			<div class="doc_list">
				<img class="doc_img" src="../images/임유니스.jpg">
				<p class="doc_name">임유니스 교수</p>
				<p class="doc_cont">
					어깨, 팔꿈치 질환
					<br>
					(퇴행성 관절, 관절내시경, 외상성 질환 등)
				</p>
				<input type="button" class="doc_res" value="예약" onclick="location.href='${pageContext.request.contextPath}/reservation/careRes.do?doc_num=2'"/>
			</div>
			</form>
			<hr width = "100%" color = "#d6d6d6">
			<form>
			<div class="doc_list">
				<img class="doc_img" src="../images/이승흠.jpg">
				<p class="doc_name">이승흠 교수</p>
				<p class="doc_cont">
					족관절, 하지 질환
					<br>
					(하지골절, 발목관절경, 근육 및 인대 손상, 무지외반증 등)
				</p>
				<input type="button" class="doc_res" value="예약" onclick="location.href='${pageContext.request.contextPath}/reservation/careRes.do?doc_num=3'"/>
			</div>
			</form>
		</div>
		
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>