package kr.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.order.vo.OrderVO;
import kr.util.PageUtil;

public class UserItemListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do?page_url=/member/itemList.do";
		}
		//로그인이 된 경우
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum = "1";
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		MemberDAO orderDao = MemberDAO.getInstance();
		int count = orderDao.getOrderCountByMem_num(keyfield, keyword, user_num);
		
		//페이지처리
		PageUtil page = new PageUtil(keyfield, keyword, Integer.parseInt(pageNum),count,20,10,"orderList.do");
		List<OrderVO> list = null;
		if(count > 0) {
			list = orderDao.getListOrderByMem_num(page.getStartRow(), page.getEndRow(), keyfield, keyword, user_num);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		return "/WEB-INF/views/member/user_orderList.jsp";
	}

}
