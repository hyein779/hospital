package kr.community.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.community.dao.NoticeDAO;
import kr.community.vo.NoticeVO;
import kr.controller.Action;
import kr.util.StringUtil;

public class NoticeDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 글번호
		int notice_num = Integer.parseInt(request.getParameter("notice_num"));
		NoticeDAO dao = NoticeDAO.getInstance(); 
		NoticeVO notice = dao.getNotice(notice_num);
		
		// 조회수
		dao.updateReadCount(notice_num);
		
		// HTML 태그를 허용하지 않음
		notice.setNotice_title(StringUtil.useNoHtml(notice.getNotice_title()));
		
		// HTML 태그를 허용하지 않으면서 줄바꿈처리
		notice.setNotice_content(StringUtil.useBrNoHtml(notice.getNotice_content()));
		
		request.setAttribute("notice", notice); 
		
		return "/WEB-INF/views/community/noticeDetail.jsp";
	}
}
