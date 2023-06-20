package kr.item.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;
import kr.util.FileUtil;

public class AdminWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if (user_num == null) { // 미로그인 상태
			return "redirect:/member/loginForm.do";
		}
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if (user_auth < 9) { // 관리자가 아님
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		// 관리자로 로그인한 경우
		MultipartRequest multi = FileUtil.createFile(request);
		
		ItemVO item = new ItemVO();
		item.setItem_name(multi.getParameter("item_name"));
		item.setItem_price(Integer.parseInt(multi.getParameter("item_price")));
		item.setItem_quantity(Integer.parseInt(multi.getParameter("item_quantity")));
		item.setItem_photo(multi.getFilesystemName("item_photo"));
		item.setItem_detail(multi.getParameter("item_detail"));
		item.setItem_status(Integer.parseInt(multi.getParameter("item_status")));
		
		ItemDAO dao = ItemDAO.getInstance();
		dao.insertItem(item);
		
		response.addHeader("Refresh", "2;url=list.do");
		request.setAttribute("accessMsg", "성공적으로 등록되었습니다.");
		request.setAttribute("accessUrl", "list.do");
		
		return "/WEB-INF/views/common/notice.jsp";
	}
}
