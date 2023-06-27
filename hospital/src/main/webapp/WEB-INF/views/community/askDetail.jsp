<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의사항 글상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/community.reply.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="lnb.jsp"/>
	<!-- 내용 시작 -->
	<div class="content-main">
		<h3 class="subtitle">문의사항</h3>
		<div id="detail">
			<ul class="detail-info">
				<li><b>${ask.ask_title}</b></li>
				<li>조회 ${ask.ask_hit}</li>
				<li class="writer">작성자 ${ask.id}</li>
			</ul>
			<p>
				${ask.ask_content}
			</p>
			<hr size="1" noshade="noshade" width="100%" color="#ccc">
			
			<ul class="detail-sub">
				<li>
					<c:if test="${empty ask.ask_modifydate}"> <!-- 수정한 날짜가 없는 경우 -->
					작성일 ${ask.ask_date}
					</c:if>
					<c:if test="${!empty ask.ask_modifydate}"> <!-- 수정한 날짜가 있는 경우 -->
					수정일 ${ask.ask_modifydate}
					</c:if>
					<input type="button" value="목록" onclick="location.href='askList.do'" class="submit">
					<!-- 로그인한 회원번호와 작성자 회원번호가 일치하거나 관리자인 경우 수정, 삭제 가능-->
					<c:if test="${user_num == ask.mem_num || user_auth == 9}">
					<input type="button" value="수정" onclick="location.href='askUpdateForm.do?ask_num=${ask.ask_num}'" class="submit">
					<input type="button" value="삭제" id="delete_btn" class="submit">
		 
					<script type="text/javascript">
						let delete_btn = document.getElementById('delete_btn');
						// 이벤트 연결
						delete_btn.onclick=function(){
							let choice = confirm('삭제하시겠습니까?');
							if(choice){
								location.replace('askDelete.do?ask_num=${ask.ask_num}');
							}
						};
					</script>
					</c:if>
				</li>
			</ul>
		</div>
		<!-- 댓글 시작 -->
		<c:if test="${user_auth==9}">
		<div class="reply_div">
			<span class="re-title">댓글 작성</span>
			<form id="re_form">
				<input type="hidden" name="ask_num" value="${ask.ask_num}" id="ask_num">
				<textarea rows="3" cols="50" name="re_content" id="re_content" class="rep-content" placeholder="댓글을 입력하세요"></textarea>
				<div id="re_first">
					<span class="letter-count">500/500</span>
				</div>
				<div id="re_second" class="align-right">
					<input type="submit" value="전송" class="reply_submit">
				</div>
			</form>
		</div>
		</c:if>
	<!-- 댓글 목록 출력 시작 -->
	<input type="hidden" name="ask_num" value="${ask.ask_num}" id="ask_num">
	<div id="output"></div>
	<div class="paging-button" style="display:none;">
		<input type="button" value="다음글 보기">
	</div>
	<!-- 댓글 목록 출력 끝 -->
	<!-- 댓글 끝 -->
	</div>
</div>
<!-- 내용 끝 -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>