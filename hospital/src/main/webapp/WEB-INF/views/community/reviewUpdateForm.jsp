<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 글수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/community.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#update_form').submit(function(){
			if(!$('#rev_type:checked').val()){
				alert('리뷰 작성할 진료과목을 선택하세요');
				return false;
			}
			if($('#rev_title').val().trim()==''){
				alert('제목을 입력하세요');
				$('#rev_title').val('').focus();
				return false;
			}
			if($('#rev_content').val().trim()==''){
				alert('내용을 입력하세요');
				$('#rev_content').val('').focus();
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
		<form id="update_form" action="reviewUpdate.do" method="post">
			<input type="hidden" name="rev_num" value="${review.rev_num}">
			<ul>
				<li>
					<label for="rev_type">진료과목</label>
					<span><input type="radio" name="rev_type" id="rev_type" value="0"
					<c:if test="${review.rev_type==0}">checked</c:if>>발목 질환</span>
					<span><input type="radio" name="rev_type" id="rev_type" value="1"
					<c:if test="${review.rev_type==1}">checked</c:if>>허리 질환</span>
					<span><input type="radio" name="rev_type" id="rev_type" value="2"
					<c:if test="${review.rev_type==2}">checked</c:if>>어깨 질환</span>
					<span><input type="radio" name="rev_type" id="rev_type" value="3"
					<c:if test="${review.rev_type==3}">checked</c:if>>기타</span>
				</li>
				<li>
					<label for="rev_title">제목</label>
					<input type="text" name="rev_title" id="rev_title" value="${review.rev_title}" maxlength="18" width="200">
				</li>
				<li>
					<label for="rev_content">내용</label>
					<textarea rows="5" cols="100" name="rev_content" id="rev_content" maxlength="160">${review.rev_content}</textarea>
				</li>
			</ul>
			<div class="align-right">
				<input type="submit" value="수정" class="submit">
				<input type="button" value="취소" onclick="location.href='reviewList.do'" class="home">
			</div>
		</form>
	</div>
	<!-- 내용 끝 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>