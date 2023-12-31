<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/volunteer.css">
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	#(function(){
		//이벤트 연결
		$('#update_form').submit(function(){
			if($('#title').val().trim()==''){
				alert('제목을 입력하세요 !');
				$('#title').val('').focus();
				return false;
			}	
			 
			if($('#content').val().trim()==''){
				alert('내용을 입력하세요');
				$('#content').val('').focus();
				return false;
			}
			
			if($('#quantity').val().trim()==''){
				alert('모집인원을 입력하세요');
				$('#quantity').val('').focus();
				return false;
			}
		});
	});
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/volunteer/lnb.jsp"/>
	<!-- 내용 시작 -->
	<div class="content-main">
		<div class="subcontent-main">
			<h3 class="subtitle">글 수정</h3>
			
			<form id="update_form" action="volUpdate.do" method="post">
				<input type="hidden" name="board_num" value="${board.board_num}"> 
				<ul>
					<li>
						<label for="title">제목</label>
						<input type="text" id="title" name="title" value="${board.title}" maxlength="50">
					</li>
					<li>
						<label for="content">내용</label>
						<textarea rows="6" cols="30" name="content" id="content" maxlength="50">${board.content}</textarea>
					</li>
					<li>
						<label for="quantity">모집인원</label>
						<input type="number" name="quantity" id="quantity" maxlength="10" value="${board.quantity}">
					</li>
				</ul>
				<div class="div_align">
					<input type="submit" value="수정" class="submit">
					<input type="button" value="글상세" onclick="location.href='volDetail.do?board_num=${board.board_num}'"  class="home">
				</div>
			</form>
		</div>
		
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>