package kr.item.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.item.vo.ItemVO;
import kr.util.DBUtil;

public class ItemDAO {
	private static ItemDAO instance = new ItemDAO();
	public static ItemDAO getInstance() {
		return instance;
	}
	private ItemDAO() {}
	
	// 관리자 - 상품 등록
	public void insertItem(ItemVO item) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO item (item_num, item_name, item_price, item_quantity, item_photo, item_detail, item_status) VALUES (item_seq.nextval, ?, ?, ?, ?, ?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, item.getItem_name());
			pstmt.setInt(2, item.getItem_price());
			pstmt.setInt(3, item.getItem_quantity());
			pstmt.setString(4, item.getItem_photo());
			pstmt.setString(5, item.getItem_detail());
			pstmt.setInt(6, item.getItem_status());
			
			pstmt.executeUpdate();
		} catch(Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	// 관리자/사용자 - 전체 상품 갯수 / 검색 상품 갯수
	public int getItemCount(String keyfield, String keyword, int status) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			if (keyfield.equals("1")) sub_sql += "AND item_name LIKE ?";
			if (keyfield.equals("2")) sub_sql += "AND item_detail LIKE ?";
			
			sql = "SELECT COUNT(*) item WHERE item_status > ? " + sub_sql;
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, status);
			if (keyword != null && !"".equals(keyword)) {
				pstmt.setString(2, "%"+keyword+"%");
			}
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch(Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return count;
	}
	
	// 관리자/사용자 - 전체 상품 목록 / 검색 상품 목록
	public List<ItemVO> getListItem(int start, int end, String keyfield, String keyword, int status) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ItemVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			 if (keyword != null && !"".equals(keyword)) {
				 if (keyfield.equals("1")) sub_sql += "AND item_name LIKE ?";
				 if (keyfield.equals("2")) sub_sql += "AND item_detail LIKE ?";
			 }
			 
			sql = "SELECT * FROM (SELECT a. *, rownum rnum FROM (SELECT * FROM item WHERE item_status > ? " + sub_sql + " ORDER BY item_num DESC)a) WHERE rnum >= ? AND rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(++cnt, status);
			if (keyword != null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%"+keyword+"%");
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<ItemVO>();
			while(rs.next()) {
				ItemVO item = new ItemVO();
				item.setItem_num(rs.getInt("item_num"));
				item.setItem_name(rs.getString("item_name"));
				item.setItem_price(rs.getInt("item_price"));
				item.setItem_quantity(rs.getInt("item_quantity"));
				item.setItem_photo(rs.getString("item_photo"));
				item.setItem_status(rs.getInt("item_status"));
				
				list.add(item);
			}
		} catch(Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	// 관리자/사용자 - 상품 상세
	public ItemVO getItem(int item_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ItemVO item = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM item WHERE item_num = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, item_num);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				item = new ItemVO();
				item.setItem_num(rs.getInt("item_num"));
				item.setItem_name(rs.getString("item_name"));
				item.setItem_price(rs.getInt("item_price"));
				item.setItem_quantity(rs.getInt("item_quantity"));
				item.setItem_photo(rs.getString("item_photo"));
				item.setItem_detail(rs.getString("item_detail"));
				item.setItem_status(rs.getInt("item_status"));
			}
		} catch(Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return item;
	}
	
	// 관리자 - 상품 수정
	// 관리자 - 상품 삭제
}
