package kr.reservation.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.reservation.dao.ReservationDAO;
import kr.reservation.vo.ReservationVO;
import kr.reservation.vo.TReservationVO;

public class TherapyResAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 여부 체크
				HttpSession session = request.getSession();
				Integer user_num = (Integer)session.getAttribute("user_num");
				if(user_num==null) {//로그인 되지 않은 경우
					request.setAttribute("notice_msg", "로그인 후 이용하세요.");
					request.setAttribute("notice_url", request.getContextPath()+"/member/loginForm.do");
					return "/WEB-INF/views/common/alert_singleView.jsp";
				}
				
		//치료 번호 반환
		int treat_num = Integer.parseInt(request.getParameter("treat_num"));
		
		ReservationDAO dao = ReservationDAO.getInstance();
		TReservationVO reservation = dao.getTreat(treat_num);
		
		request.setAttribute("reservation", reservation);
		  
		return "/WEB-INF/views/reservation/therapyRes.jsp";
	}

}
