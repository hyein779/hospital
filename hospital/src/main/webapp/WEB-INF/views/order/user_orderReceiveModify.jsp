<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이용자_배송정보수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css">
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
<c:if test="${order.status < 2}">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function(){
	//상품주문 정보 등록 유효성 체크
	$('#order_form').submit(function(){
  	let items = document.querySelectorAll('input[type="text"]');
  	
	  	for(let i=0;i<items.length;i++){
	        if(items[i].value.trim()==''){
				let label = document.querySelector('label[for="'+items[i].id+'"]');
		        alert(label.textContent + ' 항목을 입력해주세요.');
		        items[i].value = '';
		        items[i].focus();
		        return false;
	        }
	        
			if(!/^\d{11}$/.test($('#receive_phone').val())){
				alert('하이픈(-)을 제거하고 작성해주세요(ex.01012345678)');
				$('#phone').val('');
				$('#phone').focus();
				return false;
			}
	 	}//end of for	
     	
	});//end of submit
})//end of function	
</script>
</c:if>
</head>
<body>
<div class="page-main">
	<!-- header 시작 -->
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/memberLnb.jsp"/>
	<!-- header 끝 -->
	<!-- content 시작 -->
	<div class="content-main">
		<h3 class="subtitle">배송정보</h3>
		<br>
		<hr class="order-hr"> 
		<br>
		<form id = "order_form" action="orderModify.do" method="post">
			<input type="hidden" name="order_num" value="${order.order_num}">
			<input type="hidden" name="status" value="${order.status}">
			<ul class="order-modifyform-item">
				<!-- status가 2일때 정보를 변경할 수  있음. -->
				<c:if test="${order.status < 2}">
				<!-- 사용하기 편하게 하기 위한 추가 문구 -->
				<li class="delivery_text">* 배송대기인 경우에만 배송정보를 수정하실 있습니다. *</li>
				<br>
				<table>
					<tr>
						<td>
							<label for="receive_name">받는사람</label></td>
						<td>						
							<input type="text" name="receive_name" id="receive_name"
								   maxlength="10" value="${order.receive_name}">
					    </td>
					</tr>
					<tr>
						<td>
							<label for="receive_phone">전화번호</label></td>
						<td>
						<input type="text" name="receive_phone" id="receive_phone"
							   maxlength="15" value="${order.receive_phone}">						
						</td>
					</tr>
					<tr>
						<td>
							<label for="zipcode">우편번호</label>
						<td>
						<input type="text" name="receive_post" id="zipcode"
						   maxlength="5" value="${order.receive_post}">
						<input type="button" value="우편번호 찾기" 
					       onclick="execDaumPostcode()">						
						</td>
					</tr>
					<tr>
						<td>
							<label for="address1">주소</label>
						<td>
						<input type="text" name="receive_address1" id="address1"
						  	   maxlength="30" value="${order.receive_address1}">						
						</td>
					</tr>
					<tr>
						<td>
							<label for="address2">상세주소</label>
						<td>
						<input type="text" name="receive_address2" id="address2"
					 		   maxlength="30" value="${order.receive_address2}">						
						</td>
					</tr>
					<tr>
						<td>
							<label for="notice">메모</label>
						<td>
						<textarea rows="5" cols="42" name="notice" id="notice"
			        			  maxlength="1300" class="order-text">${order.notice}</textarea>					
						</td>
					</tr>
					
					<tr>
						<td>
							<label class="order-item">결제수단</label>
						<td>
							<span class="color-red">
								<c:if test="${order.payment == 1}">계좌이체</c:if>
								<c:if test="${order.payment == 2}">카드결제</c:if>
							</span>				
						</td>
					</tr>
					<tr>
						<td>
							<label class="order-item">배송상태</label>
						<td>
							<span class="color-red">
								<c:if test="${order.status == 1}">배송대기</c:if>
								<c:if test="${order.status == 2}">배송준비중</c:if>
								<c:if test="${order.status == 3}">배송중</c:if>
								<c:if test="${order.status == 4}">배송완료</c:if>
								<c:if test="${order.status == 5}">주문취소</c:if>
							</span>			
						</td>
					</tr>
				</table>				
				</c:if>
			</ul>
			<div class="align-center">
				<input type="submit"  id="btn" value="주문수정">
				<input type="button" value="주문취소" id="order_cancel">
				
				<script>
					let order_cancel = document.getElementById('order_cancel');
					order_cancel.onclick=function(){
						let choice = confirm('주문을 취소하시겠습니까?');
						if(choice){
							location.replace('orderCancel.do?order_num=${order.order_num}');								
						}
				}
				</script>
			<input type="button" id="btn" value="주문내역" onclick="location.href='${pageContext.request.contextPath}/member/itemList.do'">
			       
		</div>
		</form>
		<br>
		<hr class="order-hr"> 
		<br>
	</div>
	<!-- 우편번호 검색 시작 -->
	<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
	<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>
	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    //(주의)address1에 참고항목이 보여지도록 수정
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    //(수정) document.getElementById("address2").value = extraAddr;
                
                } 
                //(수정) else {
                //(수정)    document.getElementById("address2").value = '';
                //(수정) }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                //(수정) + extraAddr를 추가해서 address1에 참고항목이 보여지도록 수정
                document.getElementById("address1").value = addr + extraAddr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
	</script>
	<!-- 우편번호 검색 끝 -->
	<!-- content 끝 -->
	<!-- footer 시작 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- footer 끝 -->
</div>
</body>
</html>