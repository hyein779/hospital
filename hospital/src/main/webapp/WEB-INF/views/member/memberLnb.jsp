<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="lnb" tabindex="0">

	<h2 class="lnbTitle">MY page</h2>
	<ul class="depth1">
		<li id="10101">My 회원 정보</li>
		<ul class="depth2">
			<li id="10102" >
				<a href="${pageContext.request.contextPath}/member/myPage.do">내 정보</a></li>
			<li id="10103" >
				<a href="${pageContext.request.contextPath}/member/modifyUserForm.do">회원정보 수정</a></li>
			<li id="10104" >
				<a href="${pageContext.request.contextPath}/member/modifyPasswordForm.do">비밀번호 변경</a></li>
			<li id="10105" >
				<a href="${pageContext.request.contextPath}/member/deleteUserForm.do">회원 탈퇴</a></li>
		</ul>
		
		<li id="10106" >My 병원 예약 정보</li>
		<ul class="depth2">
			<li id="10107" >
				<a href="${pageContext.request.contextPath}/member/userTreatmentForm.do">진료 예약 정보</a></li>
			<li id="10108" >
				<a href="${pageContext.request.contextPath}/member/userTherapyForm.do">치료 예약 정보</a></li>
		</ul>
		
		<li id="10109" >My 주문 정보</li>
		<ul class="depth2">
			<li id="10110" >
			<a href="${pageContext.request.contextPath}/member/itemList.do">내 주문 내역</a></li>
		</ul>
			
		<li id="10111" >My 봉사활동 정보</li>
		<ul class="depth2">
			<li id="10112" >
			<a href="${pageContext.request.contextPath}/volunteer/memberVolList.do">봉사활동 신청 내역</a></li>
		</ul>
	</ul>
		
</div>