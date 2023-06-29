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
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
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
						<input type="submit" value="검색" id="search">
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
						<span class="item-name">${item.item_name}</span>
						<br>
						<span class="price"><fmt:formatNumber value="${item.item_price}"/>원</span>
					</a>
				</div>
				</c:forEach>
			</div>
			<div class="align-center">${page}</div>
			</c:if>
		</div>
		<!-- 내용 끝 -->
		<!-- 배송안내 시작 -->
		<div class="cs">
			<div class="cs-inner">
				<div class="cs-center">
					<h3>고객센터</h3>
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
					<h3>무통장 입금 계좌</h3>
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