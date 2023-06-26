package kr.community.action;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.community.dao.AskDAO;
import kr.community.vo.ReplyVO;
import kr.controller.Action;
import kr.util.PageUtil;

public class ReplyListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) {
			pageNum = "1";
		}
		
		int ask_num = Integer.parseInt(request.getParameter("ask_num"));
		AskDAO dao = AskDAO.getInstance();
		int count = dao.getReplyCount(ask_num);
		
		// rownum 번호 구하기
		int rowCount = 10;
		PageUtil page = new PageUtil(Integer.parseInt(pageNum),count,rowCount);
		
		List<ReplyVO> list = null;
		if(count > 0) {
			list = dao.getReplyList(page.getStartRow(),page.getEndRow(), ask_num);
		}else { // 댓글이 없는 경우 Null이 아닌 비어있게 보내도록 처리
			list = Collections.emptyList();
		}
		
		HttpSession session = request.getSession();
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		Map<String,Object> mapAjax = new HashMap<String,Object>();
		mapAjax.put("count", count);
		mapAjax.put("rowCount", rowCount);
		mapAjax.put("list", list);
		// 관리자인지 체크하기 위해 전송
		mapAjax.put("user_auth", user_auth);
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}
