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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css">
<c:if test="${order.status < 2}">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		//유효성 체크
		('#order_modify').submit(function(){
			let items = document.querySelectorAll('input[type="text"]');
			
			if($('#input[type=radio]:checked').val() == 1){ 
				for(let i=0; i<items.length; i++){
					if(items[i].value.trim()==''){
						let label = document.querySelector('label[for="'+items[i].id+'"]');
						alert(label.textContent + ' 항목 필수 입력');
						items[i].value = '';
						items[i].focus();
						return false;
					}
				}//end of for
			}//end of if
		})//end of submit
		
		let origin_status = ${order.status};
		$('input[type=radio]').click(function(){
			if(origin_status == 1 && $('input[type=radio]:checked').val() != 1){
				$('.modify-hidden').hide();
			}else{
				$('.modify-hidden').show();
			}
		});//end of click
	});
</script>
</c:if>
</head>
<body>
<div class="page-main">
	<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- header 끝 -->
	<!-- content 시작 -->
	<div class="content-main">
		<h2>주문내역</h2>
		<table>
			<tr>
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
			<tr>
				<td colspan="3" class="align-right"><b>총 구매 금액</b></td>
				<td class="align-center">
					<fmt:formatNumber value="${order.order_total}"/>원
				</td>
			</tr>
		</table>
		<form id = "order_modify" action="orderModify.do" method="post">
			<input type="hidden" name="order_num" value="${order.order_num}">
			<input type="hidden" name="status" value="${order.status}">
			<ul>
				<!-- status가 2일때 정보를 변경할 수  있음. -->
				<c:if test="${order.status < 2}">
				<!-- 사용하기 편하게 하기 위한 추가 문구 -->
				<li>
					<span id="delivery_text">*배송대기일 경우만 배송관련 정보를 수정할 수 있습니다.</span>
				</li>
					<li>
						<label for="receive_name">받는사람</label>
						<input type="text" name="receive_name" id="receive_name"
							   maxlength="10" value="${order.receive_name}">
					</li>
					<li>
						<label for="receive_phone">전화번호</label>
						<input type="text" name="receive_phone" id="receive_phone"
							   maxlength="15" value="${order.receive_phone}">
					</li>
					<li>
						<label for="zipcode">우편번호</label>
						<input type="text" name="receive_post" id="zipcode"
							   maxlength="5" value="${order.receive_post}">
						<input type="button" value="우편번호 찾기" 
						       onclick="execDaumPostcode()">						   
					</li>
					<li>
						<label for="receive_address1">주소</label>
						<input type="text" name="receive_address1" id="address1"
							   maxlength="30" value="${order.receive_address1}">
					</li>
					<li>
						<label for="receive_address2">상세주소</label>
						<input type="text" name="receive_address2" id="address2"
							   maxlength="30" value="${order.receive_address2}">
					</li>
					<li>
						<label for="notice">메모
						</label>
						<textarea rows="5" cols="30" name="notice" id="notice"
					          maxlength="1300">${order.notice}</textarea>
					</li>
				</c:if>
				<c:if test="${order.status >= 2}">
					<li>
						<label>받는사람</label>
						${order.receive_name}
					</li>
					<li>
						<label>전화번호</label>
						${order.receive_phone}
					</li>					
					<li>
						<label>우편번호</label>
						${order.receive_post}
					</li>
					<li>
						<label>주소</label>
						${order.receive_address1}
					</li>					
					<li>
						<label>상세주소</label>
						${order.receive_address2}
					</li>					
					<li>
						<label>메모</label>
						${order.notice}
					</li>					
				</c:if>					
					<li>
						<label>결제 수단</label>
						<c:if test="${order.payment == 1}">계좌이체</c:if>
						<c:if test="${order.payment == 2}">카드결제</c:if>
					</li>
					<li>
						<label>배송상태</label>
						<c:if test="${order.status == 1}">배송대기</c:if>
						<c:if test="${order.status == 2}">배송준비중</c:if>
						<c:if test="${order.status == 3}">배송중</c:if>
						<c:if test="${order.status == 4}">배송완료</c:if>
						<c:if test="${order.status == 5}">주문취소</c:if>
					</li>
			</ul>
		<div class="align-center">
			<c:if test="${order.status < 2}">			
				<input type="submit" value="주문수정">
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
			<input type="button" value="주문내역" onclick="location.href='${pageContext.request.contextPath}/member/itemList.do'">
			       
		</div>
		</form>
	</div>
		
	<!-- content 끝 -->
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>