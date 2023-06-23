<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의사항 글수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		// 이벤트 연결
		$('#update_form').submit(function(){
			if($('#ask_title').val().trim()==''){
				alert('제목을 입력하세요');
				$('#ask_title').val('').focus();
				return false;
			}
			if($('#ask_content').val().trim()==''){
				alert('내용을 입력하세요');
				$('#ask_content').val('').focus();
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
		<h3 class="subtitle">문의사항</h3>
		<form id="update_form" action="askUpdate.do" method="post">
			<input type="hidden" name="ask_num" value="${ask.ask_num}">
			<ul>
				<li>
					<label for="ask_title">제목</label>
					<input type="text" name="ask_title" id="ask_title" value="${ask.ask_title}" maxlength="50" width="200">
				</li>
				<li>
					<label for="ask_content">내용</label>
					<textarea rows="5" cols="100" name="ask_content" id="ask_content" maxlength="3000">${ask.ask_content}</textarea>
				</li>
			</ul>
			<div class="align-right">
				<input type="submit" value="수정" class="submit">
				<input type="button" value="취소" onclick="location.href='askDetail.do?ask_num=${ask.ask_num}'" class="home">
			</div>
		</form>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>