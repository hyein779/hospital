package kr.community.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.community.dao.AskDAO;
import kr.community.vo.AskVO;
import kr.controller.Action;

public class AskWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 여부 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) { // 로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		// 로그인 된 경우
		request.setCharacterEncoding("utf-8");
		AskVO ask = new AskVO();
		ask.setAsk_title(request.getParameter("ask_title"));
		ask.setAsk_content(request.getParameter("ask_content"));
		ask.setMem_num(user_num); // 작성자(회원번호)
		
		AskDAO dao = AskDAO.getInstance();
		dao.insertAsk(ask);
		
		return "/WEB-INF/views/community/askWrite.jsp";
	}
}
