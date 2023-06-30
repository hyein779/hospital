<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이용자_주문상세</title>
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
		        alert(label.textContent + ' 항목을 입력해주세요.');
		        items[i].value = '';
		        items[i].focus();
		        return false;
	        }
	        
			if(!/^\d{11}$/.test($('#receive_phone').val())){
				alert('하이픈(-)을 제거하고 작성해주세요(ex.01012345678)');
				$('#phone').val('');
				$('#phone').focus();
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
		<h3 class="subtitle">주문 상세</h3>
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
		<input type="button" id="btn" value="주문내역" 
			       onclick="location.href='${pageContext.request.contextPath}/member/itemList.do'">
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