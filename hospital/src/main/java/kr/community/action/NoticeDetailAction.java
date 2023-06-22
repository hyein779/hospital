package kr.community.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.community.dao.NoticeDAO;
import kr.community.vo.NoticeVO;
import kr.controller.Action;

public class NoticeDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 글번호
		int notice_num = Integer.parseInt(request.getParameter("notice_num"));
		NoticeDAO dao = NoticeDAO.getInstance();
		NoticeVO notice = dao.getNotice(notice_num);
		
		request.setAttribute("notice", notice);
		
		return "/WEB-INF/views/community/noticeDetail.jsp";
	}
}
