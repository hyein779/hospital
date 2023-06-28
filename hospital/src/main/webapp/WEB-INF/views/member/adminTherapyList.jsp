<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>치료 예약 목록</title>
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
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/adminLnb.jsp"/>
	<!-- 내용 시작 -->
	<div class="content-main">
		<h3 class="myPagest">치료 예약 목록</h3>
		<!-- 검색창 시작 --><!-- action수정해야함 -->
		<form id="search_form" action="noticeList.do" method="get">
			<ul class="search">
				<li>
					<select name="keyfield" id="keyfield">
						<option value="1" <c:if test="${param.keyfield==1}"></c:if>>회원이름</option>
						<option value="2" <c:if test="${param.keyfield==2}"></c:if>>선생님</option>
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
			<input type="button" value="목록" onclick="location.href='adminTherapyList.do'" id="btn_bk"> 
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do '" id="btn_bk">  
		</div>
		<%-- <c:if test="${count == 0}">
		<div class="result-display">
			표시할 진료예약내역이 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">
		<table>
			<tr>
				<th>예약번호</th>
				<th>회원이름</th>
				<th>선생님</th>
				<th>예약날짜</th>
				<th>예약시간</th>
				<th>진료상세</th>
				<th>관리</th>
			</tr>
			<c:forEach var="member" items="${list}">
			<tr>
				<td>${}</td>
				<td>${}</td>
				<td>${}</td>
				<td>${}</td>
				<td>${}</td>
				<c:if test="${member.auth > 0}">
					<td><a href="#" id="bluecolor"><ins>수정</ins></a>
					 / <a href="#" id="redcolor"><ins>삭제</ins></a></td>
				</c:if>
				<c:if test="${member.auth == 0}">
					<td>X</td>
				</c:if>
			</tr>
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
		</c:if> --%>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>