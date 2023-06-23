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
		<jsp:include page="/WEB-INF/views/member/memberLnb.jsp" />
		<!-- 내용 시작 -->
		<div class="content-main">
			<h1 class="logreg">내 주문 목록</h1>
			<!-- 검색창 시작 -->
			<form id="search_form" action="itemList.do" method="get">
				<ul class="search">
					<li><select name="keyfield">
							<option value="1"
								<c:if test="${param.keyfield==1}">selected</c:if>>상품명</option>
					</select></li>
					<li><input type="search" size="25" name="keyword" id="keyword"
						value="${param.keyword}"></li>
					<li><input type="submit" value="검색"></li>
				</ul>
			</form>
			<!-- 검색창 끝 -->
			<div class="list-space align-right">
				<input type="button" value="목록"
					onclick="location.href='${pageContext.request.contextPath}/member/itemList.do'">
				<input type="button" value="홈으로"
					onclick="location.href='${pageContext.request.contextPath}/main/main.do '">
			</div>
			<hr size="1" noshade="noshade" width="80%">
			<c:if test="${count == 0}">
				<div class="result-display">표시할 상품이 없습니다.</div>
			</c:if>
			<c:if test="${count > 0}">
				<table>
					<tr>
						<th>상품명</th>
						<th>주문번호</th>
						<th>결제금액</th>
						<th>주문날짜</th>
						<th>상태</th>
						<th></th>
					</tr>
					<c:forEach var="order" items="${list}">
						<tr>
							<td>${order.order_name}</td>
							<td>${order.order_num}</td>
							<td><fmt:formatNumber value="${order.order_total}" />원</td>
							<td>${order.reg_date}</td>
							<td><c:if test="${order.status == 1}">배송대기</c:if> <c:if
									test="${order.status == 2}">배송준비중</c:if> <c:if
									test="${order.status == 3}">배송중</c:if> <c:if
									test="${order.status == 4}">배송완료</c:if> <c:if
									test="${order.status == 5}">주문취소</c:if></td>
							<td><a href="#">상세</a>
								<a href="">수정</a></td> 
						</tr>
					</c:forEach>
				</table>
				<hr size="1" noshade="noshade" width="80%">
				<div class="align-center">${page}</div>
			</c:if>

		</div>
		<!-- 내용 끝 -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>