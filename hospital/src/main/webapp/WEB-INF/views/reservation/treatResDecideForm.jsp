<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>치료 예약 정보 기입</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reservation.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	var res_date = document.getElementById("res_date").value;
	var res_time = document.getElementById("res_time").value;
</script>
</head>
<body>
<div class="page-main">
   <jsp:include page="/WEB-INF/views/common/header.jsp"/>
   <!-- 내용 시작 -->
   <jsp:include page="/WEB-INF/views/reservation/lnb.jsp"/>
   <div class="content-main">
      <div class="subContHeader">
         <h3 class=subtitle>치료 예약</h3>
      </div>
      <div class="subHeader">
         <h4>치료 예약 정보 기입</h4>
         <p><a href="${pageContext.request.contextPath}/reservation/therapyRes.do">돌아가기</a></p>
      </div>
      <br>
      <form id="res_decide" action="treatResDecide.do?treat_num=${treservation.treat_num}&res_num=${treservation.res_num}" method="post">
      <div class="res_info">
      	<ul>
      		<li>
				<label for="name"  name="name" value="${member.name}">이름 : ${member.name}</label>
			</li>
      		<li>
				<label for="code" name="code" value="${member.code.substring(0,6)}">생년월일 : ${member.code.substring(0, 6)}</label>
			</li>
			<li>
				<label for="treat_name" name="treat_name" value="${treservation.treat_name}">치료 종류 : ${treservation.treat_name}</label>
			</li>
			<li>
				<label for="res_time">예약일시 : ${param.res_date} ${param.res_time}</label>
					<input type="hidden" name="res_time" value="${param.res_time}">
					<input type="hidden" name="res_date" value="${param.res_date}">
	 				
			</li>
			<li>
				<label for="res_content">요청사항(선택)</label>
				<textarea rows="5" cols="30" name="res_content"></textarea>
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