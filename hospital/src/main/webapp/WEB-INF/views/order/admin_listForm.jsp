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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<!-- 관리자 : 수정 및 상세 내역 -->
<div class="page-main">
	<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- header 끝 -->
	<!-- content 시작 -->
	<div class="content-main">
	<h2>주문 상세 정보</h2>
		<!-- 상품 상세 내역 -->
		<table>
			<tr>
				<td>상품명</td>
				<td>수량</td>	
				<td>상품가격</td>
				<td>합계</td>
			</tr>
		<c:forEach var="detail" items="${detailList}">
			<tr>
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
			<tr>
				<td colspan="3" class="align-right"><b>총 구매 금액</b></td>
				<td class="align-center">
					<fmt:formatNumber value="${order.order_total}"/>원
				</td>
			</tr>
		</table>
		
		<!-- 상품 수정 내역 -->
	</div>	
	<!-- content 끝 -->
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>