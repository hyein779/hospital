package kr.community.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.community.dao.ReviewDAO;
import kr.community.vo.ReviewVO;
import kr.controller.Action;
import kr.util.StringUtil;

public class ReviewWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 여부 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) { // 로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		// 로그인 된 경우
		request.setCharacterEncoding("utf-8");
		ReviewVO review = new ReviewVO();
		review.setRev_type(Integer.parseInt(request.getParameter("rev_type")));
		review.setRev_title(request.getParameter("rev_title"));
		review.setRev_content(StringUtil.useBrNoHtml(request.getParameter("rev_content")));
		review.setMem_num(user_num);
		
		ReviewDAO dao = ReviewDAO.getInstance();
		dao.insertReview(review);
		return "/WEB-INF/views/community/reviewWrite.jsp";
	}

}
