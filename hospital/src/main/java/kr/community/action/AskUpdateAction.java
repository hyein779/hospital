package kr.community.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.community.dao.AskDAO;
import kr.community.vo.AskVO;
import kr.controller.Action;

public class AskUpdateAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_num==null) { // 로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		// 로그인 된 경우
		request.setCharacterEncoding("utf-8");
		int ask_num = Integer.parseInt(request.getParameter("ask_num"));
		
		AskDAO dao = AskDAO.getInstance();
		
		// 수정 전 데이터 반환
		AskVO db_ask = dao.getAsk(ask_num);
		// 로그인한 회원번호와 작성자 회원번호 일치 여부 체크
		if(user_num != db_ask.getMem_num()) {
			// 로그인한 회원번호와 작성자 회원번호가 불일치하면서 관리자가 아닌 경우
			if(user_auth != 9) {
				return "/WEB-INF/views/common/notice.jsp";
			}
		}
		
		// 로그인한 회원번호와 작성자 회원번호가 일치하거나 관리자인 경우
		AskVO ask = new AskVO();
		ask.setAsk_num(ask_num);
		ask.setAsk_title(request.getParameter("ask_title"));
		ask.setAsk_content(request.getParameter("ask_content"));
		
		dao.updateAsk(ask);
		
		return "redirect:/community/askDetail.do?ask_num="+ask_num;
	}
}
