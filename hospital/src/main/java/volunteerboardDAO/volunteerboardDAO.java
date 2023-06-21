package volunteerboardDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.util.DBUtil;
import kr.util.StringUtil;
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
			sql = "INSERT INTO vlounteerboard (board_num,title,content,reg_date,mem_num) VALUES (volunteerboard_seq.nextval,?,?,?,?)";
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
			
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM volunteerboard v JOIN member m USING(mem_num) "
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
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	//글상세
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
	
}


















