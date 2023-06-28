package kr.reservation.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.reservation.dao.ReservationDAO;
import kr.reservation.vo.ReservationVO;

public class CareResAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//의사 번호 반환
		int doc_num = Integer.parseInt(request.getParameter("doc_num"));
		
		ReservationDAO dao = ReservationDAO.getInstance();
		ReservationVO reservation = dao.getDoc(doc_num);
		
		request.setAttribute("reservation", reservation);
		
		return "/WEB-INF/views/reservation/careRes.jsp";
	}

}
