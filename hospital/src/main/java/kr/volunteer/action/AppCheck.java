package kr.volunteer.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.volunteerboard.vo.appvolunteerVO;
import kr.volunteerboard.vo.volunteerboardVO;
import kr.volunteerboardDAO.appvolunteerDAO;
import kr.volunteerboardDAO.volunteerboardDAO;

public class AppCheck implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");

		int board_num = Integer.parseInt(request.getParameter("board_num"));
		
		appvolunteerDAO dao = appvolunteerDAO.getInstance();
		appvolunteerVO app = dao.checkApp(board_num,user_num);
		
		volunteerboardDAO vdao = volunteerboardDAO.getInstance();
		volunteerboardVO board = vdao.getBoardTotal(board_num);
		
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		
		if(app==null && board.getQuantity()==0) {
			mapAjax.put("result", "zero");
		}else if(app==null && board.getQuantity()!=0) {
			mapAjax.put("result", "appNotFound");
		}else if(app!=null && board.getQuantity()==0) {
			mapAjax.put("result", "zero");
		}else if(app!=null && board.getQuantity()!=0) {
			mapAjax.put("result", "appDuplicated");
		}
		
		
		ObjectMapper mapper = new ObjectMapper();
		
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
