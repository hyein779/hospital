package kr.reservation.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kr.reservation.vo.ReservationVO;
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
	
	//예약 정보 insert
	public void insertRes(ReservationVO reservation) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO reservation (res_num,res_date,res_time,res_treat,res_status,res_select,mem_num,doc_num) "
					+ "VALUES (reservation_seq.nextval,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reservation.getRes_date());
			pstmt.setString(2, reservation.getRes_time());
			pstmt.setString(3, reservation.getRes_treat());
			pstmt.setInt(4, reservation.getRes_status());
			pstmt.setInt(5, reservation.getRes_select());
			pstmt.setInt(6, reservation.getMem_num());
			pstmt.setInt(7, reservation.getDoc_num());
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
				reservation.setRes_treat(rs.getString("res_treat"));
				reservation.setRes_status(rs.getInt("res_status"));
				reservation.setRes_select(rs.getInt("res_select"));
				reservation.setMem_num(rs.getInt("mem_num"));
				reservation.setDoc_num(rs.getInt("doc_num"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return reservation;
	}	
	
	

}
