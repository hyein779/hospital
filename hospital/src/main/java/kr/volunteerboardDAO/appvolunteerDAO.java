package kr.volunteerboardDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kr.cart.vo.CartVO;
import kr.util.DBUtil;
import kr.volunteerboard.vo.appvolunteerVO;
import kr.volunteerboard.vo.volunteerboardVO;

public class appvolunteerDAO {
	//싱글턴 패턴
	private static appvolunteerDAO instance = new appvolunteerDAO();
	public static appvolunteerDAO getInstance() {
		return instance;
	}
	private appvolunteerDAO() {}
	
	
	
	//봉사 등록
	public void insertVol(appvolunteerVO app)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		String sql = null;
		ResultSet rs= null;
		int app_num = 0;
		
		try {
			conn = DBUtil.getConnection();
			//app_num구하기
			sql = "SELECT appvolunteer_seq.nextval FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				app_num = rs.getInt(1);
			}
			
			//지원 정보 저장
			sql = "INSERT INTO appvolunteer (app_num,board_num,name,address,phone,content,mem_num) VALUES (?,?,?,?,?,?,?)";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, app_num);
			pstmt2.setInt(2, app.getBoard_num());
			pstmt2.setString(3, app.getName());
			pstmt2.setString(4,app.getAddress());
			pstmt2.setString(5,app.getPhone());
			pstmt2.setString(6, app.getContent());
			pstmt2.setInt(7, app.getMem_num());
			
			pstmt2.executeUpdate();
			
			sql = "UPDATE volunteerboard SET quantity=quantity-? WHERE board_num=?";
			pstmt3 = conn.prepareStatement(sql);
			pstmt3.setInt(1, app.getApp_quantity());
			pstmt3.setInt(2, app.getBoard_num());
			
			pstmt3.executeUpdate();
			
			
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt3, null);
				DBUtil.executeClose(null, pstmt2, null);
				DBUtil.executeClose(rs, pstmt, conn);
			}		
		
		
		
	}
	
	//봉사 상세
	public appvolunteerVO getApp(appvolunteerVO app)
            throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		appvolunteerVO appSaved = null;
		String sql = null;
		
		try {
		conn = DBUtil.getConnection();
		sql = "SELECT * FROM appvolunteer WHERE "
			+ "board_num=? AND mem_num=?";
		pstmt = conn.prepareStatement(sql);
		//?에 데이터 바인딩
		pstmt.setInt(1, app.getBoard_num());
		pstmt.setInt(2, app.getMem_num());
		//SQL문 실행
		rs = pstmt.executeQuery();
		if(rs.next()) {
			appSaved = new appvolunteerVO();
			appSaved.setApp_num(
					rs.getInt("app_num"));
			appSaved.setBoard_num(
					rs.getInt("board_num"));
			appSaved.setName(
				rs.getString("name"));
			appSaved.setAddress(
					rs.getString("address"));
			appSaved.setPhone(
					rs.getString("phone"));
			appSaved.setContent(
					rs.getString("content"));
			appSaved.setApp_quantity(
					rs.getInt("app_quantity"));
			appSaved.setReg_date(
					rs.getString("reg_date"));
		}
		
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}		
		return appSaved;
	}
	
	//전체 지원자 
	
}
