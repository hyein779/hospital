package kr.community.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.community.dao.AskDAO;
import kr.community.vo.AskVO;
import kr.controller.Action;
import kr.util.StringUtil;

public class AskDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 글번호
		int ask_num = Integer.parseInt(request.getParameter("ask_num"));
		AskDAO dao = AskDAO.getInstance();
		AskVO ask = dao.getAsk(ask_num);
		
		// 조회수
		dao.updateReadcount(ask_num);
		
		// HTML 태그를 허용하지 않음
		ask.setAsk_title(StringUtil.useNoHtml(ask.getAsk_title()));
		
		// HTML 태그를 허용하지 않으면서 줄바꿈처리
		ask.setAsk_content(StringUtil.useBrNoHtml(ask.getAsk_content()));
		
		request.setAttribute("ask", ask);
		
		return "/WEB-INF/views/community/askDetail.jsp";
	}
}
