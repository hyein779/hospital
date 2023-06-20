<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 정보</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>

</head>
<body>
<div>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/memberLnb.jsp"/>
	<!-- 내용 시작 -->
	<div>
		<h2>나의정보</h2>
		<div class="mypage-div">
			<ul>
				<li>이름 | ${member.name}</li>
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