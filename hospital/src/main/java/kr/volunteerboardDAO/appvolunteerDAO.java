package kr.volunteerboardDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;

import kr.util.DBUtil;
import kr.volunteerboard.vo.appvolunteerVO;

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
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO appvolunteer (app_num,board_num,name,address,phone,content,app_quantity,mem_num) VALUES (appvolunteer_seq.nextval,"
					+ "?,?,?,?,?,?,?)";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, app.getBoard_num());
			pstmt.setString(2, app.getName());
			pstmt.setString(3, app.getAddress());
			pstmt.setString(4, app.getPhone());
			pstmt.setString(5, app.getContent());
			pstmt.setInt(6,app.getApp_quantity());
			pstmt.setInt(7, app.getMem_num());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
	}
	
	//전체 지원자 
	
}