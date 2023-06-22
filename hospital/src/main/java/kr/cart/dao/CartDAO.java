package kr.cart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.cart.vo.CartVO;
import kr.item.vo.ItemVO;
import kr.util.DBUtil;

public class CartDAO {
	private static CartDAO instance = new CartDAO();
	public static CartDAO getInstance() {
		return instance;
	}
	private CartDAO() {}
	
	// 장바구니 등록
	public void insertCart(CartVO cart) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO cart (cart_num, mem_num, item_num, item_count) VALUES (cart_seq.nextval, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart.getMem_num());
			pstmt.setInt(2, cart.getItem_num());
			pstmt.setInt(3, cart.getItem_count());
			
			pstmt.executeUpdate(); 
		} catch(Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	// 회원번호별 총 구매 금액
	public int getTotalByMem_num(int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int total = 0;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT SUM(sub_total) FROM (SELECT c.mem_num, c.item_count * i.item_price AS sub_total FROM cart c JOIN item i ON c.item_num = i.item_num) WHERE mem_num = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				total = rs.getInt(1);
			}
		} catch(Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return total;
	}
	
	
	// 장바구니 목록
	public List<CartVO> getListCart(int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CartVO> list = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM cart c JOIN item i ON c.item_num = i.item_num WHERE c.mem_num = ? ORDER BY i.item_num ASC";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<CartVO>();
			while(rs.next()) {
				CartVO cart = new CartVO();
				cart.setCart_num(rs.getInt("cart_num"));
				cart.setMem_num(rs.getInt("mem_num"));
				cart.setItem_num(rs.getInt("item_num"));
				cart.setItem_count(rs.getInt("item_count"));
				
				ItemVO item = new ItemVO();
				item.setItem_name(rs.getString("item_name"));
				item.setItem_price(rs.getInt("item_price"));
				item.setItem_photo(rs.getString("item_photo"));
				item.setItem_quantity(rs.getInt("item_quantity"));
				item.setItem_status(rs.getInt("item_status"));
				
				cart.setItemVO(item);
				
				cart.setSub_total(cart.getItem_count() * item.getItem_price());
				
				list.add(cart);
			}
		} catch(Exception e) {
			 throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	// 장바구니 상세
	public CartVO getCart(CartVO cart) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CartVO currentCart = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM cart WHERE item_num = ? AND mem_num = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart.getItem_num());
			pstmt.setInt(2, cart.getMem_num());
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				currentCart = new CartVO();
				currentCart.setCart_num(rs.getInt("cart_num"));
				currentCart.setItem_num(rs.getInt("item_num"));
				currentCart.setItem_count(rs.getInt("item_count"));
			}
		} catch(Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return currentCart;
	}
	
	// 장바구니 수정
	public void updateCart(CartVO cart) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE cart SET item_count = ? WHERE cart_nun = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart.getItem_count());
			pstmt.setInt(2, cart.getCart_num());
			
			pstmt.executeUpdate();
		} catch(Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	// 장바구니 상품번호와 회원번호별 수정
	public void upcateCartByItem_num(CartVO cart) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE cart SET item_count = ? WHERE item_num = ? AND mem_num = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart.getItem_count());
			pstmt.setInt(2, cart.getItem_num());
			pstmt.setInt(3, cart.getMem_num());
			
			pstmt.executeUpdate();
		} catch(Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	// 장바구니 삭제
	public void deleteCart(int cart_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "DELETE FROM cart WHERE cart_num =?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart_num);
			
			pstmt.executeUpdate();
		} catch(Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}
