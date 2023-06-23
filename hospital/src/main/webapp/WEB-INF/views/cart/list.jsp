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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		// 장바구니 삭제 이벤트
		$('.cart-del').on('click', function(){
			$.ajax({
				url:'deleteCart.do',
				type:'post',
				data:{cart_num:$(this).attr('data-cartnum')},
				dataType:'json',
				success:function(param){
					if (param.result == 'logout'){
						alert('로그인 후 사용하십시오');
					} else if (param.result == 'success'){
						alert('선택한 상품을 삭제했습니다');
						location.href='list.do';
					} else {
						alert('장바구니 상품 삭제 오류');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
		});
		
		// 장바구니 수량 변경 이벤트
		$('.cart-modify').on('click', function(){
			let input_count = $(this).parent().find('input[name="item_count"]');
			if (input_count.val() == ''){
				alert('수랑을 입력하세요');
				input_count.focus();
				return;
			}
			
			if (input_count.val() < 1){
				alert('최소 1부터 입력 가능합니다');
				input_count.val(input_count.attr('value'));
				return;
			}
			
			$.ajax({
				url:'modifyCart.do',
				type:'post',
				data:{cart_num:$(this).attr('data-cartnum'),item_num:$(this).attr('data-itemnum'),item_count:input_count.val()},
				dataType:'json',
				success:function(param){
				 	if (param.result == 'logout'){
				 		alert('로그인 후 사용하세요');
				 	} else if (param.result == 'noSale'){
				 		alert('판매하지 않는 상품입니다');
				 	} else if (param.result == 'noQuantity'){
				 		alert('주문할 수 있는 상품 수량이 부족합니다');
				 	} else if (param.result == 'success'){
				 		alert('상품 수량이 수정되었습니다');
				 		location.href='list.do';
				 	} else {
				 		alert('장바구니 수량 수정 오류');
				 	}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			});
		});
	});
</script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<c:if test="${!empty user_num && user_auth == 2}">
		<jsp:include page="/WEB-INF/views/item/lnb.jsp"/>
		</c:if>
		<c:if test="${!empty user_num && user_auth == 9}">
		<jsp:include page="/WEB-INF/views/member/adminLnb.jsp"/>
		</c:if>
		<!-- 내용 시작 -->
		<div class="product-main">
			<h3 class="subtitle">장바구니</h3>
			<c:if test="${empty list}">
			<div class="result-display message">
				<img src="../images/cart.jpg" width="250" height="250">
				<br>
				<span>장바구니에 담은 상품이 없습니다.</span>	
			</div>
			</c:if>
			<c:if test="${!empty list}">
			<form id="cart_order" action="${pageContext.request.contextPath}/order/orderForm.do" method="post">
				<table>
					<tr>
						<th>상품명</th>
						<th>수량</th>
						<th>상품 가격</th>
						<th>합계</th>
						<th>삭제</th>
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
								<c:if test="${cart.itemVO.item_status != 1 and cart.itemVO.item_quantity >= cart.item_count}">
									<input type="number" name="item_count" min="1" max="${cart.itemVO.item_quantity}" autocomplete="off" value="${cart.item_count}">
									<br>
									<input type="button" value="변경" class="cart-modify" data-cartnum="${cart.cart_num}" data-itemnum="${cart.item_num}">
								</c:if>
							</td>
							<td class="align-center">
								<fmt:formatNumber value="${cart.itemVO.item_price}"/>원
							</td>
							<td class="align-center">
								<fmt:formatNumber value="${cart.sub_total}"/>원
							</td>
							<td class="align-center">
								<input type="button" value="X" class="cart-del" data-cartnum="${cart.cart_num}">
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
		<jsp:include page="/WEB-INF/views/common/footer.jsp"/>  
	</div>
</body>
</html>