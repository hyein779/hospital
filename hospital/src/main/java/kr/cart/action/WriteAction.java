package kr.cart.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.cart.dao.CartDAO;
import kr.cart.vo.CartVO;
import kr.controller.Action;

public class WriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if (user_num == null) {
			mapAjax.put("result", "logout");
		} else {
			request.setCharacterEncoding("utf-8");
			
			CartVO cart = new CartVO();
			cart.setItem_num(Integer.parseInt(request.getParameter("item_num")));
			cart.setItem_count(Integer.parseInt(request.getParameter("item_count")));
			cart.setMem_num(user_num);
			
			CartDAO dao = CartDAO.getInstance();
			dao.insertCart(cart);
			mapAjax.put("result", "success");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}
