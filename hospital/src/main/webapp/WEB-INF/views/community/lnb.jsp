<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
<div id="lnb" tabindex="0">
	<!-- 의료진/진료과  -->
	
	<h2 class="lnbTitle">커뮤니티</h2>
	<ul class="depth1">
		<li id="10101"><a href="${pageContext.request.contextPath}/community/noticeList.do" onclick="#">공지사항</a></li>		
		<li id="10106" ><a href="${pageContext.request.contextPath}/community/askList.do" onclick="#">문의사항</a></li>
		<li id="10109" ><a href="${pageContext.request.contextPath}/community/reviewList.do" onclick="#">리뷰</a></li>
	</ul>
		
</div>