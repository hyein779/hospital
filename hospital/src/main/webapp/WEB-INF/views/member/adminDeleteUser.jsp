<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:if test="${check}">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member.css">
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작 -->
	<div class="content-main">
		<div class="result-display">
			<div class="align-center">
				회원탈퇴가 완료되었습니다.<p>
				<input type="button" value="회원목록으로" id="btn_b" onclick="location.href='${pageContext.request.contextPath}/member/adminMemberList.do'">
			</div>
		</div>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>
</c:if>
<c:if test="${!check}">
	<script>
		alert('입력한 정보가 정확하지 않습니다.');
		history.go(-1);
	</script>
</c:if>