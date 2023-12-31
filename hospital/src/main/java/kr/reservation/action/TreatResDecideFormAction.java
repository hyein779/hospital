package kr.reservation.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.reservation.dao.ReservationDAO;
import kr.reservation.vo.ReservationVO;
import kr.reservation.vo.TReservationVO;

public class TreatResDecideFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 여부 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.getMember(user_num);
		
		request.setAttribute("member", member);
		
		int treat_num = Integer.parseInt(request.getParameter("treat_num"));
		
		ReservationDAO resdao = ReservationDAO.getInstance();
		TReservationVO reservation = resdao.getTreat(treat_num);
		
		request.setAttribute("reservation", reservation);
		
		return "/WEB-INF/views/reservation/treatResDecideForm.jsp";
	}

}
