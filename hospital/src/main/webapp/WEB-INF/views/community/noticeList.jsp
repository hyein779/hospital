<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#search_form').submit(function(){
			if($('#keyword').val().trim==''){
				alert('검색어를 입력하세요');
				$('#keyword').val('').focuse();
				return false;
			}
		});
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="lnb.jsp"/>
	<!-- 내용 시작 -->
	<div class="content-main">
		<h3 class="subtitle">공지사항</h3>
		<!-- 검색창 시작 -->
		<form id="search_form" action="noticeList.do" method="get">
			<ul class="search">
				<li>
					<select name="keyfield" id="keyfield">
						<option value="1" <c:if test="${param.keyfield==1}"></c:if>>제목</option>
						<option value="2" <c:if test="${param.keyfield==2}"></c:if>>내용</option>
					</select>
				</li>
				<li>
					<input type="search" size="50" name="keyword" id="keyword" value="${param.keyword}">
				</li>
				<li>
					<input type="submit" id="search" value="검색">
				</li>
			</ul>
		</form>
		<!-- 검색창 끝 -->
		<div class="list-space align-right">
			<input type="button" value="글쓰기" id="write" onclick="location.href='noticeWriteForm.do'"
			<c:if test="${empty user_num || user_auth != 9}">disabled="disabled"</c:if>> <!-- 로그인 안되어 있을 때 글쓰기 버튼 비활성화 -->
		</div>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>