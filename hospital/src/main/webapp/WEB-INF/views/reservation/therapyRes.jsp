<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kr.reservation.dao.ReservationDAO" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>치료 예약</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reservation.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#res_decide_form').submit(function(){
			if($('#res_date').val()==''){
				alert('예약 날짜를 선택하세요.');
				$('#res_date').focus();
				return false;
			}
			if($('#res_time').val()==''){
				alert('예약 시간을 선택하세요.');
				$('#res_time').focus();
				return false;
			}
		})
	})
	
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
         <h3 class=subtitle>치료 예약</h3>
      </div>
      <div class="subHeader">
         <h4>치료 예약 일자 및 시간 선택</h4>
         <p><a href="${pageContext.request.contextPath}/reservation/care.do">돌아가기</a></p>
      </div>
      <form id="res_decide_form" action="treatResDecideForm.do?treat_num=${reservation.treat_num}" method="post">
      <div class="res_date">
	      <div class="treat_name">
				<p class="treat_name">
					${reservation.treat_name}
				</p>
		  </div>
	     <ul>
	     	<li>
	     		<label for="res_date">예약 날짜</label>
	     		<input type="date" name="res_date" id="res_date" min="2023-07-03" max="2023-07-09">
	     		<p class="warn"> * 당일 예약 불가능</p>
	     	</li>
	     	<li>
	     		<label for="res_time">예약 시간</label>
	     		<select name="res_time" id="res_time">
	     			<option value=""></option>
				 	<option value="09:00">09:00</option>
					<option value="10:00">10:00</option>
					<option value="11:00">11:00</option>
				    <option value="12:00">12:00</option>
				    <option value="14:00">14:00</option>
				    <option value="15:00">15:00</option>
				    <option value="16:00">16:00</option>
				    <option value="17:00">17:00</option>
				    <option value="18:00">18:00</option>
				    <option value="19:00">19:00</option>
				</select>
	     	</li>
	     	<input type="submit" value="다음 단계">
	     </ul>
      	</form>
      </div>
   </div>
   <!-- 내용 끝 -->
   <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html> 