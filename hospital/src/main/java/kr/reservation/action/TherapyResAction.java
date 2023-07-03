package kr.reservation.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.reservation.dao.ReservationDAO;
import kr.reservation.vo.ReservationVO;
import kr.reservation.vo.TReservationVO;

public class TherapyResAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//치료 번호 반환
		int treat_num = Integer.parseInt(request.getParameter("treat_num"));
		
		ReservationDAO dao = ReservationDAO.getInstance();
		TReservationVO reservation = dao.getTreat(treat_num);
		
		request.setAttribute("reservation", reservation);
		  
		return "/WEB-INF/views/reservation/therapyRes.jsp";
	}

}
