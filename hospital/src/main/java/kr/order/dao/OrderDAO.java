package kr.order.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.order.vo.OrderDetailVO;
import kr.order.vo.OrderVO;
import kr.util.DBUtil;

public class OrderDAO {
	//1.싱글턴패턴
	private static OrderDAO instance = new OrderDAO();
	public static OrderDAO getInstance() {
		return instance;
	}
	private OrderDAO() {}
	
	//2.주문등록
	public void insertOrder(OrderVO order,
						    List<OrderDetailVO> orderDetailList) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null;
		ResultSet rs = null;
		String sql = null;
		int order_num = 0;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//오토 커밋 해제
			conn.setAutoCommit(false);
			
			//1. order_num 구하기
			sql = "SELECT zorder_seq.nextval FROM dual"; //dual을 이용해 번호구하기
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				order_num = rs.getInt(1);
			}			
			
			//2. 주문정보저장_zorder
			sql = "INSERT INTO zorder (order_num,order_name,order_total,payment,"
				+ "receive_name,receive_post,receive_address1,receive_address2,receive_phone,notice,mem_num) "
				+ "VALUES (?,?,?,?,?,?,?,?,?,?,?)";
			pstmt2 = conn.prepareStatement(sql);
		
			pstmt2.setInt(1, order_num);
			pstmt2.setString(2, order.getOrder_name());
			pstmt2.setInt(3, order.getOrder_total());
			pstmt2.setInt(4, order.getPayment());
			pstmt2.setString(5, order.getReceive_name());
			pstmt2.setString(6, order.getReceive_post());
			pstmt2.setString(7, order.getReceive_address1());
			pstmt2.setString(8, order.getReceive_address2());
			pstmt2.setString(9, order.getReceive_phone());
			pstmt2.setString(10, order.getNotice());
			pstmt2.setInt(11, order.getMem_num());	
			
			pstmt2.executeUpdate();
			
			//3. 주문상세정보저장_zorder_detail
			sql = "INSERT INTO zorder_detail ("
				+ "detail_num,item_num,order_name,item_price,item_total,order_quantity,order_num) "
				+ "VALUES (zorder_detail_seq.nextval,?,?,?,?,?,?)";
			pstmt3 = conn.prepareStatement(sql);
			
			for(int i=0; i<orderDetailList.size(); i++) {
				OrderDetailVO orderDetail = orderDetailList.get(i);
				//데이터바인딩
				pstmt3.setInt(1, orderDetail.getItem_num());
				pstmt3.setString(2, orderDetail.getOrder_name());
				pstmt3.setInt(3, orderDetail.getItem_price());
				pstmt3.setInt(4, orderDetail.getItem_total());
				pstmt3.setInt(5, orderDetail.getOrder_quantity());
				pstmt3.setInt(6, order_num);
				pstmt3.addBatch();
				
				//OutOfMemory 방지
				if(i%1000 == 0) {
					pstmt3.executeBatch();
				}
			}//end of for
			pstmt3.executeBatch();
			
			//4. 상품의 재고수 차감
			sql = "UPDATE item SET item_quantity=item_quantity-? WHERE item_num=?";
			pstmt4 = conn.prepareStatement(sql);
			//데이터바인딩
			for(int i=0; i<orderDetailList.size(); i++) {
				OrderDetailVO orderDetail = orderDetailList.get(i);
				pstmt4.setInt(1, orderDetail.getOrder_quantity());
				pstmt4.setInt(2, orderDetail.getItem_num());
				pstmt4.addBatch(); //쿼리를 메모리에 올림
				
				//OutOfMemory 방지
				if(i%1000 == 0) {
					pstmt4.executeBatch();
				}
			}//end of for
			pstmt4.executeBatch();
			
			//5. 장바구니에서 주문 상품 삭제
			sql = "DELETE FROM cart WHERE mem_num=?";
			pstmt5 = conn.prepareStatement(sql);
			pstmt5.setInt(1, order.getMem_num());
			pstmt5.executeUpdate();
			
			//모든 SQL문이 정상 수행
			conn.commit();
		}catch(Exception e) {
			//1개 이상의 SQL문 실패
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt5, conn);
		}
		
		
	}
	//3. 관리자 - 전체주문개수/검색주문개수
	public int getOrderCount(String keyfield,String keyword) throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE order_num =?"; //같은경우
				else if(keyfield.equals("2")) sub_sql += "WHERE mem_id LIKE ?"; //포함된단어
				else if(keyfield.equals("3")) sub_sql += "WHERE item_name LIKE ?"; //포함된단어
			}
			
			sql = "SELECT COUNT(*) FROM zorder o JOIN member m ON o.mem_num=m.mem_num "
				+ sub_sql;
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) {
					pstmt.setString(1, keyword);
				}else {
					pstmt.setString(1, "%"+keyword+"%");
				}
			}
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return count;
	}
	//4. 관리자 - 전체주문목록/검색주문목록
	public List<OrderVO> getListOrder(int start, int end,
								      String keyfield,
								      String keyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<OrderVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			 if(keyword != null && !"".equals(keyword)) {
				 if(keyfield.equals("1")) sub_sql += "WHERE order_num=?";
				 else if(keyfield.equals("2")) sub_sql += "WHERE mem_id LIKE ?";
				 else if (keyfield.equals("3")) sub_sql += "WHERE order_name LIKE ?";
			 }
			 
			 sql = "SELECT * FROM (SELECT a.*, rownum rnum "
				 + "FROM (SELECT * FROM zorder o JOIN member m ON o.mem_num=m.mem_num "
				 + sub_sql + " ORDER BY order_num DESC)a) "
				 + "WHERE rnum >= ? AND rnum <= ?";
			 pstmt = conn.prepareStatement(sql);
			 
			if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) {
					pstmt.setString(++cnt, keyword);
				}else {
					pstmt.setString(++cnt, "%"+keyword+"%");
				}
			}	
			
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<OrderVO>();
			while(rs.next()) {
				OrderVO order = new OrderVO();
				order.setOrder_num(rs.getInt("order_num"));
				order.setOrder_name(rs.getString("order_name"));
				order.setOrder_total(rs.getInt("order_total"));
				order.setPayment(rs.getInt("payment"));
				order.setStatus(rs.getInt("status"));
				order.setReceive_name(rs.getString("receive_name"));
				order.setReceive_post(rs.getString("receive_post"));
				order.setReceive_address1(rs.getString("receive_address1"));
				order.setReceive_address2(rs.getString("receive_address2"));
				order.setReceive_phone(rs.getString("receive_phone"));
				order.setNotice(rs.getString("notice"));
				order.setReg_date(rs.getDate("reg_date"));
				order.setMem_num(rs.getInt("mem_num"));
				order.setId(rs.getString("mem_id"));
				
				list.add(order);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	//9. 사용자 - 전체주문개수/검색주문개수
	public int getOrderCountByMem_num(String keyfield, String keyword,
									  int mem_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "AND order_num=?";
				else if(keyfield.equals("2")) sub_sql += "AND item_name LIKE ?";
			}
			
			sql = "SELECT COUNT(*) FROM zorder WHERE mem_num=?" + sub_sql;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) {
					pstmt.setString(2, keyword);
				}else if(keyfield.equals("2")) {
					pstmt.setString(2, "%"+keyword+"%");
				}
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return count;
	}
	//10. 사용자 - 전체주문목록/검색주문목록
	public List<OrderVO> getListOrderByMem_num(int start, int end,
											   String keyfield,
											   String keyword,
											   int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<OrderVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "AND order_num=?";
				else if(keyfield.equals("2")) sub_sql += "AND item_name LIKE ?";
			}
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
				+ "(SELECT * FROM zorder WHERE mem_num=? "
				+ sub_sql + " ORDER BY order_num DESC)a) WHERE rnum>=? AND rnum<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(++cnt, mem_num);
			if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) {
					pstmt.setString(++cnt, keyword);
				}else if(keyfield.equals("2")) {
					pstmt.setString(++cnt, "%"+keyword+"%");
				}
			}	
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<OrderVO>();
			while(rs.next()) {
				OrderVO order = new OrderVO();
				order.setOrder_num(rs.getInt("order_num"));
				order.setOrder_name(rs.getString("order_name"));
				order.setOrder_total(rs.getInt("order_total"));
				order.setPayment(rs.getInt("payment"));
				order.setStatus(rs.getInt("status"));
				order.setReceive_name(rs.getString("receive_name"));
				order.setReceive_post(rs.getString("receive_post"));
				order.setReceive_address1(rs.getString("receive_address1"));
				order.setReceive_address2(rs.getString("receive_address2"));
				order.setReceive_phone(rs.getString("receive_phone"));
				order.setNotice(rs.getString("notice"));
				order.setReg_date(rs.getDate("reg_date"));
				order.setMem_num(rs.getInt("mem_num"));	
				
				list.add(order);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}

	//5. 개별상품목록
	public List<OrderDetailVO> getListOrderDetail(int order_num) throws Exception{
		//배송 취소 시 다시 원래대로 돌아갈 수 없음.
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<OrderDetailVO> list = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM zorder_detail WHERE order_num=? ORDER BY item_num DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_num);
			rs = pstmt.executeQuery();
			list = new ArrayList<OrderDetailVO>();
			
			while(rs.next()) {
				OrderDetailVO detail = new OrderDetailVO();
				detail.setItem_num(rs.getInt("item_num"));
				detail.setOrder_name(rs.getString("order_name"));
				detail.setItem_price(rs.getInt("item_price"));
				detail.setItem_total(rs.getInt("item_total"));
				detail.setOrder_quantity(rs.getInt("order_quantity"));
				detail.setOrder_num(rs.getInt("order_num"));
				
				list.add(detail);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	//8. 주문삭제
	public void deleteOrder(int order_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			sql = "DELETE FROM zorder_detail WHERE order_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_num);
			pstmt.executeUpdate();
			
			sql = "DELETE FROM zorder WHERE order_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, order_num);
			pstmt2.executeUpdate();
			
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//6. 관리자/사용자 주문 상세
	public OrderVO getOrder(int order_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		OrderVO order = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM zorder WHERE order_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				order = new OrderVO();
				order.setOrder_num(rs.getInt("order_num"));
				order.setOrder_name(rs.getString("order_name"));
				order.setOrder_total(rs.getInt("order_total"));
				order.setPayment(rs.getInt("payment"));
				order.setStatus(rs.getInt("status"));
				order.setReceive_name(rs.getString("receive_name"));
				order.setReceive_post(rs.getString("receive_post"));
				order.setReceive_address1(rs.getString("receive_address1"));
				order.setReceive_address2(rs.getString("receive_address2"));
				order.setReceive_phone(rs.getString("receive_phone"));
				order.setNotice(rs.getString("notice"));
				order.setReg_date(rs.getDate("reg_date"));
				order.setMem_num(rs.getInt("mem_num"));			
			}			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return order;
	}
	//7. 관리자/사용자 주문수정
	public void updateOrder(OrderVO order) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			OrderVO db_order = getOrder(order.getOrder_num()); //화면전송데이터=DB저장데이터
			if(order.getStatus() == 1 && db_order.getStatus() == 1) {
				sub_sql += "receive_name=?,receive_post=?,receive_address1=?,receive_address2=?,receive_phone=?,notice=?,";
			}
			sql = "UPDATE zorder SET status=?," + sub_sql + "modify_date=SYSDATE WHERE order_num=?";
			pstmt = conn.prepareStatement(sql);
			//데이터바인딩
			pstmt.setInt(++cnt, order.getStatus());
			if(order.getStatus()==1 && db_order.getStatus()==1) {
				pstmt.setString(++cnt,order.getReceive_name());
				pstmt.setString(++cnt,order.getReceive_post());
				pstmt.setString(++cnt,order.getReceive_address1());
				pstmt.setString(++cnt,order.getReceive_address2());
				pstmt.setString(++cnt,order.getReceive_phone());
				pstmt.setString(++cnt,order.getNotice());
			}
			pstmt.setInt(++cnt, order.getOrder_num());
			
			pstmt.executeUpdate();
			
			//주문 취소일 때 상품 개수 조절
			if(order.getStatus() == 5) {
				//주문번호에 해당하는 상품정보 구하기
				List<OrderDetailVO> detailList = getListOrderDetail(order.getOrder_num());
				
				sql = "UPDATE item SET item_quantity=item_quantity+? WHERE item_num=?";
				pstmt2 = conn.prepareStatement(sql);
				for(int i=0; i<detailList.size(); i++) {
					OrderDetailVO detail = detailList.get(i);
					pstmt2.setInt(1, detail.getOrder_quantity());
					pstmt2.setInt(2, detail.getItem_num());
					pstmt2.addBatch();
					
					if(i%1000 == 0) {
						pstmt2.executeBatch();
					}
				}//end of for
				pstmt2.executeBatch();
			}//end of if
			
			//모든 SQL문 성공시
			conn.commit();
		}catch(Exception e) {
			//1개 이상의 SQL문 실패시
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//11.사용자주문취소
	public void updateOrderCancel(int order_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			sql = "UPDATE zorder SET status=5, modify_date=SYSDATE WHERE order_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, order_num);
			pstmt.executeUpdate();
			
			//주문번호에 해당하는 상품정보 구하기
			List<OrderDetailVO> detailList = getListOrderDetail(order_num);
			sql = "UPDATE item SET item_quantity=item_quantity+? WHERE item_num=?";
			pstmt2 = conn.prepareStatement(sql);
			for(int i=0; i<detailList.size(); i++) {
				OrderDetailVO detail = detailList.get(i);
				pstmt2.setInt(1, detail.getOrder_quantity());
				pstmt2.setInt(2, detail.getItem_num());
				pstmt2.addBatch();
				
				if(i%1000 == 0) {
					pstmt2.executeBatch();
				}
			}
			pstmt2.executeBatch();
			conn.commit();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}
