<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자상세목록_admin_listForm</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<!-- 관리자 : 수정 및 상세 내역 -->
<div class="page-main">

	<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/adminLnb.jsp"/>
	<!-- header 끝 -->
	
	<!-- content 시작 -->
	<div class="content-main">
	<h3 class="subtitle">주문 내역</h3>
		<!-- 상품 상세 내역 -->
		<hr class="order-hr">
		<br>
		<table class="order-table">
			<tr class="admin-item">
				<th>상품명</th>
				<th>수량</th>	
				<th>상품가격</th>
				<th>합계</th>
			</tr>
			<c:forEach var="detail" items="${detailList}">
				<tr class="admin-subitem">
					<td class="align-center">${detail.order_name}</td>
					<td class="align-center">
						<fmt:formatNumber value="${detail.order_quantity}"/>
					</td>
					<td class="align-center">
						<fmt:formatNumber value="${detail.item_price}"/>원
					</td>
					<td class="align-center">
						<fmt:formatNumber value="${detail.item_total}"/>원
					</td>
				</tr>
			</c:forEach>
			<tr class="color-red">
				<td colspan="2"></td>
				<td class="align-center"><b>총 구매 금액</b></td>
				<td class="align-center">
					<fmt:formatNumber value="${order.order_total}"/>원
				</td>
			</tr>
		</table>  
		<br>
		<div class="align-center">
			<input type="button" value="목록" 
				   onclick="location.href='list.do'">
			<input type="button" value="홈으로" 
				   onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
	</div>	 
	<!-- content 끝 -->
	
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>