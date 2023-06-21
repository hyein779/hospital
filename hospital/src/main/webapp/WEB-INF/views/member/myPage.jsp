<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		<h2 class="logreg">나의정보</h2>
		<hr size="1" noshade="noshade" width="80%">
		<div class="mypage-div">
			<table>
				<tr>
					<td>이름</td>
					<td> | </td>
					<td>${member.name}</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td> | </td>
					<td>${member.id}</td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td> | </td>
					<c:if test="${fn:substring(member.code,7,8)%2==1}">
						<td>19${fn:substring(member.code,0,2)}년 ${fn:substring(member.code,2,4)}월 ${fn:substring(member.code,4,6)}일</td>
					</c:if>
					<c:if test="${fn:substring(member.code,7,8)%2==0}">
						<td>20${fn:substring(member.code,0,2)}년 ${fn:substring(member.code,2,4)}월 ${fn:substring(member.code,4,6)}일</td>
					</c:if>
				</tr>
				<tr>
					<td>전화번호</td>
					<td> | </td>
					<td>${fn:substring(member.phone,0,3)}-${fn:substring(member.phone,3,6)}-${fn:substring(member.phone,6,9)}</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td> | </td>
					<td>${member.email}</td>
				</tr>
				<tr>
					<td>우편번호</td>
					<td> | </td>
					<td>${member.zipcode}</td>
				</tr>
				<tr>
					<td>주소</td>
					<td> | </td>
					<td>${member.address1}</td>
				</tr>
				<tr>
					<td>상세주소</td>
					<td> | </td>
					<td>${member.address2}</td>
				</tr>
				<tr>
					<td>가입일</td>
					<td> | </td>
					<td>${member.date}</td>
				</tr>
				<tr>
					<td>회원정보 수정일</td>
					<td> | </td>
					<td>${member.modify_date}</td>
				</tr>
			</table>
			<hr size="1" noshade="noshade" width="80%">
			<div class="align-center">
				<input type="button" value="내 정보수정" onclick="location.href='${pageContext.request.contextPath}/member/modifyUserForm.do'">
			</div>
		</div>
	</div>
	<!-- 내용 끝  -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>