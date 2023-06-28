<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
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
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/adminLnb.jsp"/>
	<!-- 내용 시작 -->
	<div class="content-main">
		<h3 class="myPagest">회원목록</h3>
		<!-- 검색창 시작 -->
		<form id="search_form" action="noticeList.do" method="get">
			<ul class="search">
				<li>
					<select name="keyfield" id="keyfield">
						<option value="1" <c:if test="${param.keyfield==1}"></c:if>>ID</option>
						<option value="2" <c:if test="${param.keyfield==2}"></c:if>>이름</option>
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
		<hr size="1" noshade="noshade" width="100%">
		<div class="list-space align-right">
			<input type="button" value="목록" onclick="location.href='memberList.do'" id="btn_bk"> 
			<input type="button" value="홈으로" onclick="location.href='${pageContext.request.contextPath}/main/main.do '" id="btn_bk">  
		</div>
		<c:if test="${count == 0}">
		<div class="result-display">
			표시할 회원정보가 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">
		<table>
			<tr>
				<th>회원번호</th>
				<th>ID</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>최근진료일</th>
				<th>등급</th>
				<th>관리</th>
			</tr>
			<c:forEach var="member" items="${list}">
			<tr>
				<td>${member.mem_num}</td>
				<td>${member.id}</td>
				<td>${member.name}</td>
				<td>${member.phone}</td>
				<td>${member.address1} ${member.address2}</td>
				<c:if test="${member.visited==null}">
					<td>없음</td>
				</c:if>
				<c:if test="${member.visited != null}">
					<td>${member.visited}</td>
				</c:if>
				<td>
					<c:if test="${member.auth == 0}">탈퇴</c:if>
					<c:if test="${member.auth == 1}">정지</c:if>
					<c:if test="${member.auth == 2}">일반</c:if>
					<c:if test="${member.auth == 9}">관리</c:if>
				</td>
				<c:if test="${member.auth > 0}">
					<td><a href="adminDetailUserForm.do?mem_num=${member.mem_num}" id="bluecolor"><ins>수정</ins></a>
					 / <a href="adminDeleteUserForm.do?mem_num=${member.mem_num}" id="redcolor"><ins>삭제</ins></a></td>
				</c:if>
				<c:if test="${member.auth == 0}">
					<td>X</td>
				</c:if>
			</tr>
			</c:forEach>
		</table>
		<div class="align-center">${page}</div>
		</c:if>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>