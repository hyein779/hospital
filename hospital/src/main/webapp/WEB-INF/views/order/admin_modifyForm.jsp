<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자수정목록_admin_modifyForm</title>
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
	<h2>주문 수정</h2>

		<!-- 상품 수정 내역 -->
		<form id = "order_modify" action="modify2.do" method="post">
			<input type="hidden" name="order_num" value="${order.order_num}">
			<ul>
				<li>
					<label>배송 상태</label>
					<c:if test="${order.status != 5}">
						<select>
							<option id="status1" <c:if test="${order.status == 1}">selected</c:if>>배송대기</option>
							<option id="status2" <c:if test="${order.status == 2}">selected</c:if>>배송준비중</option>
							<option id="status3" <c:if test="${order.status == 3}">selected</c:if>>배송중</option>
							<option id="status4" <c:if test="${order.status == 4}">selected</c:if>>배송완료</option>
						</select>     						       
					</c:if>
						<select id="status5">
							<option>주문취소</option>
						</select>
				</li>			
				<!-- status가 2일때 정보를 변경할 수 있음. -->
				<c:if test="${order.status < 2}">
				<li>
					<span>*배송대기일 경우에만 수정 가능*</span>
				</li>
					<li>
						<label for="receive_name">받는 사람</label>
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
						<label for="receive_address2">나머지 주소</label>
						<input type="text" name="receive_address2" id="address2"
							   maxlength="30" value="${order.receive_address2}">
					</li>
					<li>
						<label for="notice">메모</label>
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
						<label>나머지 주소</label>
						${order.receive_address2}
					</li>					
					<li>
						<label>남기실 말씀</label>
						${order.notice}
					</li>					
				</c:if>					
					<li>
						<label>결제 수단</label>
						<c:if test="${order.payment == 1}">계좌이체</c:if>
						<c:if test="${order.payment == 2}">카드결제</c:if>
					</li>
			</ul>
			<div class="align-center">
				<c:if test="${order.status != 5}">			
					<input type="submit" value="수정">
				</c:if>
				
				<!-- 배송완료, 주문취소 상태일때만 정보를 삭제 -->
				<c:if test="${order.status == 4 or order.status == 5}">
					<input type="button" value="삭제"
						   onclick="location.href='deleteOrder.do?order_num=${order.order_num}'">
					<input type="button" value="주문목록"
					       onclick="location.href='list.do'">
		        </c:if>
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