<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="lnb" tabindex="0">
	<!-- 의료진/진료과  -->
	
	<h2 class="lnbTitle">관리자 페이지</h2>
	<ul class="depth1">
		<li id="10101"><a href="${pageContext.request.contextPath}/member/adminMemberList.do">회원관리</a></li>
		
		<li id="10106">예약 관리</li>
		<ul class="depth2">
			<li id="10107" >
				<a href="${pageContext.request.contextPath}/member/adminTreatmentList.do">진료 예약 관리</a></li>
			<li id="10108" >
				<a href="${pageContext.request.contextPath}/member/adminTherapyList.do">치료 예약 관리</a></li>
		</ul>
		
		<li id="10109">상품 관리</li>
		<ul class="depth2">
			<li id="10110" >
				<a href="${pageContext.request.contextPath}/item/list.do">상품목록 관리</a></li>
			<li id="10110" >
			<a href="${pageContext.request.contextPath}/order/list.do">회원 구매 관리</a></li>
		</ul>
			
		<li id="10111" >봉사 관리</li>
		<ul class="depth2">
			<li id="10112" >
			<a href="${pageContext.request.contextPath}/member/adminVolList.do">봉사 목록</a></li>
		</ul>
	</ul>
		
</div>