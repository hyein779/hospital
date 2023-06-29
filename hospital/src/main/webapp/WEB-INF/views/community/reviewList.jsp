<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/community.fav.js"></script>
<script type="text/javascript">
	$(function(){
		$('.delete_btn').click(function(){
			let choice = confirm('삭제하시겠습니까?');
			if(choice){
				location.replace('reviewDelete.do?rev_num='+$(this).attr('data-num'));
				alert('삭제가 완료되었습니다.')
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
		<h3 class="subtitle">리뷰</h3>
		<div class="list-space align-right">
			<input type="button" value="글쓰기" id="write" onclick="location.href='reviewWriteForm.do'"
			<c:if test="${empty user_num}">disabled="disabled"</c:if>> <!-- 로그인 안되어 있을때 글쓰기 버튼 비활성화 -->
		</div>
		
		<c:if test="${count == 0}">
		<div class="result-display">
			표시할 게시물이 없습니다.
		</div>
		</c:if>
		<c:if test="${count > 0}">
		<c:forEach var="review" items="${list}">
		<div class="review-container">
			<ul class="sub">
				<li>${review.mem_name.substring(0,1)}**님의 후기</li>
				<li>/</li>
				<li>${review.rev_date}</li>
				<!-- 로그인한 회원번호와 작성자 회원번호가 일치하거나 관리자인 경우 수정, 삭제 가능-->
				<c:if test="${user_num == review.mem_num || user_auth == 9}">
				<li>
					<input type="button" value="수정" onclick="location.href='reviewUpdateForm.do?rev_num=${review.rev_num}'">
				</li>
				<li>
					<input type="button" value="삭제" class="delete_btn" data-num="${review.rev_num}">
				</li>
				</c:if>
				<li class="like">
					<!-- 좋아요 -->
					<c:if test="${review.clicked != 'clicked'}">
					<img class="output_fav" data-num="${review.rev_num}" src="${pageContext.request.contextPath}/images/like01.png" width="23">
					</c:if>
					<c:if test="${review.clicked == 'clicked'}">
					<img class="output_fav" data-num="${review.rev_num}" src="${pageContext.request.contextPath}/images/like02.png" width="23">
					</c:if>
					<span class="output_fcount">${review.cnt}</span> 
				</li>
			</ul>
			<ul class="rev-main">
				<li class="review-image">
					<c:if test="${review.rev_type == 0}">
					<div class="review-image">
						<img src="${pageContext.request.contextPath}/images/ankle.png">
						<p>
						발목통증 <br> 진료 후기
						</div>
					</c:if>
					<c:if test="${review.rev_type == 1}">
					<div class="review-image">
						<img src="${pageContext.request.contextPath}/images/back.png">
						<p>
						허리통증 <br> 진료 후기
						</div>
					</c:if>
					<c:if test="${review.rev_type == 2}">
					<div class="review-image">
						<img src="${pageContext.request.contextPath}/images/shoulder.png">
						<p>
						어깨통증 <br> 진료 후기
						</div>
					</c:if>
					<c:if test="${review.rev_type == 3}">
					<div class="review-image">
						<img src="${pageContext.request.contextPath}/images/도수치료.png">
						<p>
						기타 진료 후기
						</div>
					</c:if>
				</li>
				<li>
					<div class="rev">
						<h5>${review.rev_title}</h5>
						<div>${review.rev_content}</div>
					</div>
				</li>
			</ul>
			
		</div>
		</c:forEach>
		<div class="align-center float-clear">${page}</div>
		</c:if>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>