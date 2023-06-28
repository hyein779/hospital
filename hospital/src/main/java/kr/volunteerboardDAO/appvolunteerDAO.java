package kr.volunteerboardDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		String sql = null;
		ResultSet rs= null;
		int app_num = 0;
		
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
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
			
			//
			sql = "UPDATE volunteerboard SET quantity=quantity-? WHERE board_num=?";
			pstmt3 = conn.prepareStatement(sql);
			pstmt3.setInt(1, app.getApp_quantity());
			pstmt3.setInt(2, app.getBoard_num());
			
			pstmt3.executeUpdate();
			
			conn.commit();
			
			
			}catch(Exception e) {
				conn.rollback();
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt3, null);
				DBUtil.executeClose(null, pstmt2, null);
				DBUtil.executeClose(rs, pstmt, conn);
			}		
		
		
		
	}
	
	//지원자 전원 보기
	public List<appvolunteerVO> Apptotal()throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<appvolunteerVO> list = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT app_num FROM appvolunteer";
			pstmt = conn.prepareStatement(sql);
			
			//SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<appvolunteerVO>();
			while(rs.next()) {
				appvolunteerVO app = new appvolunteerVO();
				app.setApp_num(rs.getInt("app_num"));
				
				list.add(app);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}		
		
		return list;
	}
	
	//봉사 상세
	/*public appvolunteerVO getApp(int app_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		appvolunteerVO appSaved = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM appvolunteer WHERE WHERE app_num";
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
	}*/
	
	//봉사 지원 목록
	public List<appvolunteerVO> getAppList(int start, int end, String keyfield, String keyword, int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<appvolunteerVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) {
				sub_sql += "AND app_num=?";
			}
			
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM appvolunteer WHERE mem_num=? "
					+ sub_sql + " ORDER BY app_num DESC)a) WHERE rnum>=? AND rnum<=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(++cnt, mem_num);
			if(keyword!=null && !"".equals(keyword)) {
					pstmt.setString(++cnt,keyword);
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<appvolunteerVO>();
			while(rs.next()) {
				appvolunteerVO app = new appvolunteerVO();
				app.setApp_num(rs.getInt("app_num"));
				app.setBoard_num(rs.getInt("board_num"));
				app.setName(rs.getString("name"));
				app.setAddress(rs.getString("address"));
				app.setPhone(rs.getString("phone"));
				app.setContent(rs.getString("content"));
				app.setMem_num(rs.getInt("mem_num"));
				
				list.add(app);
			}
			
		
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	//사용자 - 전체 자원봉사 개수
	public int getAppCount(String keyfield, String keyword, int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "AND app_num=?";
			}
			
			sql = "SELECT COUNT(*) FROM appvolunteer WHERE mem_num=?" + sub_sql;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1"))
					pstmt.setString(2,keyword);
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
	
	//지원 취소
	public void deleteApp(int app_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		int plus = 1;
			
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			//sql = "UPDATE volunteerboard v SET quantity=quantity+? WHERE v.board_num = (SELECT board_num FROM volunteerboard LEFT OUTER JOIN appvolunteer a ON a.app_num=?)";
			sql = "UPDATE volunteerboard v SET v.quantity=v.quantity+? WHERE v.board_num = (SELECT board_num FROM appvolunteer WHERE app_num=?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, plus);
			pstmt.setInt(2, app_num);
			pstmt.executeUpdate();
			
			sql = "DELETE FROM appvolunteer WHERE app_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, app_num);
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
	
	//전체 지원자 
	
}
