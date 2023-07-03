<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진료 예약 정보 기입</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reservation.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	var res_date = document.getElementById("res_date").value;
	var res_time = document.getElementById("res_time").value;
</script>
<style>
  @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&display=swap');
</style>
</head>
<body>
<div class="page-main">
   <jsp:include page="/WEB-INF/views/common/header.jsp"/>
   <!-- 내용 시작 -->
   <jsp:include page="/WEB-INF/views/reservation/lnb.jsp"/>
   <div class="content-main">
      <div class="subContHeader">
         <h3 class=subtitle>진료 예약</h3>
      </div>
      <div class="subHeader">
         <h4>진료 예약 정보 기입</h4>
         <p><a href="${pageContext.request.contextPath}/reservation/careRes.do?doc_num=${reservation.doc_num}">돌아가기</a></p>
      </div>
      <br>
      <form id="res_decide" action="resDecide.do?doc_num=${reservation.doc_num}&res_num=${reservation.res_num}" method="post">
      <div class="res_info">
      	<ul>
      		<li>
				<label for="name"  name="name" value="${member.name}">이름</label>${member.name}
			</li>
      		<li>
				<label for="code" name="code" value="${member.code.substring(0,6)}">생년월일</label>${member.code.substring(0, 6)}
			</li>
			<li>
				<label for="doc_name" name="doc_name" value="${reservation.doc_name}">담당의료진</label>${reservation.doc_name}
			</li>
			<li>
				<label for="res_time">예약일시</label>${param.res_date}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${param.res_time}
					<input type="hidden" name="res_time" value="${param.res_time}">
					<input type="hidden" name="res_date" value="${param.res_date}">
	 				
			</li>
			<li>
				<label for="res_content">증상설명(선택)</label>
				<textarea rows="7" cols="70" name="res_content"></textarea>
			</li>
			<input type="submit" value="예약하기">
      	</ul>
      </div>
      </form>
   </div>
   <!-- 내용 끝 -->
   <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>