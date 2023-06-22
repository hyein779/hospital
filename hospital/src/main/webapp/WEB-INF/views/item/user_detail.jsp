<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 정보</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#order_quantity').on('keyup mouseup', function(){
			if ($('#order_quantity').val() == ''){
				$('#item_total_txt').text('총 주문 금액: 0원');
				return;
			}
			
			if ($('#order_quantity').val() <= 0){
				$('#order_quantity').val('');
				return;
			}
			
			if (Number($('#item_quantity').val()) < $('#order_quantity').val()){ 
				alert('수량이 부족합니다.');
				$('#order_quantity').val('');
				$('#item_total_txt').text('총 주문 금액: 0원');
				return;
			}
			
			// 총 주문 금액
			let total  = $('#item_price').val() * $('#order_quantity').val();
			$('#item_total_txt').text('총 주문 금액: ' + total.toLocaleString() + '원'); 
		});
		
		// 장바구니에 상품 담기
		$('#item_cart').submit(function(event){
			// 기본 이벤트 제거
			event.preventDefault();
			
			if ($('#order_quantity').val() == ''){
				alert('수량을 입력하세요');
				$('#order_quantity').focus();
				return false;
			}
			
			let form_data = $(this).serialize();
			
			$.ajax({
				url:'../cart/write.do',
				type:'post',
				data:form_data,
				dataType:'json',
				success:function(param){
					if (param.result == 'logout'){
						alert('로그인 후 사용하세요');
					} else if (param.result == 'success'){
						alert('장바구니에 담았습니다.');
						location.href = '../cart/list.do';
					} else if (param.result == 'over_quantity'){
						alert('기존에 주문한 상품입니다. 개수를 추가하면 재고가 부족합니다.');
					} else {
						alert('장바구니 담기 오류');
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
		<!-- 내용 시작 -->
		<div class="content-main">
			<c:if test="${item.item_status == 1}">
			<div class="result-display">
				<div class="align-center">
					본 상품은 판매 중지되었습니다.
					<p>
					<input type="button" value="판매상품 보기" onclick="location.href='itemList.do'">
				</div>
			</div>
			</c:if>
			<c:if test="${item.item_status == 2}">
			<h3>${item.item_name}</h3>
				<div class="item-image">
					<img src="${pageContext.request.contextPath}/upload/${item.item_photo}" width="400">
				</div>
				<div class="item-detail">
					<form id="item_cart">
						<input type="hidden" name="item_num" value="${item.item_num}" id="item_num">
						<input type="hidden" name="item_price" value="${item.item_price}" id="item_price">
						<input type="hidden" name="item_quantity" value="${item.item_quantity}" id="item_quantity">
						<ul>
							<li>가격 : <b><fmt:formatNumber value="${item.item_price}"/>원</b></li>
							<li>재고 : <span><fmt:formatNumber value="${item.item_quantity}"/>개</span></li>
							<c:if test="${item.item_quantity > 0}">
							<li>
								<label for="order_quantity">구매 수량</label>
								<input type="number" name="order_quantity" min="1" max="${item.item_quantity}" autocomplete="off" id="order_quantity" class="quantity-width">
							</li>
							<li>
								<span id="item_total_txt">총 주문 금액 : 0원</span>
							</li>
							<li class="align-right">
								<input type="button" value="주문" onclick="location.href='#'">
								<input type="submit" value="장바구니에 담기">
							</li>
							</c:if>
							<c:if test="${item.item_quantity <= 0}">
							<li class="align-center">
								<span class="sold-out">품절</span>
							</li>
							</c:if>
						</ul>
					</form>
				</div>
				<hr size="1" noshade="noshade" width="100%">
				<p>
					${item.item_detail}
				</p>
			</c:if>
		</div>
		<!-- 내용 끝 -->
	</div>
</body>
</html>