package kr.volunteer.action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.volunteerboard.vo.appvolunteerVO;
import kr.volunteerboard.vo.volunteerboardVO;
import kr.volunteerboardDAO.appvolunteerDAO;
import kr.volunteerboardDAO.volunteerboardDAO;


public class AppVolWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		int app_quantity = 1;
		
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		volunteerboardDAO dao = volunteerboardDAO.getInstance();
		volunteerboardVO db_board = dao.getBoard(board_num);

		request.setAttribute("board", db_board);
		
		
		
		appvolunteerVO app = new appvolunteerVO();
		
		app.setBoard_num(Integer.parseInt(request.getParameter("board_num")));
		app.setName(request.getParameter("name"));
		app.setAddress(request.getParameter("address"));
		app.setPhone(request.getParameter("phone"));
		app.setContent(request.getParameter("content"));
		app.setApp_quantity(app_quantity);
		app.setMem_num(user_num);
		
		request.setAttribute("app", app);

		
		appvolunteerDAO appDao = appvolunteerDAO.getInstance();
		appDao.insertVol(app);
		
		response.addHeader("Refresh", "2;url=volList.do");
		request.setAttribute("accessMsg", "지원되었습니다.");
		request.setAttribute("accessUrl", "volList.do");

		
		return "/WEB-INF/views/common/notice.jsp";
	}

}
