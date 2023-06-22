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
			cart.setMem_num(user_num);
			cart.setItem_num(Integer.parseInt(request.getParameter("item_num")));
			cart.setItem_count(Integer.parseInt(request.getParameter("item_count")));
			
			CartDAO dao = CartDAO.getInstance();
			CartVO db_cart = dao.getCart(cart);
			if (db_cart == null) { // 기존에 장바구니에 담긴 상품 없음
				dao.insertCart(cart);
				mapAjax.put("result", "success");
			} else { // 장바구니에 담긴 동일 상품 존재
				// 재고 수량 구하기
				ItemDAO itemDao = ItemDAO.getInstance();
				ItemVO item = itemDao.getItem(db_cart.getItem_num());
				
				// 구매 수량 합산
				int total_quantity = db_cart.getItem_count() + cart.getItem_count();
				
				if (item.getItem_quantity() < total_quantity) {
					mapAjax.put("result", "over_quantity");
				} else {
					cart.setItem_count(total_quantity);
					dao.upcateCartByItem_num(cart);
					mapAjax.put("result", "success");
				}
			}
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}
