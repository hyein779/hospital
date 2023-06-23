package kr.volunteerboardDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.util.DBUtil;
import kr.volunteerboard.vo.volunteerboardVO;


public class volunteerboardDAO {
	//싱글턴 패턴
	private static volunteerboardDAO instance = new volunteerboardDAO();
	public static volunteerboardDAO getInstance() {
		return instance;
	}
	private volunteerboardDAO() {} 
	
	//글 등록
	public void insertBoard(volunteerboardVO board)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO volunteerboard (board_num,title,content,reg_date,mem_num) VALUES (volunteerboard_seq.nextval,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getContent());
			pstmt.setString(3, board.getReg_date());
			pstmt.setInt(4, board.getMem_num());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
	}
	
	//총 레코드 수
		public int getBoardCount(String keyfield,String keyword)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			String sub_sql = "";
			int count=0;
			
			try {
				conn = DBUtil.getConnection();
				
				if(keyword != null && !"".equals(keyword)) {
					if(keyfield.equals("1")) sub_sql += "WHERE b.title LIKE ?";
					else if(keyfield.equals("2")) sub_sql += "WHERE m.mem_id LIKE ?";
					else if(keyfield.equals("3")) sub_sql += "WHERE b.content LIKE ?";
				}
				
				//SQL문 작성
				sql = "SELECT COUNT(*) FROM volunteerboard b "
					+ "JOIN member m USING(mem_num) " + sub_sql;
				//PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				if(keyword != null 
						      && !"".equals(keyword)) {
					pstmt.setString(1, "%" + keyword + "%");
				}
				
				//SQL 실행
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
	  
	//글 목록
	public List<volunteerboardVO> getListBoard(int start, int end, String keyfield, String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<volunteerboardVO> list = null;
		String sql =null;
		String sub_sql = "";
		int cnt=0;
		
		try {
			conn = DBUtil.getConnection();
			
			if(keyword!=null&&!"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql+="WHERE b.title Like ?";
				else if(keyfield.equals("2")) sub_sql+="WHERE m.id Like ?";
				else if(keyfield.equals("3")) sub_sql+="WHERE b.content Like ?";
			}
			
			/*sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM volunteerboard v JOIN member m USING(mem_num) "
					+ sub_sql +" ORDER BY v.board_num DESC)a) WHERE rnum>=? AND rnum<=?";
			pstmt = conn.prepareStatement(sql);
			
			if(keyword!=null&& !"".equals(keyword)) {
				pstmt.setString(++cnt, "%"+keyword+"%");
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<volunteerboardVO>();
			while(rs.next()) {
				volunteerboardVO board = new volunteerboardVO();
				board.setBoard_num(rs.getInt("board_num"));
				board.setTitle(StringUtil.useNoHtml(rs.getString("title")));
				board.setHit(rs.getInt("hit"));
				board.setReg_date(rs.getString("reg_date"));
				board.setId(rs.getString("id"));
				
				list.add(board);
			}
					*/
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM volunteerboard "
					+ "ORDER BY board_num DESC)a) WHERE rnum>=? AND rnum<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			// SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<volunteerboardVO>();
			while(rs.next()) {
				volunteerboardVO vol = new volunteerboardVO();
				vol.setBoard_num(rs.getInt("board_num"));
				vol.setTitle(rs.getString("title"));
				vol.setHit(rs.getInt("hit"));
				vol.setReg_date(rs.getString("reg_date"));
				
				// 자바빈을 ArrayList에 저장
				list.add(vol);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	//글 상세
	public volunteerboardVO getBoard(int board_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		volunteerboardVO board = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM volunteerboard b JOIN member m USING(mem_num) LEFT OUTER JOIN member_detail d "
					+ "USING (mem_num) WHERE b.board_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				board = new volunteerboardVO();
				board.setBoard_num(rs.getInt("board_num"));
				board.setTitle(rs.getString("title"));
				board.setContent(rs.getString("content"));
				board.setHit(rs.getInt("hit"));
				board.setReg_date(rs.getString("reg_date"));
				board.setModify_date(rs.getDate("modify_date"));
				board.setMem_num(rs.getInt("mem_num"));
			}
			
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		
		return board;
	}
	
	//조회수 증가
	public void updateReadcount(int board_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE volunteerboard SET hit=hit+1 WHERE board_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//글 수정
	public void updateBoard(volunteerboardVO board)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE volunteerboard SET title=?,content=?,modify_date=SYSDATE WHERE board_num=?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, board.getTitle());
			pstmt.setString(2, board.getContent());
			pstmt.setInt(3, board.getBoard_num());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//글 삭제
	public void deleteBoard(int board_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "DELETE FROM volunteerboard WHERE board_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
}


















