<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보조기 상품 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<!-- 내용 시작 -->
		<div class="content-main align-center">
			<h2>상품 등록</h2>
			<form action="write.do" method="post" enctype="multipart/form-data" id="write_form">
				<ul>
					<li>
						<label>상품 표시 여부</label>
						<input type="radio" name="status" value="1" id="status1">미표시
						<input type="radio" name="status" value="2" id="status2">표시
					</li>
					<li>
						<label for="item_name">상품명</label>
						<input type="text" name="name" id="name" maxlength="15">
					</li>
					<li>
						<label for="price">가격</label>
						<input type="number" name="price" id="price" min="1" maxlength="99999999">
					</li>
					<li>
						<label for="quantity">수량</label>
						<input type="number" name="quantity" id="quantity" min="0" maxlength="9999">
					</li>
					<li>
						<label for="photo">상품 사진</label>
						<input type="file" name="photo" id="photo" accept="image/gif,image/png,image/jpeg">
					</li>
					<li>
						<label for="detail">상품 설명</label>
						<textarea rows="5" cols="30" name="detail" id="detail"></textarea>
					</li>
				</ul>
				<div class="align-center">
					<input type="submit" value="등록">
					<input type="button" value="목록" onclick="location.href='list.do'">
				</div>
			</form>
		</div>
		<!-- 내용 끝 -->
	</div>
</body>
</html>