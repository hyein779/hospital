package kr.volunteer.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.util.FileUtil;
import kr.volunteerboard.vo.appvolunteerVO;
import kr.volunteerboard.vo.volunteerboardVO;
import kr.volunteerboardDAO.volunteerboardDAO;

public class AppVolFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) { 
			return "redirect:/member/loginForm.do";
		}
		
		
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		volunteerboardDAO dao = volunteerboardDAO.getInstance();
		volunteerboardVO db_board = dao.getBoard(board_num);

		request.setAttribute("board", db_board);
		
		if(db_board.getQuantity()<=0) {
			request.setAttribute("accessMsg", "정원이 다 찼습니다.");
			request.setAttribute("accessUrl", "volList.do");
			
			return "/WEB-INF/views/common/notice.jsp";
		}
			
		return "/WEB-INF/views/volunteer/appVolForm.jsp";
	}

}
