package kr.volunteer.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.util.FileUtil;
import kr.volunteerboard.vo.volunteerboardVO;
import kr.volunteerboardDAO.volunteerboardDAO;

public class VolWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth < 9) { // 관리자로 로그인하지 않은 경우
			return "/WEB-INF/views/common/volunteer.jsp";
		}
		 
		// 관리자로 로그인한 경우
		request.setCharacterEncoding("utf-8");
		
		volunteerboardVO board = new volunteerboardVO();
		board.setTitle(request.getParameter("title"));
		board.setContent(request.getParameter("content"));
		board.setReg_date(request.getParameter("reg_date"));
		board.setQuantity(Integer.parseInt(request.getParameter("quantity")));
		board.setMem_num(user_num);
		
		volunteerboardDAO dao = volunteerboardDAO.getInstance();
		dao.insertBoard(board);
		
		return "/WEB-INF/views/volunteer/volwrite.jsp";
	}

}
    