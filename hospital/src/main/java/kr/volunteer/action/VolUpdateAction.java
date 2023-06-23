package kr.volunteer.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.volunteerboard.vo.volunteerboardVO;
import kr.volunteerboardDAO.volunteerboardDAO;

public class VolUpdateAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth != 9) { // 관리자로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//관리자로 로그인한 경우
		request.setCharacterEncoding("utf-8");
		
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		volunteerboardDAO dao = volunteerboardDAO.getInstance();
		
		volunteerboardVO board = new volunteerboardVO();
		board.setBoard_num(board_num);
		board.setTitle(request.getParameter("title"));
		board.setContent(request.getParameter("content"));
		board.setReg_date(request.getParameter("reg_date"));
		
		dao.updateBoard(board);
		
		return "redirect:/volunteer/volDetail.do?board_num="+board_num;
	}

}