<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		//이벤트 연결
		$('#volwrite_form').submit(function(){
			if($('#title').val().trim()==''){
				alert('제목을 입력하세요!');
				$('#title').val('').focus();
				return false;
			}
			if($('#content').val().trim()==''){
				alert('내용을 입력하세요!');
				$('#content').val('').focus();
				return false;
			}
			if($('#reg_date').val().trim()==''){
				alert('모집기간을 입력하세요!');
				$('#reg_date').val('').focus();
				return false;
			}
		});   
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작 -->
	<div class="content-main">
		<jsp:include page="/WEB-INF/views/volunteer/lnb.jsp"/>
		<h2>봉사게시판 글쓰기</h2>
		<form id="volwrite_form" action="volWrite.do"
		        method="post" 
		       enctype="multipart/form-data">
			<ul>
				<li>
					<label for="title">제목</label>
					<input type="text" name="title"
					      id="title" maxlength="50">
				</li>
				<li>
					<label for="content">내용</label>
					<textarea rows="5" cols="30" name="content"
					      id="content" maxlength="50"></textarea>
				</li>
				<li>
					<label for="reg_date">모집기간</label>
					<input type="text" name="reg_date" id="reg_date" maxlength="50">
				</li>
			</ul> 
			<div class="align-center">
				<input type="submit" value="등록">
				<input type="button" value="목록"
				   onclick="location.href='volList.do'">
			</div>      
		</form>
	</div>
	<!-- 내용 끝 -->
</div>
</body>
</html>