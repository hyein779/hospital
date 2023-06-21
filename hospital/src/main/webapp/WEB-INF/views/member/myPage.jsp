<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 정보</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>

</head>
<body>
<div>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/memberLnb.jsp"/>
	<!-- 내용 시작 -->
	<div>
		<h2 class="logreg">나의 정보</h2>
		<hr size="1" noshade="noshade" width="60%">
		<div class="mypage-div">
			<ul>
				<li>이름 | ${member.name}</li>
				<c:if test="${fn:substring(member.code,7,8)%2==1}">
					<li>생년월일 | 19${fn:substring(member.code,0,2)}년 ${fn:substring(member.code,2,4)}월 ${fn:substring(member.code,4,6)}일</li>
				</c:if>
				<c:if test="${fn:substring(member.code,7,8)%2==0}">
					<li>생년월일 | 20${fn:substring(member.code,0,2)}년 ${fn:substring(member.code,2,4)}월 ${fn:substring(member.code,4,6)}일</li>
				</c:if>
				<li>전화번호 | ${member.phone}</li>
				<li>이메일 | ${member.email}</li>
				<li>우편번호 | ${member.zipcode}</li>
				<li>주소 | ${member.address1}</li>
				<li>상세주소 | ${member.address2}</li>
			</ul>
		</div>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>