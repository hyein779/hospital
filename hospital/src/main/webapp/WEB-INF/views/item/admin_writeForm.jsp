<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>보조기 상품 등록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/item.css">
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#write_form').submit(function(){
			if ($('input[type=radio]:checked').length < 1){
				alert('상품표시 여부를 지정하세요');
				return false;
			}		
			
			if ($('#name').val().trim() == ''){
				alert('상품을 입력하세요');
				$('#name').val('').focus();
				return false;
			}
			
			if ($('#price').val() == ''){
				alert('가격을 입력하세요');
				$('#price').focus();
				return false;
			}
			
			if ($('#quantity').val() == ''){
				alert('수량을 입력하세요');
				$('#quantity').focus();
				return false;
			}
			
			if ($('#photo').val() == ''){
				alert('상품사진을 선택하세요');
				$('#photo').focus();
				return false;
			}
			
			if ($('#detail').val().trim() == ''){
				alert('상품 설명을 입력하세요');
				$('#detail').val().focus();
				return false;
			}
		});
	});
</script>
</head>
<body>
	<div class="page-main">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<jsp:include page="/WEB-INF/views/member/adminLnb.jsp"/>
		<!-- 내용 시작 -->
		<div class="product-main">
			<h3 class="form-title">상품 등록</h3>
			<form action="write.do" method="post" enctype="multipart/form-data" id="write_form" class="product-form interval">
				<ul>
					<li class="product-content">
						<label class="product-label">상품 표시 여부</label>
						<input type="radio" name="item_status" value="1" id="status1">미표시
						<input type="radio" name="item_status" value="2" id="status1">표시
					</li>
					<li class="product-content">
						<label for="name" class="product-label">상품명</label>
						<input type="text" name="item_name" id="name" maxlength="15">
					</li>
					<li class="product-content">
						<label for="price" class="product-label">가격</label>
						<input type="number" name="item_price" id="price" min="1" max="99999999">
					</li>
					<li class="product-content">
						<label for="quantity" class="product-label">수량</label>
						<input type="number" name="item_quantity" id="quantity" min="0" max="9999">
					</li>
					<li class="product-content">
						<label for="photo" class="product-label">상품 사진</label>
						<input type="file" name="item_photo" id="photo" accept="image/gif,image/png,image/jpeg">
					</li>
					<li class="product-content">
						<label for="detail" class="product-label">상품 설명</label>
						<textarea rows="10" cols="60" name="item_detail" id="detail">1. 품명 및 모델명 :
						           2. 의료기기법상 허가/신고 번호 및 광고사전심의필 유무 :
						           3. 전기용품안전관리법상 KC 인증 필 유무 :
						           4. 정격전압, 소비전력 : 
						           5. 동일모델의 출시년월 : 
						           6. 제조사 : 
						           7. 제조국 : 
						           8. 제품의 사용목적 : 
						           9. 사용방법 : 
						           10. 취급시 주의사항 : 
						           11. 품질보증기준 :</textarea>
					</li>
				</ul>
				<div class="align-center">
					<input type="submit" value="등록" class="form-btn">
					<input type="button" value="목록" class="form-btn" onclick="location.href='list.do'">  
				</div>
			</form>
		</div>
		<!-- 내용 끝 -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	</div>
</body>
</html>