package kr.reservation.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.reservation.dao.ReservationDAO;
import kr.reservation.vo.ReservationVO;

public class ResDecideAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//로그인 여부 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		request.setCharacterEncoding("utf-8");
		
		int doc_num = Integer.parseInt(request.getParameter("doc_num"));
		
		ReservationVO reservation = new ReservationVO();
		reservation.setMem_name(request.getParameter("mem_name"));
		reservation.setMem_public(request.getParameter("mem_pulic"));
		reservation.setDoc_name(request.getParameter("doc_name"));
		reservation.setRes_date(request.getParameter("res_date"));
		reservation.setRes_time(request.getParameter("res_time"));
		reservation.setRes_content(request.getParameter("res_content"));
		reservation.setDoc_num(doc_num);
		reservation.setMem_num(user_num);
		
		ReservationDAO dao = ReservationDAO.getInstance();
		dao.insertRes(reservation);
				
		return "/WEB-INF/views/reservation/resDecide.jsp";
	}

}