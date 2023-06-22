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
		<c:if test="${!empty user_num && user_auth == 2}">
		<jsp:include page="lnb.jsp"/>
		</c:if>
		<c:if test="${!empty user_num && user_auth == 9}">
		<jsp:include page="/WEB-INF/views/member/adminLnb.jsp"/>
		</c:if>
		<!-- 내용 시작 -->
		<div class="content-main">
			<div>
				<h2>보조기 목록</h2>
			</div>
			<hr width="100%" size="1" noshade="noshade">
			<div class="image-space">
				<c:forEach var="item" items="${itemList}">
				<div class="horizontal-area">
					<a href="${pageContext.request.contextPath}/item/detail.do?item_num=${item.item_num}">
						<img src="${pageContext.request.contextPath}/upload/${item.item_photo}">
						<span>${item.item_name}</span>
						<br>
						<fmt:formatNumber value="${item.item_price}"/>원
					</a>
				</div>
				</c:forEach>
				<div class="float-clear"></div>
			</div>
		</div>
		<!-- 내용 끝 -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	</div>
</body>
</html>