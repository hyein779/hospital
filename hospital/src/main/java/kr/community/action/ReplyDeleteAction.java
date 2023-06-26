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

public class ReplyDeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int re_num = Integer.parseInt(request.getParameter("re_num"));
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		AskDAO dao = AskDAO.getInstance();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_num == null) { // 로그인 되지 않은 경우
			mapAjax.put("result", "logout");
		}else if(user_num != null && user_auth == 9) { // 관리자로 로그인한 경우
			dao.deleteReply(re_num);
			mapAjax.put("result", "success");
		}else { // 관리자로 로그인하지 않은 경우
			mapAjax.put("result", "notAdmin");
		}
		
		// JSON 데이터 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}
