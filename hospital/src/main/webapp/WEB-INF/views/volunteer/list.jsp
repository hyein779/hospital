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
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/volunteer.css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작 -->
	<jsp:include page="/WEB-INF/views/volunteer/lnb.jsp"/>
	<div class="content-main">
		
		<h3 class="subtitle">모집 공고</h3>
		<br>
		<div class="content-sub">
			<p class="volcontent"><b>자원봉사활동(Voluntarism)이란</b><p>
			<p class="volcontent-sub">개인 및 단체의 자발적 참여와 대가없이 도움이 필요한 이웃과 사회에 시간과 재능을 제공하여 사회문제 해결 및 사회공익에 기여하는 것을 말하며, 이러한 자원봉사활동을 실천에 옮기는 사람을 자원봉사자(Volunteer)라고 합니다.</p>
		</div>
		<br>
		<div class="list-space align-right">
			<input type="button" value="글쓰기" 
				onclick="location.href='volWriteForm.do'" 
				 <c:if test="${empty user_num}">disabled="disabled"</c:if>
			>
			<input type="button" value="목록" onlclick="location.href='volList.do'">
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do'">
		</div>
		<c:if test="${count == 0}">
		<div class="result-display">
			표시할 게시물이 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">
		<table>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>모집기간</th>
				<th>조회</th>
			</tr>
			<c:forEach val="board" items="${list}">
			<tr>
				<td>${board.boar_num}</td>
				<td><a href="volDetail.do?board_num">${board.title}</a></td>
				<td>${board.reg_date}</td>
				<td>${board.reg_hit}</td>
			</tr>
			</c:forEach>  
		</table>
		<div class="align-centet">${page}</div>
		</c:if>-
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>

 


