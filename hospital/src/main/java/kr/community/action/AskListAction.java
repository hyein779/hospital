package kr.community.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.community.dao.AskDAO;
import kr.community.vo.AskVO;
import kr.controller.Action;
import kr.util.PageUtil;

public class AskListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum = "1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		AskDAO dao = AskDAO.getInstance();
		int count = dao.getAskCount(keyfield, keyword);
		PageUtil page = new PageUtil(keyfield, keyword, Integer.parseInt(pageNum),count,15,10,"askList.do");
		
		List<AskVO> list = null;
		if(count > 0) {
			list = dao.getListBoard(page.getStartRow(), page.getEndRow(), keyfield, keyword);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		return "/WEB-INF/views/community/askList.jsp";
	}
}
