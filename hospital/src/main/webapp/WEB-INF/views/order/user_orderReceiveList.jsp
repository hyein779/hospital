<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이용자_배송정보</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
</head>
<body>
<div class="page-main">

	<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/memberLnb.jsp"/>
	<!-- header 끝 -->
	
	<!-- content 시작 -->
	<div class="content-main">
	<h3 class="subtitle">배송 정보</h3>
		<!-- 상품 수정 내역 -->
		<hr class="order-hr">
		<br>		
		<form id = "order_form" action="orderReceiveForm.do" method="post">
			<input type="hidden" name="order_num" value="${order.order_num}">
			<ul>
			<li class="delivery_text">* 배송대기인 경우에만 배송정보를 수정하실 있습니다. *</li>
			</ul><br>
			<table>
					<tr>
						<td>
							<label class="order-item">배송상태</label>
						</td>
						<td class="align-left">		
							<c:if test="${order.status == 1}">배송대기</c:if>
							<c:if test="${order.status == 2}">배송준비중</c:if>
							<c:if test="${order.status == 3}">배송중</c:if>
							<c:if test="${order.status == 4}">배송완료</c:if>
							<c:if test="${order.status == 5}">주문취소</c:if>
					    </td>
					</tr> 					
					<tr>
						<td>
							<label class="order-item">받는사람</label>
						</td>
						<td class="align-left">
							${order.receive_name}						
						</td>
					</tr>
					<tr>
						<td>
							<label class="order-item">전화번호</label>
						</td>
						<td class="align-left">
							${order.receive_phone}
						</td>   
					</tr>
					<tr>
						<td>
							<label class="order-item">우편번호</label>
						</td>
						<td class="align-left">
							${order.receive_post}
						</td>
					</tr>
					<tr>
						<td>
							<label class="order-item">주소</label>
						</td>		
						<td class="align-left">
							${order.receive_address1}
						</td>
					</tr>
					<tr>
						<td>
							<label class="order-item">상세주소</label>
						</td>
						<td class="align-left">
							${order.receive_address2}
						</td>
					</tr>
					<tr>
						<td>
							<label class="order-item">메모</label>
						</td>	
						<td class="align-left">
							${order.notice}
						</td>
					</tr>
					<tr>
						<td>
							<label class="order-item">결제수단</label>
						</td>
						<td class="align-left">
							<span class="color-red">
								<c:if test="${order.payment == 1}">&#91; 계좌이체 &#93;</c:if>
								<c:if test="${order.payment == 2}">&#91; 카드결제 &#93;</c:if>
							</span>
						</td>
					</tr>
			</table>		
		</form>
		<div class="align-center">
			<input type="button" id="btn" value="주문내역" 
			       onclick="location.href='${pageContext.request.contextPath}/member/itemList.do'">
			<c:if test="${order.status == 1}">       
			<input type="button" id="btn" value="주문수정" 
			       onclick="location.href='${pageContext.request.contextPath}/order/orderReceiveModify.do?order_num=${order.order_num}'">       
			</c:if>       
       	</div>
		<br>
		<hr class="order-hr"> 
		<br>
	</div>	
	<!-- content 끝 -->
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>