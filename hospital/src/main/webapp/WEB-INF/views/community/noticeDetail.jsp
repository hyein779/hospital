<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글상세</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="page-main">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="lnb.jsp"/>
	<!-- 내용 시작 -->
	<div class="content-main">
		<h3 class="subtitle">공지사항</h3>
		<div id="detail">
			<ul class="detail-info">
				<li><b>${notice.notice_title}</b></li>
				<li>조회 ${notice.notice_hit}</li>
			</ul>
			<p>
				${notice.notice_content}
			</p>
			<hr size="1" noshade="noshade" width="100%" color="#ccc">
			
			<ul class="detail-sub">
				<li>
					<c:if test="${empty notice.notice_modifydate}"> <!-- 수정한 날짜가 없는 경우 -->
					작성일 ${notice.notice_date}
					</c:if>
					<c:if test="${!empty notice.notice_modifydate}"> <!-- 수정한 날짜가 있는 경우 -->
					수정일 ${notice.notice_modifydate}
					</c:if>
					<input type="button" value="목록" onclick="location.href='noticeList.do'" class="submit">
					<!-- 관리자만 수정, 삭제가 가능 -->
					<c:if test="${user_auth == 9}">
					<input type="button" value="수정" onclick="location.href='noticeUpdateForm.do?notice_num=${notice.notice_num}'" class="submit">
					<input type="button" value="삭제" id="delete_btn" class="submit">
		 	
					<script type="text/javascript">
						let delete_btn = document.getElementById('delete_btn');
						// 이벤트 연결
						delete_btn.onclick=function(){
							let choice = confirm('삭제하시겠습니까?');
							if(choice){
								location.replace('noticeDelete.do?notice_num=${notice.notice_num}');
							}
						};
					</script>
					</c:if>
				</li>
			</ul>
		</div>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>