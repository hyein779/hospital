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
	//싱글턴패턴
	private static OrderDAO instance = new OrderDAO();
	public static OrderDAO getInstance() {
		return instance;
	}
	private OrderDAO() {}
	//주문등록1
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
	//관리자 - 전체주문개수/검색주문개수2
	public int getOrderCount(String keyfield, String keyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			 if(keyword != null && !"".equals(keyword)) {
				 if(keyfield.equals("1")) sub_sql += "WHERE order_num=?"; //같은경우
				 else if(keyfield.equals("2")) sub_sql += "WHERE id LIKE ?"; //포함된단어
				 else if (keyfield.equals("3")) sub_sql += "WHERE item_name LIKE ?"; //포함된단어
			 }
			sql = "SELECT COUNT(*) FROM zorder o JOIN zmember m ON o.mem_num=m.mem_num "
				+ sub_sql;	
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) {
					if(keyfield.equals("1")) {
						pstmt.setString(1, keyword);
					}else {
						pstmt.setString(1, "%"+keyword+"%");
						//LIKE를 사용했기에 좌우에 가변인자를 추가해야함. 
					}
				}
				//SQL문 실행
				rs = pstmt.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return count;
	}
	//관리자 - 전체주문목록/검색주문목록3
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
				 if(keyfield.equals("1")) sub_sql += "WHERE order_num=?"; //같은경우
				 else if(keyfield.equals("2")) sub_sql += "WHERE id LIKE ?"; //포함된단어
				 else if (keyfield.equals("3")) sub_sql += "WHERE item_name LIKE ?"; //포함된단어
			 }
			 
			 sql = "SELECT * FROM (SELECT a.*, rownum rnum "
				 + "FROM (SELECT * FROM zorder o JOIN zmember m ON o.mem_num=m.mem_num "
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
				order.setItem_name(rs.getString("item_name"));
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
	//사용자 - 전체주문개수/검색주문개수8
	//사용자 - 전체주문목록/검색주문목록
	//개별상품목록4
	//주문삭제(삭제 시 재고를 원상복귀시키지 않음, 주문취소일 때 원상 복구)7
	//관리자/사용자 주문 상세5
	//관리자/사용자 주문수정
	//사용자주문취소
}
