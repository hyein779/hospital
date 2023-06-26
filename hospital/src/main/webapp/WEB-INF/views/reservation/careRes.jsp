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
<title>진료 예약</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reservation.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js"></script>
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
         <h4>진료 예약 일자 및 시간 선택</h4>
         <p><a href="${pageContext.request.contextPath}/reservation/care.do">돌아가기</a></p>
      </div>
      <div class="res_date">
         <%
		// 컴퓨터 시스템의 년, 월 받아오기
			Date date = new Date();
			int year = date.getYear() +1900;
			int month = date.getMonth() +1;
		
			//	오류사항 걸러주기	
			try{
				year = Integer.parseInt(request.getParameter("year"));
				month = Integer.parseInt(request.getParameter("month"));
				
				if(month>=13){
					year++;
					month =1;
				}else if(month <=0){
					year--;
					month =12;
				}
			}catch(Exception e){
				
			}
		
		%>
		<!-- 달력 만들기 -->
		<table cellpadding="5" cellspacing="0">
			<tr class="cal_top">
		<!-- 이전달 버튼 만들기 -->
				<th>
				<p><a onclick="location.href='?year=<%=year%>&month=<%=month-1%>'">◀</a></p>
				</th>
		
		<!-- 제목 만들기 -->
				<th id = "title" colspan = "5">
				<%=year%>년  <%=month%>월
				</th>
		
		<!-- 다음달 버튼 만들기 -->
				<th>
				<p><a onclick="location.href='?year=<%=year%>&month=<%=month+1%>'">▶</a></p>
				</th>
			</tr>
		<!-- 요일 표시칸 만들어주기(단, 토,일요일은 색을 다르게 하기위해 구분해주기) -->
			<tr>
				<td class = "sunday">일</td>
				<td class = "etcday">월</td>
				<td class = "etcday">화</td>
				<td class = "etcday">수</td>
				<td class = "etcday">목</td>
				<td class = "etcday">금</td>
				<td class = "saturday">토</td>
			</tr>
	
		<!-- 날짜 집어 넣기 -->
			<tr>
			<%
		//	1일의 요일을 계산한다(자주 쓰이기 때문에 변수로 선언해두기)
				int first = ReservationDAO.weekDay(year, month, 1);
			
		//	1일이 출력될 위치 전에 전달의 마지막 날짜들을 넣어주기위해 전 달날짜의 시작일을 계산한다.
				int start = 0 ;
				start = month ==1? ReservationDAO.lastDay(year-1, 12)- first : ReservationDAO.lastDay(year, month-1)- first;
		
		//	1일이 출력될 위치를 맞추기 위해 1일의 요일만큼 반복하여 전달의날짜를 출력한다.
				for(int i= 1; i<= first; i++){
					if(i==1){
		/* 일요일(빨간색)과 다른날들의 색을 구별주기  */
						out.println("<td class = 'redbefore'>"+(month ==1? 12 : month-1)+"/"+ ++start +"</td>");
					}else{
						out.println("<td class = 'before'>"+(month ==1? 12 : month-1)+"/"+ ++start +"</td>");
						
					}
				}
		
		/* 1일부터 달력을 출력한 달의 마지막 날짜까지 반복하며 날짜를 출력 */
				for(int i = 1; i <= ReservationDAO.lastDay(year, month); i++){
					/* 요일별로 색깔 다르게 해주기위해 td에 class 태그걸어주기 */
					switch(ReservationDAO.weekDay(year, month, i)){
						case 0 :
							out.println("<td class ='sun'>" +i +"</td>");
							break;
						case 6 :
							out.println("<td class ='sat'>" +i +"</td>");
							break;
						default :
							out.println("<td class ='etc'>" +i +"</td>");
							break;
					}
					
		/* 출력한 날짜(i)가 토요일이고 그달의 마지막 날짜이면 줄을 바꿔주기 */
					if(ReservationDAO.weekDay(year, month, i) == 6 && i != ReservationDAO.lastDay(year, month)){
						out.println("</tr><tr>");			
					}
				}
				if(ReservationDAO.weekDay(year, month, ReservationDAO.lastDay(year, month)) !=6){
					for(int i = ReservationDAO.weekDay(year, month, ReservationDAO.lastDay(year, month))+1; i < 7; i++){
						out.println("<td></td>");	
					}
				}
		
			%>
			</tr>
	
		</table>
      </div>
      
   </div>
   <!-- 내용 끝 -->
   <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>