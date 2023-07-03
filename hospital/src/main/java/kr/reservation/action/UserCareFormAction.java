package kr.reservation.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.reservation.dao.ReservationDAO;
import kr.reservation.vo.ReservationVO;
import kr.util.PageUtil;

public class UserCareFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 여부 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {
			return "redirect:/member/loginForm.do?page_url=/reservation/userTreatmentForm.do";
		}
		//진료 리스트
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		ReservationDAO dao = ReservationDAO.getInstance();
		int count = dao.getResCount();
		
		PageUtil page = new PageUtil(Integer.parseInt(pageNum),count,5,10,"userCareForm.do");
		
		List<ReservationVO> list = null;
		if(count > 0) {
			list = dao.getListRes(user_num);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());

		return "/WEB-INF/views/reservation/userCareForm.jsp";
	}

}