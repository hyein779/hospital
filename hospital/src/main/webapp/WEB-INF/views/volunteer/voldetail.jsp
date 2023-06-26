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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<!-- 내용 시작  -->
	<jsp:include page="/WEB-INF/views/volunteer/lnb.jsp"/>
	<div class="content-main">
		<h3 class="subtitle">상세내용</h3>
		<div id="detail">
			<ul class="detail-info">
				<li><b>${board.title}</b></li>
				<li>조회 : ${board.hit}</li>
			</ul>
			<p>${board.content},  모집인원 : ${board.quantity} </p>
			<hr size="2" noshade="noshade" width="100%">
			<p>모집 기간 : ${board.reg_date}</p> 
			<hr size="2" noshade="noshade" width="100%">
			<ul class="detail-sub">
				<li>
					<c:if test="${!empty board.modify_date}">
					최근 수정일 : ${board.modify_date}
					</c:if>
					<%-- 로그인한 회원번호와 작성자 회원번호가 일치해야 수정,삭제 가능 --%>
					<c:if test="${user_num == board.mem_num}">
					<input type="button" value="수정" onclick="location.href='volUpdateForm.do?board_num=${board.board_num}'">
					<input type="button" value="삭제" id="delete_btn">
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
					<input type="hidden" name="reg_date" value="${board.reg_date}" id="reg_date">
					<input type="button" value="지원하기" onclick="location.href='appVolForm.do'">
					</c:if>
				</li>
			</ul>
		</div>
	</div>
	<!-- 내용 끝  -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>