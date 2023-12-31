package kr.community.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.community.dao.AskDAO;
import kr.community.vo.ReplyVO;
import kr.controller.Action;

public class ReplyUpdateAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		// 댓글 번호
		int re_num = Integer.parseInt(request.getParameter("re_num"));
		AskDAO dao = AskDAO.getInstance();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		if(user_num==null) { // 로그인이 되지 않은 경우
			mapAjax.put("result", "logout");
		}else if(user_num!=null && user_auth == 9) {
			// 관리자로 로그인한 경우
			ReplyVO reply = new ReplyVO();
			reply.setRe_num(re_num);
			reply.setRe_content(request.getParameter("re_content"));
			
			dao.updateReply(reply);
			
			mapAjax.put("result", "success");
		}else { 
			// 관리자가 아닌 경우
			mapAjax.put("result", "wrongAccess");
		}
		
		// JSON 데이터 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		// JSP 경로 반환		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
