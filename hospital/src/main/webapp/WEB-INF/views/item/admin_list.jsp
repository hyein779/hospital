<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 목록 관리</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#search_form').submit(function(){
			if($('#keyword').val().trim() == ''){
				alert('검색어를 입력하세요');
				$('#keyword').val('').focus();
				return false;
			}	
		});
	});
</script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<jsp:include page="/WEB-INF/views/member/adminLnb.jsp"/>
		<!-- 내용 시작 -->
		<div class="content-main">
			<h1 class="subtitle">상품 목록 관리</h1>
			<!-- 검색창 시작 -->
			<form id="search-form" action="list.do" method="get">
				<ul class="search">
					<li>
						<select name="keyfield" id="keyfield">
							<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>상품명</option>
							<option value="2" <c:if test="${param.keyfield==2}">selected</c:if>>내용</option>
						</select>
					</li>
					<li>
						<input type="search" size="50" name="keyword" id="keyword" value="${param.keyword}">
					</li>
					<li>
						<input type="submit" value="검색" id="search">
					</li>
				</ul>
			</form>
			<!-- 검색창 끝 -->
			<hr size="1" noshade="noshade" width="100%">
			<div class="list-spaces align-right">
				<input type="button" value="상품 등록" id="btn_bk" onclick="location.href='writeForm.do'">
				<input type="button" value="판매 목록" id="btn_bk" onclick="location.href='item_list.do'">
				<input type="button" value="홈으로" id="btn_bk" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
			</div>
		<c:if test="${count == 0}">
			<div class="result-display">
				표시할 상품이 없습니다.
			</div>
		</c:if>
		<c:if test="${count > 0}">
			<table>
				<tr>
					<th>번호</th>
					<th>상품명</th>
					<th>가격</th>
					<th>재고</th>
					<th>상태</th>
				</tr>
				<c:forEach var="item" items="${list}">
					<tr>
						<td>${item.item_num}</td>
						<td><a href="modifyForm.do?item_num=${item.item_num}">${item.item_name}</a></td>
						<td><fmt:formatNumber value="${item.item_price}"/>원</td>
						<td><fmt:formatNumber value="${item.item_quantity}"/></td>
						<td>
							<c:if test="${item.item_status == 1}">미표시</c:if>
							<c:if test="${item.item_status == 2}">표시</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
			<hr size="1" noshade="noshade" width="100%">
			<div class="align-center">${page}</div>
		</c:if>
		</div>
		<!-- 내용 끝 -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp"/>  
	</div>
</body>
</html>