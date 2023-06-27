package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.member.dao.MemberDAO;

public class FindUserIdAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		//전송된 데이터 반환(이름,전화번호)
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		
		MemberDAO dao = MemberDAO.getInstance();
		String id = dao.findId(name, phone);
		
		boolean check = false;

		if(id!=null && !"".equals(id)) {
			check=true;
		}
		request.setAttribute("check", check);
		request.setAttribute("id", id);
		
		return "/WEB-INF/views/member/findUserId.jsp";
	}

}
