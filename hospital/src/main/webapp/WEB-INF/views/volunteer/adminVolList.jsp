<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 목록</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/member.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/volunteer.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
	
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
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<jsp:include page="/WEB-INF/views/member/adminLnb.jsp"/>
		<!-- 내용 시작 -->
		<div class="content-main">
			<h3 class="subtitle">봉사 목록</h3>
			<!-- 검색창 시작 -->
			<form id="search_form" action="adminVolList.do" method="get">
				<ul class="search">
					<li><select name="keyfield" id="keyfield">
							<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>봉사명</option>
							<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>글번호</option>
							<option value="3" <c:if test="${param.keyfield==3}">selected</c:if>>내용</option>
						</select>
					</li>
					<li><input type="search" size="50" name="keyword" id="keyword"
						value="${param.keyword}"></li>
					<li><input type="submit" id="search" value="검색"></li>
				</ul>
			</form>
			<!-- 검색창 끝 -->
			<div class="list-space align-right">
				<input type="button" value="홈으로"
					onclick="location.href='${pageContext.request.contextPath}/main/main.do'" class="submit1">
			</div>
			<c:if test="${count == 0}">
				<div class="result-display">표시할 상품이 없습니다.</div>
			</c:if>
			<c:if test="${count > 0}">
				<table>
					<tr>
						<th>봉사번호</th>
						<th>글 번호</th>
						<th>이름</th>
						<th>주소</th>
						<th>전화번호</th>
						<th>내용</th>
						<th>회원번호</th>
					</tr>
					<c:forEach var="app" items="${list}">
						<tr>
							<td>${app.app_num}</td>
							<td>${app.board_num}</td>
							<td>${app.name}</td>
							<td>${app.address}</td>
							<td>${app.phone}</td>
							<td>${app.content}</td>
							<td>${app.mem_num}</td>
						</tr>
					</c:forEach>
				</table>
				<div class="align-center">${page}</div>
			</c:if>

		</div>
		<!-- 내용 끝 -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>