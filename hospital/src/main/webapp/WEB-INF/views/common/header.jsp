<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- header 시작 -->
<h1 class="main-logo"><a href="${pageContext.request.contextPath}/main/main.do"><img src="../images/logo.png" width="450" height="150"></a></h1>

<div class="textright">
		<!-- 로그아웃 상태 -->
		<c:if test="${empty user_num}">
			<span><a href="${pageContext.request.contextPath}/member/loginForm.do">로그인</a></span> | 
			<span><a href="${pageContext.request.contextPath}/member/registerUserForm.do">회원가입</a></span>
		</c:if>
		
		<!-- 관리자 로그인 -->
		<c:if test="${!empty user_num && user_auth == 9}">
			<li class="main-login">
				<b>[ ${user_id} ]</b> 님 환영합니다 ::
				<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a><br>
			</li>
		</c:if>
		
		<!-- 일반회원 로그인 -->
		<c:if test="${!empty user_num && user_auth == 2}">
			<li class="main-login">
				<b>[ ${user_id} ]</b> 님 환영합니다 ::
				<a href="${pageContext.request.contextPath}/member/logout.do">로그아웃</a><br>
			</li>
		</c:if> 
</div> 

<div id="main_nav">
		<nav id="main_nav">
			<!-- 메뉴창 -->
			<div class="menuleft">
				<ul class="outer-menu">
					<li class = "outer-menu-item">
						<span class="menu-title"><a href="${pageContext.request.contextPath}/order/medical.do">의료진소개</a></span>
					</li>
					
					<li class = "outer-menu-item">
						<span class="menu-title"><a href="${pageContext.request.contextPath}/reservation/select.do">예약</a></span>
						<ul class="inner-menu">
							<li class="inner-menu-item"><a href="${pageContext.request.contextPath}/reservation/care.do">진료 예약</a></li>
							<li class="inner-menu-item"><a href="${pageContext.request.contextPath}/reservation/therapy.do">치료 예약</a></li>
						</ul>
					</li>										

					<li class = "outer-menu-item">
						<span class="menu-title"><a href="#">커뮤니티</a></span>
						<ul class="inner-menu">
							<li class="inner-menu-item"><a href="${pageContext.request.contextPath}/community/noticeList.do">공지사항</a></li>
							<li class="inner-menu-item"><a href="${pageContext.request.contextPath}/community/askList.do">문의사항</a></li>
							<li class="inner-menu-item"><a href="${pageContext.request.contextPath}/community/reviewList.do">리뷰</a></li>
						</ul>
					</li>						
						
					<li class = "outer-menu-item">
						<span class="menu-title"><a href="#">보조기</a></span>
						<ul class="inner-menu">
							<li class="inner-menu-item"><a href="${pageContext.request.contextPath}/item/item_list.do">보조기</a></li>
							<li class="inner-menu-item"><a href="${pageContext.request.contextPath}/cart/list.do">장바구니</a></li>
						</ul>
					</li>											
					<li class = "outer-menu-item">
						<span class="menu-title"><a href="#">자원봉사</a></span>
						<ul class="inner-menu">
							<li class="inner-menu-item"><a href="${pageContext.request.contextPath}/volunteer/volList.do">봉사자 모집</a></li>
						</ul>
					</li> 
					<li class = "outer-menu-item">
						<span class="menu-title"><a href="${pageContext.request.contextPath}/member/map.do">오시는길</a></span>
					</li>	
					<c:if test="${empty user_num || user_auth < 9}">
						<li class = "outer-menu-item">
							<span class="menu-title"><a href="${pageContext.request.contextPath}/member/myPage.do">마이페이지</a></span>
						</li>
					</c:if>
					<c:if test="${!empty user_num && user_auth == 9}">
						<li class = "outer-menu-item">
							<span class="menu-title"><a href="${pageContext.request.contextPath}/member/adminMemberList.do">관리페이지</a></span>
						</li>
					</c:if>					
				</ul>
			</div>
		</nav>
</div> 
<!-- header 끝 -->