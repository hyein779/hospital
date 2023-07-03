<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	$(function(){
		$('#appvol').submit(function(){
			$.ajax({
				url:'appCheck.do',
				type:'post',
				data:{board_num:${board.board_num}},
				dataType:'json',
				success:function(param){
					console.log("appCheck 액션 ajax가 동작함.");
					if(param.result=='appNotFound'){
						alert('등록 페이지로 이동합니다.');
					}else if(param.result=='appDuplicated'){
						alert('이미 지원한 자원봉사입니다.');
						location.href="volList.do";
					}else if(param.result=='zero'){
						alert('정원이 다 찼습니다.');
					}else{
						alert('오류');
					}
				},
				error:function(){
					alert('네트워크 오류 발생');
				}
			})
		});
		
	})
</script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/volunteer/lnb.jsp"/>
	<!-- 내용 시작  -->
	<div class="content-main">
		<h3 class="subtitle">상세내용</h3>
			<form action="appVolForm.do" method="post" id="appvol">
				<input type="hidden" value="${board.board_num}" name="board_num">
				<div id="detail">
					<ul class="detail-info">
						<li><b>${board.title}</b></li>
						<li>조회 : ${board.hit}</li>
					</ul>
					<p>${board.content}</p>
					<hr size="2" noshade="noshade" width="100%">
					<p>모집인원 : ${board.quantity}</p>
					<hr size="2" noshade="noshade" width="100%">
					<p>봉사 기간 : ${board.reg_date}</p> 
					<hr size="2" noshade="noshade" width="100%">
					<ul class="detail-sub">
						<li>
							<c:if test="${!empty board.modify_date}">
							최근 수정일 : ${board.modify_date}
							</c:if>
							<%-- 로그인한 회원번호와 작성자 회원번호가 일치해야 수정,삭제 가능 --%>
							<c:if test="${user_auth == 9}">
							<input type="button" value="수정" onclick="location.href='volUpdateForm.do?board_num=${board.board_num}'" class="submit">
							<input type="button" value="삭제" id="delete_btn" class="home">
							<script type="text/javascript">
								let delete_btn = document.getElementById('delete_btn');
								//이벤트 연결
								delete_btn.onclick=function(){
									let choice = confirm('삭제하겠습니까?');
									if(choice){//choice==true일떄
										location.replace('volDelete.do?board_num=${board.board_num}');
									} 
								}
							</script>
							</c:if>
							<c:if test="${user_auth < 9}">
								<input type="submit" value="지원하기" class="submit">
							</c:if>
						</li>
					</ul>
				</div>
			</form>
				
		

	</div>
	<!-- 내용 끝  -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>