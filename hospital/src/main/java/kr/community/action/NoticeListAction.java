package kr.community.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.community.dao.NoticeDAO;
import kr.community.vo.NoticeVO;
import kr.controller.Action;
import kr.util.PageUtil;

public class NoticeListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum="1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		NoticeDAO dao = NoticeDAO.getInstance();
		int count = dao.getNoticeCount(keyfield, keyword);
		PageUtil page = new PageUtil(keyfield, keyword, Integer.parseInt(pageNum),count,15,10,"list.do");
		
		
		List<NoticeVO> list = null;
		if(count > 0) {
			list = dao.getListNotice(page.getStartRow(), page.getEndRow(), keyfield, keyword);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		// JSP 경로 반환			
		return "/WEB-INF/views/community/noticeList.jsp";
	}
}
