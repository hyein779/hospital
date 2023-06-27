<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 목록</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/member.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#search_form').submit(function(){
			if($('#keyword').val().trim()==''){
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
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<jsp:include page="/WEB-INF/views/member/adminLnb.jsp" />
		<!-- 내용 시작 -->
		<div class="content-main">
			<h3 class="subtitle">봉사 목록</h3>
			<!-- 검색창 시작 -->
			<form id="search_form" action="adminVolList.do" method="get">
				<ul class="search">
					<li><select name="keyfield" id="keyfield">
							<option value="1" <c:if test="${param.keyfield==1}">selected</c:if>>봉사명</option>
						</select>
					</li>
					<li><input type="search" size="50" name="keyword" id="keyword"
						value="${param.keyword}"></li>
					<li><input type="submit" id="search" value="검색"></li>
				</ul>
			</form>
			<!-- 검색창 끝 -->
			<div class="list-space align-right">
				<input type="button" value="목록"
					onclick="location.href='${pageContext.request.contextPath}/member/itemList.do'">
				<input type="button" value="홈으로"
					onclick="location.href='${pageContext.request.contextPath}/main/main.do '">
			</div>
			<c:if test="${count == 0}">
				<div class="result-display">표시할 상품이 없습니다.</div>
			</c:if>
			<c:if test="${count > 0}">
				<table>
					<tr>
						<th>봉사번호</th>
						<th>봉사명</th>
						<th>봉사기간</th>
						<th>모집인원</th>
						<th>수정일</th>
						<th>상세보기</th>
					</tr>
					<c:forEach var="board" items="${list}">
						<tr>
							<td>${board.board_num}</td>
							<td>${board.title}</a></td>
							<td>${board.reg_date}</td>
							<td>${board.quantity}</td>
							<td>${board.modify_date}</td>
							<td><a href="#">상세보기</a></td> 
						</tr>
					</c:forEach>
				</table>
				<div class="align-center">${page}</div>
			</c:if>

		</div>
		<!-- 내용 끝 -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>