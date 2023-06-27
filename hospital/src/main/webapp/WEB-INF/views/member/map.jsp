<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오시는길</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/member.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<jsp:include page="/WEB-INF/views/member/adminLnb.jsp" />
		<!-- 내용 시작 -->
		<div class="content-main">
			<h3 class="subtitle">오시는 길</h3>
			<dl>
				<dt>
					<iframe
						src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3165.366001193884!2d127.0332008!3d37.49928500000001!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca1c32408f9b7%3A0x4e3761a4f356d1eb!2z7IyN7Jqp6rWQ7Jyh7IS87YSw!5e0!3m2!1sko!2skr!4v1687844793139!5m2!1sko!2skr"
						width="600" height="450" style="border: 0;" allowfullscreen=""
						loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
				</dt>
				<dd></dd>
			</dl>
		</div>
		<div>하하</div>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</div>
</body>
</html>