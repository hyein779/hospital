package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class AdminTherapyFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do?page_url=/member/adminTherapyList.do";
		}
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth < 9) {//관리자로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		return "/WEB-INF/views/member/adminTherapyList.jsp";
	}

}
