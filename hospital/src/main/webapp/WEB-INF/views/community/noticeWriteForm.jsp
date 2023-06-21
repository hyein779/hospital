<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 글쓰기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	#(function(){
		// 이벤트 연결
		$('#write_form').submit(function(){
			if($('#title').val().trim()==''){
				alert('제목을 입력하세요!');
				$('#title').val('').focus();
				return false;
			}
			if($('#content').val().trim()==''){
				alert('내용을 입력하세요!');
				$('#content').val().focus();
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
		<h3 class="subtitle">커뮤니티 글쓰기</h3>
		<form id="noticeWrite_form" action="noticeWrite.do" method="post">
			<ul>
				<li>
					<label for="notice_title">제목</label>
					<input type="text" name="notice_title" id="notice_title" maxlength="50" width="200">
				</li>
				<li>
					<label for="notice_content">내용</label>
					<textarea rows="5" cols="100" name="notice_content" id="notice_content" maxlength="50"></textarea>
				</li>
			</ul>
			<div class="align-right">
				<input type="submit" value="등록">
				<input type="button" value="목록" onclick="location.href='noticeList.do'">
			</div>
		</form>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>