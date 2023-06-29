package kr.reservation.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class UserTreatmentFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 여부 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {
			return "redirect:/member/loginForm.do?page_url=/reservation/userTreatmentForm.do";
		}
		//진료 리스트

		return "/WEB-INF/views/reservation/userTreatmentForm.jsp";
	}

}