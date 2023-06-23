package kr.volunteer.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.util.StringUtil;
import kr.volunteerboard.vo.volunteerboardVO;
import kr.volunteerboardDAO.volunteerboardDAO;

public class VolUpdateFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth != 9) {//관리자가 아닌경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		    
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		volunteerboardDAO dao = volunteerboardDAO.getInstance();
		volunteerboardVO board = dao.getBoard(board_num);
		
		
		
		request.setAttribute("board", board);
		
		return "/WEB-INF/views/volunteer/updateForm.jsp";
	}   

}