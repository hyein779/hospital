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
<script type="text/javascript">
	$(function(){
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요');
				$('#keyword').val('').focus();
				return false;
			}
		});
	});
</script>
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/adminLnb.jsp"/>
	<!-- 내용 시작 -->
	<div class="content-main">
		<h3 class="subtitle">진료 예약 목록</h3>
		<!-- 검색창 시작 -->
		<form id="search_form" action="adminCareList.do" method="get">
			<ul class="search">
				<li>
					<select name="keyfield" id="keyfield">
						<option value="1" <c:if test="${param.keyfield==1}"></c:if>>회원</option>
						<option value="2" <c:if test="${param.keyfield==2}"></c:if>>의료진</option>
					</select>
				</li>
				<li>
					<input type="search" size="50" name="keyword" id="keyword" value="${param.keyword}">
				</li>
				<li>
					<input type="submit" id="search" value="검색">
				</li>
			</ul>
		</form>
		<!-- 검색창 끝 -->
		<hr size="1" noshade="noshade" width="100%">
		<div class="list-space align-right">
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do '" id="btn_bk">  
		</div>
		<c:if test="${count == 0}">
		<div class="result-display">
			표시할 진료 예약 내역이 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">
		<table>
			<tr>
				<th>예약번호</th>
				<th>회원</th>
				<th>의료진</th>
				<th>예약날짜</th>
				<th>예약시간</th>
				<th>진료상세</th>
			</tr>
			<c:forEach var="reservation" items="${list}">
			<tr>
				<td>${reservation.res_num}</td>
				<td>${reservation.mem_name}</td>
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