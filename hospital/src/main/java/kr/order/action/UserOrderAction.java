package kr.order.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.cart.dao.CartDAO;
import kr.cart.vo.CartVO;
import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;
import kr.order.dao.OrderDAO;
import kr.order.vo.OrderDetailVO;
import kr.order.vo.OrderVO;

public class UserOrderAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) { //로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		//POST 방식의 접근만 허용
		if(request.getMethod().toUpperCase().equals("GET")) {
			return "redirect:/item/itemList.do";
		}
		
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		CartDAO dao = CartDAO.getInstance();
		int all_total = dao.getTotalByMem_num(user_num);
		if(all_total<=0) {
			request.setAttribute("notice_msg", "정상적인 주문이 아니거나 상품의 수량이 부족합니다.");
			request.setAttribute("notice_url", 
								 request.getContextPath()+"/item/itemList.do");
			return "/WEB-INF/views/common/alert_singleView.jsp";
		}
		
		//장바구니에 담겨 있는 상품 정보 반환
		List<CartVO> cartList = dao.getListCart(user_num);
		
		//주문 상품의 대표 상품명 생성
		String order_name;
		if(cartList.size()==1) { //상품이 하나인 경우
			order_name = cartList.get(0).getItemVO().getItem_name();
		}else {
			order_name = cartList.get(0).getItemVO().getItem_name() + " 외 " + (cartList.size()-1) + "건";
		}
		
		//개별 상품 정보 담기
		List<OrderDetailVO> orderDetailList = new ArrayList<OrderDetailVO>();
		ItemDAO itemDao = ItemDAO.getInstance();
		
		for(CartVO cart : cartList) {
			//주문하는 상품정보 읽기
			ItemVO item = itemDao.getItem(cart.getItem_num());
			//조건 체크하며 ArrayList에 값을 저장
			if(item.getItem_status()==1) {
				//상품 미표시
				request.setAttribute("notice_msg", "["+item.getItem_num()+"]상품판매 중지");
				request.setAttribute("notice_url", 
									 request.getContextPath()+"/cart/list.do");
				return "/WEB-INF/views/common/alert_singleView.jsp";
			}
			
			if(item.getItem_quantity() < cart.getItem_count()) {
				//상품 재고 수량 부족
				request.setAttribute("notice_msg", "["+item.getItem_name()+"]재고수량 부족으로 주문불가");
				request.setAttribute("notice_url", 
									 request.getContextPath()+"/cart/list.do");
			}
			
			OrderDetailVO orderDetail = new OrderDetailVO();
			orderDetail.setItem_num(cart.getItem_num());
			orderDetail.setOrder_name(cart.getItemVO().getItem_name());
			orderDetail.setItem_price(cart.getItemVO().getItem_price());
			orderDetail.setOrder_quantity(cart.getItem_count());
			orderDetail.setItem_total(cart.getSub_total());
			
			orderDetailList.add(orderDetail); //ArrayList에 저장
		}//end of for
		
		//구매 정보 담기
		OrderVO order = new OrderVO();
		order.setOrder_name(order_name);
		order.setOrder_total(all_total);
		order.setPayment(Integer.parseInt(request.getParameter("payment")));
		order.setReceive_name(request.getParameter("receive_name"));
		order.setReceive_post(request.getParameter("receive_post"));
		order.setReceive_address1(request.getParameter("receive_address1"));
		order.setReceive_address2(request.getParameter("receive_address2"));
		order.setReceive_phone(request.getParameter("receive_phone"));
		order.setNotice(request.getParameter("notice"));
		order.setMem_num(user_num);
		
		OrderDAO orderDao = OrderDAO.getInstance();
		orderDao.insertOrder(order, orderDetailList);
		
		//refresh 정보를 응답 헤더에 추가
		response.addHeader("Refresh", "/main/main.do");
		request.setAttribute("accessMsg", "주문이 완료되었습니다.");
		request.setAttribute("accessUrl", request.getContextPath()+"/member/itemList.do");
		
		return "/WEB-INF/views/common/notice.jsp";
	}
}
