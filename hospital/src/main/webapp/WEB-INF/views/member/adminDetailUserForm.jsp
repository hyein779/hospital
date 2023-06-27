<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보(관리자 전용)</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/member.css">
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<!-- 내용 시작 -->
		<div class="content-main">
			<h2 class="logreg-a align-center">${member.id}의회원정보(관리자전용)</h2>
			<form action="adminDetailUser.do" method="post" id="detail_form">
				<input type="hidden" name="mem_num" value="${member.mem_num}">
				<ul>
					<li><label>등급</label> <c:if test="${member.auth != 9}">
							<input type="radio" name="auth" value="1" id="auth1"
								<%-- auth값이 1일경우 체크됨 --%>
							<c:if test="${member.auth==1}">checked</c:if>>정지
					<input type="radio" name="auth" value="2" id="auth2"
								<c:if test="${member.auth==2}">checked</c:if>>일반							
					</c:if> <c:if test="${member.auth==9}">
							<input type="radio" name="auth" value="9" id="auth9" checked>관리
					</c:if></li>
				</ul>
				<ul>
					<li><label>이름</label>${member.name}</li>
					<li><label>전화번호</label>${member.phone}</li>
					<li><label>이메일</label>${member.email}</li>
					<li><label>우편번호</label>${member.zipcode}</li>
					<li><label>주소</label>${member.address1} ${member.address2}</li>
				</ul>
				<div class="align-center">
					<c:if test="${member.auth != 9}">
						<input type="submit" value="수정" onclick="location.href='adminDetailUser.do'">
						<%-- 삭제는 보류..<input type="button" value="삭제" onclick="location.href='adminDeleteUserForm.do?mem_num=${member.mem_num}'"> --%>
					</c:if>
					<input type="button" value="목록" onclick="location.href='adminMemberList.do'">
				</div>
			</form>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
		<!-- 내용 끝 -->
	</div>
</body>
</html>