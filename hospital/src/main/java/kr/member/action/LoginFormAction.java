package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;

public class LoginFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setAttribute("page_url", request.getParameter("page_url"));
		
		//JSP 경로 반환
		return "/WEB-INF/views/member/loginForm.jsp";
	}
}
