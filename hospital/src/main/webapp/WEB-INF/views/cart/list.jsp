<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<jsp:include page="/WEB-INF/views/common/lnb.jsp"/>
		<!-- 내용 시작 -->
		<div class="content-main">
			<h2>장바구니</h2>
			<c:if test="${empty list}">
			<div class="result-display">
				장바구니에 담은 상품이 없습니다.
			</div>
			</c:if>
			<c:if test="${!empty list}">
			<form id="cart_order" action="${pageContext.request.contextPath}/order/orderForm.do" method="post">
				<table>
					<tr>
						<th>상품명</th>
						<th>수량</th>
						<th>상품 가격</th>
					</tr>
					<c:forEach var="cart" items="${list}">
						<tr>
							<td>
								<a href="${pageContext.request.contextPath}/item/detail.do?item_num=${cart.item_num}">
									<img src="${pageContext.request.contextPath}/upload/${cart.itemVO.item_photo}" width="80">
									${cart.itemVO.item_name}
								</a>
							</td>
							<td class="align-center">
								<c:if test="${cart.itemVO.item_status == 1 or cart.itemVO.item_quantity < cart.item_count}">[판매 중지]</c:if>
								<c:if test="${cart.itemVO.item_status != 1 or cart.itemVO.item_quantity > cart.item_count}">
									<input type="number" name="item_count" min="1" max="${cart.itemVO.item_quantity}" autocomplete="off" value="${cart.item_count}">
									<br>
									<input type="button" value="변경" class="cart-modify" data-cartnum="${cart.cart_num}" data-itemnum="${cart.item_num}">
								</c:if>
							</td>
							<td class="align-center">
								<fmt:formatNumber value="${cart.itemVO.item_price}"/>원
							</td>
						</tr>
					</c:forEach>
				</table>
				<div class="align-right">
					<span><b>총 금액 : </b><fmt:formatNumber value="${all_total}"/>원</span>
					<input type="submit" value="주문">
				</div>
			</form>
			</c:if>
		</div>
		<!-- 내용 끝 -->
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>