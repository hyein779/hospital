package kr.volunteer.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.volunteerboard.vo.appvolunteerVO;
import kr.volunteerboardDAO.appvolunteerDAO;

public class AppVolWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		request.setCharacterEncoding("utf-8");
		
		appvolunteerVO app = new appvolunteerVO();
		app.setName(request.getParameter("name"));
		app.setAddress(request.getParameter("address"));
		app.setPhone(request.getParameter("phone"));
		app.setContent(request.getParameter("content"));
		app.setMem_num(user_num);
		
		appvolunteerDAO dao = appvolunteerDAO.getInstance();
		dao.insertVol(app);
		
		response.addHeader("Refresh", "2;url=volList.do");
		request.setAttribute("accessMsg", "지원되었습니다.");
		request.setAttribute("accessUrl", "volList.do");
		
		
		return "/WEB-INF/views/common/notice.jsp";
	}

}
