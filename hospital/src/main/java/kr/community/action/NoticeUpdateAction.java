package kr.community.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.community.dao.NoticeDAO;
import kr.community.vo.NoticeVO;
import kr.controller.Action;

public class NoticeUpdateAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 여부 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) { // 로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth != 9) { // 관리자로 로그인하지 않은 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		// 관리자로 로그인한 경우
		request.setCharacterEncoding("utf-8");
		
		int notice_num = Integer.parseInt(request.getParameter("notice_num"));
		
		NoticeDAO dao = NoticeDAO.getInstance();
		// 수정 전 데이터 반환
		/* NoticeVO db_notice = dao.getNotice(notice_num); */
		
		NoticeVO notice = new NoticeVO();
		notice.setNotice_num(notice_num);
		notice.setNotice_title(request.getParameter("notice_title"));
		notice.setNotice_content(request.getParameter("notice_content"));
		
		dao.updateNotice(notice);
		
		return "redirect:/community/noticeDetail.do?notice_num="+notice_num;
	}
}