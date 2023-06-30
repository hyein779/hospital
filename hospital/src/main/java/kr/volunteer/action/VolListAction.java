package kr.volunteer.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.util.PageUtil;
import kr.volunteerboard.vo.volunteerboardVO;
import kr.volunteerboardDAO.volunteerboardDAO;

public class VolListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum="1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		volunteerboardDAO dao = volunteerboardDAO.getInstance();
		int count = dao.getBoardCount(keyfield,keyword);		
		PageUtil page = new PageUtil(keyfield,keyword,Integer.parseInt(pageNum),count,10,10,"volList.do");
		
		List<volunteerboardVO> list = null;
		if(count>0) {
			list = dao.getListBoard(page.getStartRow(), page.getEndRow(), keyfield, keyword); 
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		 
		return "/WEB-INF/views/volunteer/list.jsp";
	} 

}
