<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 목록_admin_list</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#search_form').on('submit',function(){
			if($('#keyword').val().trim()==''){
				alert('검색어를 입력하세요.');
				$('#keyword').val('').focus();
				return false;
			}
			//주문번호는 숫자로 체크
			if($('#keyfield').val() == 1 && isNaN($('#keyword').val())){
				alert('주문번호는 숫자만 입력하세요.');
				$('#keyword').val('').focus();
				return false;
			}
		});
	})
</script>
</head>
<body>
<!-- 관리자 : 주문목록 -->
<div class="page-main">
	<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- header 끝 -->
	<div class="content-main">
	<h2>주문 목록</h2>
	<!-- content 시작 -->
	<form>
		<ul class="search">
			<li>
				<select>
					<option value="1" <c:if test="${param.keyfield == 1}"></c:if>>주문번호</option>
					<option value="1" <c:if test="${param.keyfield == 2}"></c:if>>상품명</option>
				</select>
			</li>
			<li>
				<input type="search" size="16" value="${parem.keyword}"> <!-- 값 유지 -->
			</li>
			<li>
				<input type="submit" value="조회">
			</li>
		</ul>
	</form>
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
					<th></th>
				</tr>
			<c:forEach var="order" items="${list}">
				<tr>
					<td>${order.order_name}</td>
					<td><a href="modifyForm.do?order_num=${order.order_num}">${order.order_num}</a></td>
					<td><fmt:formatNumber value="${order.order_total}"/>원</td>
					<td>${order.reg_date}</td>
					<td>
						<c:if test="${order.status == 1}">배송대기</c:if>
						<c:if test="${order.status == 2}">배송준비중</c:if>
						<c:if test="${order.status == 3}">배송중</c:if>
						<c:if test="${order.status == 4}">배송완료</c:if>
						<c:if test="${order.status == 5}">주문취소</c:if>
					</td>
					<td>
						<a href="listForm.do?order_num=${order.order_num}">상세</a>
						<a href="modifyForm.do?order_num=${order.order_num}">수정</a>
					</td>
				</tr>
			</c:forEach>
			</table>
			<hr>
			<input type="button" class="right" value="홈으로"
		  		   onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			<div class="align-center">${page}</div>
		</c:if>
	</div>		
	<!-- content 끝 -->
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>




