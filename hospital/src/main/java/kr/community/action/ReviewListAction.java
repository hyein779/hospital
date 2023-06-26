package kr.community.action;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.community.dao.ReviewDAO;
import kr.community.vo.ReviewVO;
import kr.controller.Action;
import kr.util.PageUtil;

public class ReviewListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		// 전송된 데이터 반환
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		}
		
		ReviewDAO dao = ReviewDAO.getInstance();
		int count = dao.getReviewCount();
		
		PageUtil page = new PageUtil(Integer.parseInt(pageNum), count, 16, 10, "reviewList.do");
		
		List<ReviewVO> list = null;
		if(count > 0) {
			list = dao.getReviewList(page.getStartRow(),page.getEndRow());
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		
		return "/WEB-INF/views/community/reviewList.jsp";
	}
}
