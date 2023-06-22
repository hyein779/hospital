<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>
<div class="page-main">
	<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- header 끝 -->
	<h2>주문 목록</h2>
	<!-- content 시작 -->
		<ul>
			<li>
				<select>
					<option value="1" <c:if test="${param.keyfield == 1}"></c:if>>주문번호</option>
					<option value="1" <c:if test="${param.keyfield == 2}"></c:if>>ID</option>
					<option value="1" <c:if test="${param.keyfield == 3}"></c:if>>상품명</option>
				</select>
			</li>
			<li>
				<input type="search" size="16" value="${parem.keyword}"> <!-- 값 유지 -->
			</li>
			<li>
				<input type="submit" value="조회">
			</li>
		</ul>
		<input type="button" value="홈으로"
		   onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		   <% int count = 1; %>
		<c:if test="${count > 0}">
			<div>주문내역이 없습니다.</div>
		</c:if>
		<c:if test="${count == 0}">
			<span><a href="#">주문내역 상세보기</a></span>
			<hr>
			<table>
					<tr>
						<!-- <td width="100">상품명</td> -->
						<td rowspan="6"><img src="../images/목질환.png" width="200" height="200"></td>
						<td>상품명</td>
					</tr>
					<tr>
						<td>주문번호</td>
					</tr>
					<tr>
						<td>ID</td>
					</tr>
					<tr>
						<td>결제금액</td>
					</tr>
					<tr>
						<td>주문날짜</td>
					</tr>
					
					<tr>
						<td>상태</td>
					</tr>	
			</table>
			<!-- 
				출력이 가능하면 위 테이블에 넣어보기
				여러번 반복할려면 어떻게 해야할까
			 -->
			<%-- <c:forEach var="order" items="${list}">
			</c:forEach> --%>
				<table>
					<tr>
						<td>${order.item_name}</td>
						<td><a href="modifyForm.do?order_num=${order.order_num}">${order.order_num}</a></td>
						<td>${order.id}</td>
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
				</table>
			<hr>
			<div>${page}</div>
		</c:if>
	<!-- content 끝 -->
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>




