<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="lnb" tabindex="0">
	<!-- 의료진/진료과  -->
	
	<h2 class="lnbTitle">관리자 페이지</h2>
	<ul class="depth1">
		<li id="10101"><a href="#">회원관리</a></li>
		<!-- <ul class="depth2">
			<li id="10102" >
				<a href="#"  onclick="#">내 정보</a></li>
			<li id="10103" >
				<a href="#"  onclick="#">회원정보 수정</a></li>
			<li id="10104" >
				<a href="#"  onclick="#">비밀번호 변경</a></li>
			<li id="10105" >
				<a href="#"  onclick="#">회원 탈퇴</a></li>
		</ul> -->
		
		<li id="10106">예약 관리</li>
		<ul class="depth2">
			<li id="10107" >
				<a href="#"  onclick="#">진료 예약 관리</a></li>
			<li id="10108" >
				<a href="#"  onclick="#">치료 예약 관리</a></li>
		</ul>
		
		<li id="10109" >상품 관리</li>
		<ul class="depth2">
			<li id="10110" >
				<a href="${pageContext.request.contextPath}/item/writeForm.do">상품 등록</a></li>
			<li id="10110" >
			<a href="#"  onclick="#">회원 구매 관리</a></li>
		</ul>
			
		<li id="10111" >봉사 관리</li>
		<ul class="depth2">
			<li id="10112" >
			<a href="#"  onclick="#">목록</a></li>
		</ul>
	</ul>
		
</div>