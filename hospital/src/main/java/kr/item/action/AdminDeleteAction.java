package kr.item.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;
import kr.util.FileUtil;

public class AdminDeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if (user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if (user_auth < 9) {
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		int item_num = Integer.parseInt(request.getParameter("item_num"));
		
		ItemDAO dao = ItemDAO.getInstance();
		ItemVO db_item = dao.getItem(item_num);
		
		dao.deleteItem(item_num);
		
		FileUtil.removeFile(request, db_item.getItem_photo());
		
		request.setAttribute("notice_msg", "삭제 완료");
		request.setAttribute("notice_url", request.getContextPath() + "/item/list.do");
		
		return "/WEB-INF/views/common/alert_singleView.jsp";
	}
}
