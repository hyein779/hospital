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

public class ReplyWriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String,String> mapAjax = new HashMap<String, String>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_num==null) { // 로그인 되지 않은 경우
			mapAjax.put("result", "logout");
		}else if(user_auth != 9){
			mapAjax.put("result", "notAdmin");
		}else { // 로그인 된 경우
			request.setCharacterEncoding("utf-8");
			
			ReplyVO reply = new ReplyVO();
			reply.setRe_content(request.getParameter("re_content"));
			reply.setAsk_num(Integer.parseInt(request.getParameter("ask_num")));
			
			AskDAO dao = AskDAO.getInstance();
			dao.insertReply(reply);
			
			mapAjax.put("result","success");
		}
		
		// JSON 데이터 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
