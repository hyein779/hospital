<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보조기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<c:if test="${user_auth != 9}">
		<jsp:include page="lnb.jsp"/>
		</c:if>
		<c:if test="${!empty user_num && user_auth == 9}">
		<jsp:include page="/WEB-INF/views/member/adminLnb.jsp"/>
		</c:if>
		<!-- 내용 시작 -->
		<div class="product-main">
			<h3 class="subtitle item-list">보조기 목록</h3>
			<form action="item_list.do" method="get" id="search-form" class="item-search">
				<ul class="search">
					<li>
						<select name="keyfield" id="keyfield">
							<option value="1" <c:if test="${param.keyfield == 1}">selected</c:if>>상품명</option>
							<option value="2" <c:if test="${param.keyfield == 2}">selected</c:if>>내용</option>
						</select>
					</li>
					<li>
						<input type="search" size="25" name="keyword" id="keyword" value="${param.keyword}">
					</li>
					<li>
						<input type="submit" value="찾기" id="search">
					</li>
				</ul>
			</form>
			<c:if test="${count == 0}">
			<div class="result-display">
			 	표시할 상품이 없습니다.
			</div>
			</c:if>
			<c:if test="${count > 0}">
			<div class="image-space">
				<c:forEach var="item" items="${list}">
				<div class="horizontal-area">
					<a href="${pageContext.request.contextPath}/item/detail.do?item_num=${item.item_num}">
						<img src="${pageContext.request.contextPath}/upload/${item.item_photo}">
						<span>${item.item_name}</span>
						<br>
						<fmt:formatNumber value="${item.item_price}"/>원
					</a>
				</div>
				</c:forEach>
			</div>
			<div class="float-clear align-center">${page}</div>
			</c:if>
		</div>
		<!-- 내용 끝 -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	</div>
</body>
</html>