<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[이용자]구매내역_user_modifyForm</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css">
<c:if test="${order.status < 2}">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//상품주문 정보 등록 유효성 체크
		$('#order_form').submit(function(){
  	let items = document.querySelectorAll('input[type="text"]');
  	
      	for(let i=0;i<items.length;i++){
	        if(items[i].value.trim()==''){
				let label = document.querySelector('label[for="'+items[i].id+'"]');
		        alert(label.textContent + ' 항목을 입력하세요.');
		        items[i].value = '';
		        items[i].focus();
		        return false;
	        }
     	}//end of for	
     	
		});//end of submit
})//end of function	
</script>
</c:if>
</head>
<body>
<div class="page-main">
	<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/memberLnb.jsp"/>
	<!-- header 끝 -->
	<!-- content 시작 -->
	<div class="content-main">
		<h3 class="subtitle">주문내역</h3>
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
				<tr>
					<td>${detail.order_name}</td>
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
		<hr class="order-hr">
		<h3 class="subtitle">배송정보</h3>
		<form id = "order_form" action="orderModify.do" method="post">
			<input type="hidden" name="order_num" value="${order.order_num}">
			<input type="hidden" name="status" value="${order.status}">
			<ul class="order-modifyform-item">
				<!-- status가 2일때 정보를 변경할 수  있음. -->
				<c:if test="${order.status < 2}">
				<!-- 사용하기 편하게 하기 위한 추가 문구 -->
				<li class="delivery_text">* 배송대기인 경우에만 배송정보를 수정하실 있습니다. *</li>
				<br>
				<table>
					<tr>
						<td>
							<label for="receive_name">받는사람</label></td>
						<td>						
							<input type="text" name="receive_name" id="receive_name"
								   maxlength="10" value="${order.receive_name}">
					    </td>
					</tr>
					<tr>
						<td>
							<label for="receive_phone">전화번호</label></td>
						<td>
						<input type="text" name="receive_phone" id="receive_phone"
							   maxlength="15" value="${order.receive_phone}">						
						</td>
					</tr>
					<tr>
						<td>
							<label for="zipcode">우편번호</label>
						<td>
						<input type="text" name="receive_post" id="zipcode"
						   maxlength="5" value="${order.receive_post}">
						<input type="button" value="우편번호 찾기" 
					       onclick="execDaumPostcode()">						
						</td>
					</tr>
					<tr>
						<td>
							<label for="receive_address1">주소</label>
						<td>
						<input type="text" name="receive_address1" id="address1"
						  	   maxlength="30" value="${order.receive_address1}">						
						</td>
					</tr>
					<tr>
						<td>
							<label for="receive_address2">상세주소</label>
						<td>
						<input type="text" name="receive_address2" id="receive_address2"
					 		   maxlength="30" value="${order.receive_address2}">						
						</td>
					</tr>
					<tr>
						<td>
							<label for="notice">메모</label>
						<td>
						<textarea rows="5" cols="42" name="notice" id="notice"
			        			  maxlength="1300" class="order-text">${order.notice}</textarea>					
						</td>
					</tr>
				</table>				
				</c:if>
				<c:if test="${order.status >= 2}">
					<li>
						<label class="order-item">받는사람</label>
						${order.receive_name}
					</li>
					<li>
						<label class="order-item">전화번호</label>
						${order.receive_phone}
					</li>					
					<li>
						<label class="order-item">우편번호</label>
						${order.receive_post}
					</li>
					<li>
						<label class="order-item">주소</label>
						${order.receive_address1}
					</li>					
					<li>
						<label class="order-item">상세주소</label>
						${order.receive_address2}
					</li>					
					<li>
						<label class="order-item">메모</label>
						${order.notice}
					</li>					
				</c:if>					
					<li>
						<label class="order-item">결제수단</label>
						<span class="color-red">
							<c:if test="${order.payment == 1}">계좌이체</c:if>
							<c:if test="${order.payment == 2}">카드결제</c:if>
						</span>
					</li>
					<li>
						<label class="order-item">배송상태</label>
						<span class="color-red">
							<c:if test="${order.status == 1}">배송대기</c:if>
							<c:if test="${order.status == 2}">배송준비중</c:if>
							<c:if test="${order.status == 3}">배송중</c:if>
							<c:if test="${order.status == 4}">배송완료</c:if>
							<c:if test="${order.status == 5}">주문취소</c:if>
						</span>
					</li>
			</ul>
		<div class="align-center">
			<c:if test="${order.status < 2}">	 		
				<input type="submit"  id="btn" value="주문수정">
				<input type="button" value="주문취소" id="order_cancel">
				
				<script>
					let order_cancel = document.getElementById('order_cancel');
					order_cancel.onclick=function(){
						let choice = confirm('주문을 취소하시겠습니까?');
						if(choice){
							location.replace('orderCancel.do?order_num=${order.order_num}');								
						}
				}
				</script>
			</c:if>
			<input type="button" id="btn" value="주문내역" onclick="location.href='${pageContext.request.contextPath}/member/itemList.do'">
			       
		</div>
		</form>
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