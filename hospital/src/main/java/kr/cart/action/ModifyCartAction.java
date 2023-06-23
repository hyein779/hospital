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
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;

public class ModifyCartAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, String> mapAjax = new HashMap<String, String>();
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if (user_num == null) {
			mapAjax.put("result", "logout");
		} else {
			request.setCharacterEncoding("utf-8");
			
			int item_num = Integer.parseInt(request.getParameter("item_num"));
			int item_count = Integer.parseInt(request.getParameter("item_count"));
			ItemDAO itemDAO = ItemDAO.getInstance();
			ItemVO item = itemDAO.getItem(item_num);
			
			if (item.getItem_status() == 1) { // 판매 중 아님
				mapAjax.put("result", "noSale");
			} else if (item.getItem_quantity() < item_count) { // 주문 수량 > 재고 수량
				mapAjax.put("result", "noQuantity");
			} else { // 정상인 경우
				CartVO cart = new CartVO();
				cart.setCart_num(Integer.parseInt(request.getParameter("cart_num")));
				cart.setItem_count(item_count);
				
				CartDAO cartDAO = CartDAO.getInstance();
				cartDAO.updateCart(cart);
				
				mapAjax.put("result", "success");
			}
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
