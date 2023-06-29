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
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
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
				alert('수량이 부족합니다');
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
						alert('장바구니에 담았습니다');
						location.href = '../cart/list.do';
					} else if (param.result == 'over_quantity'){
						alert('기존에 주문한 상품입니다. 재고 부족으로 상품을 더 추가할 수 없습니다');
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
		<div class="product-main">
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
			<div>
				<h3 class="product-info">상품 정보</h3>
			</div>
			<div class="item-image">
				<img src="${pageContext.request.contextPath}/upload/${item.item_photo}" width="450" height="450" class="o_image" alt="상품이미지">
			</div>
			<div class="item-detail">
				<form id="item_cart">
					<input type="hidden" name="item_num" value="${item.item_num}" id="item_num">
					<input type="hidden" name="item_price" value="${item.item_price}" id="item_price">
					<input type="hidden" name="item_quantity" value="${item.item_quantity}" id="item_quantity">
					<ul>
						<li class="product-name">${item.item_name}</li>
						<li class="product-detail">가격 : <b><fmt:formatNumber value="${item.item_price}"/>원</b></li>
						<li class="product-detail">재고 : <span><fmt:formatNumber value="${item.item_quantity}"/>개</span></li>
						<c:if test="${item.item_quantity > 0}">
						<li class="product-detail">
							<label for="order_quantity" class="order-quantity">구매 수량</label>
							<input type="number" name="item_count" min="1" max="${item.item_quantity}" autocomplete="off" id="order_quantity" class="quantity-width">
						</li>
						<li class="delivery-notice">
							<span class="delivery">무료 배송</span><br>
							<span class="desc">본 상품은 국내배송만 가능합니다.</span>
						</li>
						<li class="total align-right">
							<span id="item_total_txt">총 주문 금액 : 0원</span>
						</li>
						
						<li class="order-button align-right">
							<input type="submit" value="장바구니에 담기" class="cart-button">
							<input type="button" value="상품 목록" class="list-button" onclick="location.href='${pageContext.request.contextPath}/item/item_list.do'">
							
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
				<div class="detail-list">상세 설명</div>
				<p class="detail">
					${item.item_detail}
				</p>
			</c:if>
		</div>
		<!-- 내용 끝 -->
		<br>
		<!-- 배송안내 시작 -->
		<div class="bottom-notice">
			<div class="order-notice1">
				<h3>배송 안내</h3>
				<ul>
					<li>■ 배송비 : 전 상품 무료배송입니다(산간벽지나 도서지방은 추가 요금이 발생할 수 있음).</li>
					<li>■ 오후 2시 이전의 주문(입금확인)은 당일발송, 다음날 수령하실 수 있습니다.</li>
				</ul>
			</div>
			<div class="order-notice2">
				<h3>교환 및 반품 안내</h3>
				<ul>
					<li>■ 상품 교환 및 반품 가능 기간은 상품 수령일로부터 7일 이내 입니다.</li>
					<li>■ 상품 개봉 또는 사용으로 훼손된 경우 7일 이내라도 교환 및 반품이 불가능합니다.</li>
					<li>■ 고객 변심으로 인한 교환, 반품은 고객께서 배송비를 부담하셔야 합니다. (제품 하자, 배송 오류 제외)</li>
					<li>■ 일부 상품은 새로운 모델 출시, 제조사 사정으로 가격이 변동될 수 있습니다.</li>
					<li>■ 일부 상품의 경우, 인수 뒤 고객 단순변심에 의한 교환, 반품이 불가능할 수 있으니, 상품상세정보를 꼭 참조하시기 바랍니다.</li>
				</ul>
			</div>
		</div>
		<div class="cs">
			<div class="cs-inner">
				<div class="cs-center">
					<h3><img src="../images/support.png" width="25" height="25">고객센터</h3>
					<div class="phone">02)3482-4632</div>
					<div class="office-hour">
						평일: 오전 9시 ~ 오후 8시
						<br>
						점심: 오후 1시 ~ 오후 2시
						<br>
						토요일: 오전 9시 ~ 오후 1시
						<br>
						<b>*주말, 공휴일 휴무</b>
					</div>
				</div>
				<div class="banking-info">
					<h3><img src="../images/passbook.png" width="25" height="25">무통장 입금 계좌</h3>
					<div>
					농협: 300-1234-1234-89
					<br>
					신한: 100-333-123456
					<br>
					국민: 033000-01-012345
					<br>
					하나: 233-123456-77777
					<br><br>
					<b>예금주: 쌍용정형외과</b>
					</div>
				</div>
			</div>
		</div>
		<!-- 배송안내 끝 -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	</div>
</body>
</html>