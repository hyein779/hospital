package kr.volunteer.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.util.FileUtil;
import kr.volunteerboard.vo.volunteerboardVO;
import volunteerboardDAO.volunteerboardDAO;

public class VolWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		 
		MultipartRequest multi = FileUtil.createFile(request);
		
		volunteerboardVO board = new volunteerboardVO();
		board.setTitle(multi.getParameter("title"));
		board.setContent(multi.getParameter("content"));
		board.setReg_date(multi.getParameter("reg_date"));
		board.setMem_num(user_num);
		
		volunteerboardDAO dao = volunteerboardDAO.getInstance();
		dao.insertBoard(board);
		
		return "/WEB-INF/views/volunteer/volwrite.jsp";
	}

}
    