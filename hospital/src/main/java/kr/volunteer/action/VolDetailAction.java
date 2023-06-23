package kr.volunteer.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.util.StringUtil;
import kr.volunteerboard.vo.volunteerboardVO;
import kr.volunteerboardDAO.volunteerboardDAO;

public class VolDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//글번호
		int board_num = Integer.parseInt(request.getParameter("board_num"));
		volunteerboardDAO dao = volunteerboardDAO.getInstance();
		//조회수 증가
		dao.updateReadcount(board_num);
		
		volunteerboardVO board = dao.getBoard(board_num);
		
		board.setTitle(StringUtil.useNoHtml(board.getTitle()));
		board.setContent(StringUtil.useBrNoHtml(board.getContent()));
		
		request.setAttribute("board", board);
		 
		return "/WEB-INF/views/volunteer/voldetail.jsp";
	}

}
