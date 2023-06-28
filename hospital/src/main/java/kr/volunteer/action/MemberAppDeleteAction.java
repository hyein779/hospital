package kr.volunteer.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.volunteerboardDAO.appvolunteerDAO;

public class MemberAppDeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) { 
			return "redirect:/member/loginForm.do";
		}
		
		request.setCharacterEncoding("utf-8");
		
		int app_num = Integer.parseInt(request.getParameter("app_num"));
		appvolunteerDAO dao = appvolunteerDAO.getInstance();
		
		dao.deleteApp(app_num);
		
		request.setAttribute("notice_msg", "취소했습니다.");
		request.setAttribute("notice_url", "memberVolList.do");
		
		return "/WEB-INF/views/common/alert_singleView.jsp";
	}

}
