package kr.reservation.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.reservation.vo.ReservationVO;
import kr.reservation.vo.TReservationVO;
import kr.util.DBUtil;

public class ReservationDAO {
	//싱글턴 패턴
	private static ReservationDAO instance = new ReservationDAO();
	public static ReservationDAO getInstance() {
		return instance;
	}
	private ReservationDAO() {}
	
	//의사 정보
	public ReservationVO getDoc(int doc_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReservationVO reservation = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM doc WHERE doc_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, doc_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reservation = new ReservationVO();
				reservation.setDoc_num(rs.getInt("doc_num"));
				reservation.setDoc_name(rs.getString("doc_name"));
				reservation.setDoc_content(rs.getString("doc_content"));
				reservation.setDoc_photo(rs.getString("doc_photo"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return reservation;
	}
	
	//치료 정보
	public TReservationVO getTreat(int treat_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TReservationVO reservation = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM treat WHERE treat_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, treat_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reservation = new TReservationVO();
				reservation.setTreat_num(rs.getInt("treat_num"));
				reservation.setTreat_name(rs.getString("treat_name"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return reservation;
	}
	
	//예약 정보 insert
	public void insertRes(ReservationVO reservation) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO reservation (res_num,res_date,res_time,res_status,res_select,mem_num,doc_num,res_content) "
					+ "VALUES (reservation_seq.nextval,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reservation.getRes_date());
			pstmt.setString(2, reservation.getRes_time());
			pstmt.setInt(3, 1);
			pstmt.setInt(4, 1);
			pstmt.setInt(5, reservation.getMem_num());
			pstmt.setInt(6, reservation.getDoc_num());
			pstmt.setString(7, reservation.getRes_content());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//치료 예약 insert
	public void insertTRes(TReservationVO reservation) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO treservation (res_num,res_date,res_time,res_status,res_select,mem_num,treat_num,res_content) "
					+ "VALUES (treservation_seq.nextval,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reservation.getRes_date());
			pstmt.setString(2, reservation.getRes_time());
			pstmt.setInt(3, 1);
			pstmt.setInt(4, 1);
			pstmt.setInt(5, reservation.getMem_num());
			pstmt.setInt(6, reservation.getTreat_num());
			pstmt.setString(7, reservation.getRes_content());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//예약 정보 select
	public ReservationVO getRes(int res_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReservationVO reservation = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM reservation WHERE res_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, res_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reservation = new ReservationVO();
				reservation.setRes_num(rs.getInt("res_num"));
				reservation.setRes_date(rs.getString("res_date"));
				reservation.setRes_time(rs.getString("res_time"));
				reservation.setRes_status(rs.getInt("res_status"));
				reservation.setRes_select(rs.getInt("res_select"));
				reservation.setMem_num(rs.getInt("mem_num"));
				reservation.setDoc_num(rs.getInt("doc_num"));
				reservation.setRes_content(rs.getString("res_content"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return reservation;
	}	
	
	//치료 예약 select
	public TReservationVO getTRes(int res_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		TReservationVO reservation = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM treservation WHERE res_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, res_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reservation = new TReservationVO();
				reservation.setRes_num(rs.getInt("res_num"));
				reservation.setRes_date(rs.getString("res_date"));
				reservation.setRes_time(rs.getString("res_time"));
				reservation.setRes_status(rs.getInt("res_status"));
				reservation.setRes_select(rs.getInt("res_select"));
				reservation.setMem_num(rs.getInt("mem_num"));
				reservation.setTreat_num(rs.getInt("treat_num"));
				reservation.setRes_content(rs.getString("res_content"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return reservation;
	}	
	
	//사용자 진료 예약 목록
	public int getResCount(int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count  = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT COUNT(*) FROM reservation JOIN member USING(mem_num) WHERE mem_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
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
	
	//사용자 치료 예약 목록
		public int getTResCount(int mem_num) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int count  = 0;
			
			try {
				conn = DBUtil.getConnection();
				
				sql = "SELECT COUNT(*) FROM treservation JOIN member USING(mem_num) WHERE mem_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, mem_num);
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
	
	//사용자 진료 예약 목록
	public List<ReservationVO> getListRes(int start, int end, int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReservationVO> list = null;
		String sql = null;
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			//sql = "SELECT * FROM reservation r JOIN doc d ON r.doc_num=d.doc_num WHERE r.mem_num = ? ORDER BY r.res_num DESC";
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM reservation r JOIN doc d USING(doc_num) WHERE r.mem_num = ? ORDER BY res_num DESC)a) WHERE rnum >= ? AND rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(++cnt, mem_num);
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<ReservationVO>();
			while(rs.next()) {
				ReservationVO reservation = new ReservationVO();
	 			reservation.setRes_num(rs.getInt("res_num"));
				reservation.setDoc_name(rs.getString("doc_name"));
				reservation.setRes_date(rs.getString("res_date"));
				reservation.setRes_time(rs.getString("res_time"));
				reservation.setRes_content(rs.getString("res_content"));
				
				list.add(reservation);
			}
		}catch(Exception e) {
			throw new Exception	(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//사용자 치료 예약 목록
	public List<TReservationVO> getListTRes(int start, int end, int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<TReservationVO> list = null;
		String sql = null;
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM treservation r JOIN treat t USING(treat_num) WHERE r.mem_num = ? ORDER BY res_num DESC)a) WHERE rnum >= ? AND rnum <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(++cnt, mem_num);
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<TReservationVO>();
			while(rs.next()) {
				TReservationVO reservation = new TReservationVO();
	 			reservation.setRes_num(rs.getInt("res_num"));
				reservation.setTreat_name(rs.getString("treat_name"));
				reservation.setRes_date(rs.getString("res_date"));
				reservation.setRes_time(rs.getString("res_time"));
				reservation.setRes_content(rs.getString("res_content"));
				
				list.add(reservation);
			}
		}catch(Exception e) {
			throw new Exception	(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//관리자 진료 예약 목록
	public int getResCountByAdmin(String keyfield, String keyword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;

		try {
			// 커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();

			if (keyword != null && !"".equals(keyword)) {
				if (keyfield.equals("1"))
					sub_sql += "WHERE mem_name LIKE ?";
				else if (keyfield.equals("2"))
					sub_sql += "WHERE doc_name LIKE ?";
			}

			sql = "SELECT count(*) FROM reservation r JOIN doc d USING(doc_num) LEFT OUTER JOIN member_detail d USING(mem_num) " + sub_sql;
			pstmt = conn.prepareStatement(sql);

			if (keyword != null && !"".equals(keyword)) {
				pstmt.setString(1, "%" + keyword + "%");
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return count;
	}
	
	//관리자 치료 예약 목록
	public int getTResCountByAdmin(String keyfield, String keyword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;

		try {
			// 커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();

			if (keyword != null && !"".equals(keyword)) {
				if (keyfield.equals("1"))
					sub_sql += "WHERE mem_name LIKE ?";
				else if (keyfield.equals("2"))
					sub_sql += "WHERE treat_name LIKE ?";
			}

			sql = "SELECT count(*) FROM treservation r JOIN treat t USING(treat_num) LEFT OUTER JOIN member_detail d USING(mem_num) " + sub_sql;
			pstmt = conn.prepareStatement(sql);

			if (keyword != null && !"".equals(keyword)) {
				pstmt.setString(1, "%" + keyword + "%");
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return count;
	}
	
	// 목록, 검색 글 목록
	public List<ReservationVO> getListResByAdmin(int start, int end, String keyfield, String keyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReservationVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			if(keyword != null && !"".equals(keyword)) {
				if (keyfield.equals("1"))
					sub_sql += "WHERE mem_name LIKE ?";
				else if (keyfield.equals("2"))
					sub_sql += "WHERE doc_name LIKE ?";
			}
			
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM reservation r JOIN doc d USING(doc_num) LEFT OUTER JOIN member_detail d USING(mem_num) " + sub_sql + " ORDER BY res_num DESC)a) WHERE rnum >= ? AND rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			if (keyword != null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%" + keyword + "%");
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<ReservationVO>();
			while (rs.next()) {
				ReservationVO reservation = new ReservationVO();
				reservation.setRes_num(rs.getInt("res_num"));
				reservation.setMem_name(rs.getString("mem_name"));
				reservation.setDoc_name(rs.getString("doc_name"));
				reservation.setRes_date(rs.getString("res_date"));
				reservation.setRes_time(rs.getString("res_time"));
				reservation.setRes_content(rs.getString("res_content"));
				
				list.add(reservation);
			}
			
		}catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	// 관리자 치료 목록, 검색 글 목록
		public List<TReservationVO> getListTResByAdmin(int start, int end, String keyfield, String keyword) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<TReservationVO> list = null;
			String sql = null;
			String sub_sql = "";
			int cnt = 0;
			
			try {
				conn = DBUtil.getConnection();
				
				if(keyword != null && !"".equals(keyword)) {
					if (keyfield.equals("1"))
						sub_sql += "WHERE mem_name LIKE ?";
					else if (keyfield.equals("2"))
						sub_sql += "WHERE doc_name LIKE ?";
				}
				
				sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM treservation r JOIN treat t USING(treat_num) LEFT OUTER JOIN member_detail d USING(mem_num) " + sub_sql + " ORDER BY res_num DESC)a) WHERE rnum >= ? AND rnum <= ?";
				
				pstmt = conn.prepareStatement(sql);
				if (keyword != null && !"".equals(keyword)) {
					pstmt.setString(++cnt, "%" + keyword + "%");
				}
				pstmt.setInt(++cnt, start);
				pstmt.setInt(++cnt, end);
				
				rs = pstmt.executeQuery();
				list = new ArrayList<TReservationVO>();
				while (rs.next()) {
					TReservationVO reservation = new TReservationVO();
					reservation.setRes_num(rs.getInt("res_num"));
					reservation.setMem_name(rs.getString("mem_name"));
					reservation.setTreat_name(rs.getString("treat_name"));
					reservation.setRes_date(rs.getString("res_date"));
					reservation.setRes_time(rs.getString("res_time"));
					reservation.setRes_content(rs.getString("res_content"));
					
					list.add(reservation);
				}
				
			}catch (Exception e) {
				throw new Exception(e);
			} finally {
				DBUtil.executeClose(rs, pstmt, conn);
			}
			
			return list;
		}
	
}
