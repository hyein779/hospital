package kr.item.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;
import kr.util.FileUtil;

public class AdminModifyAction implements Action{

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
		
		// 관리자로 로그인
		MultipartRequest multi = FileUtil.createFile(request);
		
		int item_num = Integer.parseInt(multi.getParameter("item_num"));
		String item_photo = multi.getFilesystemName("item_photo");
		
		// DB에 저장된 정보
		ItemDAO dao = ItemDAO.getInstance();
		ItemVO db_item = dao.getItem(item_num);
		
		// 전송된 데이터 자바빈에 저장
		ItemVO item = new ItemVO();
		item.setItem_num(item_num);
		item.setItem_name(multi.getParameter("item_name"));
		item.setItem_price(Integer.parseInt(multi.getParameter("item_price")));
		item.setItem_quantity(Integer.parseInt(multi.getParameter("item_quantity")));
		item.setItem_photo(item_photo);
		item.setItem_detail(multi.getParameter("item_detail"));
		item.setItem_status(Integer.parseInt(multi.getParameter("item_status")));
		
		dao.updateItem(item);
		
		// 이전 파일 삭제
		if (item_photo != null) FileUtil.removeFile(request, db_item.getItem_photo());
		
		request.setAttribute("notice_msg", "상품 수정 완료");
		request.setAttribute("notice_url", request.getContextPath() + "/item/modifyForm.do?item_num=" + item_num);
		
		return "/WEB-INF/views/common/alert_singleView.jsp";
	}
}
