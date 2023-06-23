<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="lnb" tabindex="0">
	<h2 class="lnbTitle">예약</h2>
	<ul class="depth1">
		<li id="10101">진료 / 치료</li>
		<ul class="depth2">
			<li id="10102" >
				<a href="${pageContext.request.contextPath}/reservation/care.do"  onclick="#">진료예약</a></li>
			<li id="10103" >
				<a href="${pageContext.request.contextPath}/reservation/therapy.do"  onclick="#">치료예약</a></li>
		</ul>
</div>