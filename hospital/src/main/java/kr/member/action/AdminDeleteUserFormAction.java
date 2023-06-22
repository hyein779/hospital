package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class AdminDeleteUserFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 여부 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {// 로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		// 관리자로 로그인한 경우
		int mem_num = Integer.parseInt(request.getParameter("mem_num"));
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.getMember(mem_num);

		request.setAttribute("member", member);
		// JSP 경로 반환
		return "/WEB-INF/views/member/adminDeleteUserForm.jsp";
	}

}
