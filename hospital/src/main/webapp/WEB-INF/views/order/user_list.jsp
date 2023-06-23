<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 목록_user_list</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#search_form').on('submit',function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요.');
				$('#keyword').val('').focus();
				return false;
			}
			if($('#keyfield').val()==1 && isNAN($('#keyword').val())){
				alert('주문번호는 숫자만 입력하세요.');
				$('#keyword').val('').focus();
				return false;
			}
		})
	})
</script>
</head>
<body>
	<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- header 끝 -->
	<!-- content 시작 -->
	<div class="content-main">
		<h3>구매 목록</h3>
		<form action="orderList.do" method="get" id="search_form">
			<ul class="search">
				<li>
					<select name="keyfield" id="keyfield">
						<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>주문번호</option>
						<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>상품명</option>
					</select>
				</li>
				<li>
					<input type="search" size="16" name="keyword" id="keyword" value="${param.keyword}">	
				</li>
				<li>
					<input type="submit" value="조회">
				</li>		
			</ul>
		</form>
		<div>
			<input type="button" value="목록" onclick="location.href='orderList.do'">
		</div>
 			<c:if test="${count == 0}">
				<div>표시할 주문 내역이 없습니다.</div>
 			</c:if>
 			<c:if test="${count > 0}">
			<hr>
			<table>
				<tr>
					<th>상품명</th>
					<th>주문번호</th>
					<th>결제금액</th>
					<th>주문날짜</th>
					<th>상태</th>
				</tr>
			<c:forEach var="order" items="${list}">
				<tr>
					<td>${order.order_name}</td>
					<td>${order.order_num}</td>
					<td><fmt:formatNumber value="${order.order_total}"/>원</td>
					<td>${order.reg_date}</td>
					<td>
						<c:if test="${order.status == 1}">배송대기</c:if>
						<c:if test="${order.status == 2}">배송준비중</c:if>
						<c:if test="${order.status == 3}">배송중</c:if>
						<c:if test="${order.status == 4}">배송완료</c:if>
						<c:if test="${order.status == 5}">주문취소</c:if>
					</td>
				</tr>
			</c:forEach>
			</table>
			<hr>
			<input type="button" value="홈으로"
		  		   onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			<div class="align-center">${page}</div>
		</c:if>
	</div>	
	<!-- content 끝 -->
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</body>
</html>