<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진료 예약 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/memberLnb.jsp"/>
	<!-- 내용 시작 -->
	<div class="content-main">
		<h3 class="subtitle">진료 예약 목록</h3>
		<hr size="1" noshade="noshade" width="100%">
		<c:if test="${count == 0}">
		<div class="result-display">
			진료 예약 내역이 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">
		<table>
			<tr>
				<th>예약번호</th>
				<th>의료진명</th>
				<th>진료 예약 날짜</th>
				<th>진료 예약 시간</th>
				<th>증상 설명</th>
			</tr>
			<c:forEach var="reservation" items="${list}">
			<tr>
				<td>${reservation.res_num}</td>
				<td>${reservation.doc_name}</td>
				<td>${reservation.res_date}</td>
				<td>${reservation.res_time}</td>
				<td>${reservation.res_content}</td>
			</tr>
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
		</c:if>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>