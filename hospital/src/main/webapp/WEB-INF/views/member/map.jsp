<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오시는길</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<!-- 내용 시작   -->
		<div class="content-main">
			<h3 class="subtitle">오시는 길</h3>
			<div class="supyung">
				<iframe
					src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3165.366001193884!2d127.0332008!3d37.49928500000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca1c32408f9b7%3A0x4e3761a4f356d1eb!2z7IyN7Jqp6rWQ7Jyh7IS87YSw!5e0!3m2!1sko!2skr!4v1687844793139!5m2!1sko!2skr"
					width="800" height="602" style="border: 0;" allowfullscreen=""
					loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
				<div>
					<ul>
						<h3><img src="../images/clock.png" width="15" height="15">
						진료시간</h3>
						<li><label>평일</label>오전9시 ~ 오후8시</li>
						<li><label>점심시간</label>오후1시 ~ 오후2시</li>
						<li><label>토요일</label>오전9시 ~ 오후1시</li>
						<span>*공휴일 및 일요일 휴무</span>
					</ul>
					<hr size="1" noshade="noshade" width="90%">
					<ul>
						<h3>전화 문의 및 오시는길</h3>
						<h2><img src="../images/phone.png" width="23" height="23"> 02)3482-4632</h2>
						<h4><img src="../images/train.png" width="15" height="15">  지하철 이용시</h4>
						<li><label>역삼역(2호선)</label>3번출구 도보3분 거리</li>
						<li><label>강남역(2호선)</label>1번출구 도보5분거리</li>
						<h4><img src="../images/bus.png" width="15" height="15">  버스 이용시</h4>
						<li><label>역삼역 하차</label>N13, N61, 146,341, 360, 740, 6000</li>
						<li><label>&nbsp;&nbsp;</label>6020, 1100, 1700, 2000, 2000-1,</li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 내용 끝 -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>