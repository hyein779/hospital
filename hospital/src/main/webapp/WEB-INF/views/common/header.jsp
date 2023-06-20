<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- header 시작 -->
<div id="main_logo">
	<h1 class="align-center"><a href="${pageContext.request.contextPath}/main/main.do">쌍용 정형외과</a></h1>
</div>
<div class="textright">
		<c:if test="${!empty user_num}">
		<li class="menu-logout">
			[<span>${user_id}</span>]
			<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a>
		</li>
		</c:if>
		<c:if test="${!empty user_num && user_auth == 9}">
			<span><a href="#">관리자 페이지</a></span>
		</c:if>
		<c:if test="${empty user_num}">
			<span><a href="${pageContext.request.contextPath}/member/loginForm.do">로그인</a></span>
			<span><a href="${pageContext.request.contextPath}/member/registerUserForm.do">회원가입</a></span>
		</c:if>
		
		<span><a href="#">오시는길</a></span>
</div>
<div id="main_nav">
		<nav id="main_nav">
			<!-- 메뉴창 -->
			<div class="menuleft">
				<ul class="outer-menu">
				
					<li class = "outer-menu-item">
						<span class="menu-title"><a href="#">병원소개</a></span>
						<ul class="inner-menu">
							<li class="inner-menu-item"><a href="#">병원소개</a></li>
						</ul>
					</li>										
					
					<li class = "outer-menu-item">
						<span class="menu-title"><a href="#">의료진</a></span>
						<ul class="inner-menu">
							<li class="inner-menu-item"><a href="#">의료진 소개</a></li>
						</ul>
					</li>
					
					<li class = "outer-menu-item">
						<span class="menu-title"><a href="#">예약</a></span>
						<ul class="inner-menu">
							<li class="inner-menu-item"><a href="#">진료 예약</a></li>
							<li class="inner-menu-item"><a href="#">치료 예약</a></li>
							<li class="inner-menu-item"><a href="#">예약 관리</a></li>
						</ul>
					</li>										

					<li class = "outer-menu-item">
						<span class="menu-title"><a href="#">공지사항</a></span>
						<ul class="inner-menu">
							<li class="inner-menu-item"><a href="#">공지사항</a></li>
							<li class="inner-menu-item"><a href="#">문의사항</a></li>
							<li class="inner-menu-item"><a href="#">리뷰</a></li>
						</ul>
					</li>						
						
					<li class = "outer-menu-item">
						<span class="menu-title"><a href="#">보조기</a></span>
						<ul class="inner-menu">
							<li class="inner-menu-item"><a href="#">보조기</a></li>
							<li class="inner-menu-item"><a href="#">장바구니</a></li>
						</ul>
					</li>											
					<li class = "outer-menu-item">
						<span class="menu-title"><a href="#">자원봉사</a></span>
						<ul class="inner-menu">
							<li class="inner-menu-item"><a href="#">봉사자 모집</a></li>
							<li class="inner-menu-item"><a href="#">자원봉사 지원</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</nav>
</div> 
<!-- header 끝 -->