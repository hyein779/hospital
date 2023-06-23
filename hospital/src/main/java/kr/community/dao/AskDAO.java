package kr.community.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.community.vo.AskVO;
import kr.community.vo.NoticeVO;
import kr.util.DBUtil;

public class AskDAO {
	// 싱글턴 패턴
	private static AskDAO instance = new AskDAO();
	public static AskDAO getInstance() {
		return instance;
	}
	private AskDAO() {}
	
	// 글 등록
	public void insertAsk(AskVO ask) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO ask (ask_num,ask_title,ask_content,mem_num) VALUES(notice_seq.nextval,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, ask.getAsk_title());
			pstmt.setString(2, ask.getAsk_content());
			pstmt.setInt(3, ask.getMem_num());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			// 자원정리
			DBUtil.executeClose(null, pstmt, conn);
		}
	}	
	
	// 총레코드 수(검색 레코드 수)
	public int getAskCount(String keyfield,String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = ""; // 검색할 때 사용할 변수
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE a.ask_title LIKE ?";
				else if(keyfield.equals("2")) sub_sql += "WHERE m.mem_id LIKE ?";
				else if(keyfield.equals("3")) sub_sql += "WHERE a.ask_content LIKE ?";
			}
			
			sql = "SELECT COUNT(*) FROM ask a JOIN member m USING(mem_num)" + sub_sql;
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(1, "%" + keyword + "%");
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
	
	// 글 목록(검색글 목록)
	public List<AskVO> getListBoard(int start, int end, String keyfield, String keyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AskVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			if(keyword != null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE a.ask_title LIKE ?";
				else if(keyfield.equals("2")) sub_sql += "WHERE m.mem_id LIKE ?";
				else if(keyfield.equals("3")) sub_sql += "WHERE a.ask_content LIKE ?";
			}
			
			sql = "SELECT * FROM (SELECT b.*, rownum rnum FROM (SELECT * FROM ask a JOIN member m "
				+ "USING(mem_num) " + sub_sql + "ORDER BY a.ask_num DESC)b) WHERE rnum>=? AND rnum<=?";
			
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%" + keyword + "%");
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<AskVO>();
			while(rs.next()) {
				AskVO ask = new AskVO();
				ask.setAsk_num(rs.getInt("ask_num"));
				ask.setAsk_title(rs.getString("ask_title"));
				ask.setAsk_hit(rs.getInt("ask_hit"));
				ask.setAsk_date(rs.getDate("ask_date"));
				ask.setId(rs.getString("mem_id"));
				
				// 자바빈을 ArrayList에 저장
				list.add(ask);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	// 글 상세
	public AskVO getAsk(int ask_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		AskVO ask = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM ask a JOIN member m USING(mem_num) "
				+ "JOIN member_detail d USING(mem_num) WHERE a.ask_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ask_num);
			rs  = pstmt.executeQuery();
			
			if(rs.next()) {
				ask = new AskVO();
				ask.setAsk_num(rs.getInt("ask_num"));
				ask.setAsk_title(rs.getString("ask_title"));
				ask.setAsk_content(rs.getString("ask_content"));
				ask.setAsk_hit(rs.getInt("ask_hit"));
				ask.setAsk_date(rs.getDate("ask_date"));
				ask.setAsk_modifydate(rs.getDate("ask_modifydate"));
				ask.setMem_num(rs.getInt("mem_num"));
				ask.setId(rs.getString("mem_id"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return ask;
	}
	
	// 조회수 증가
	public void updateReadcount(int ask_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE ask SET ask_hit=ask_hit+1 WHERE ask_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ask_num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	// 글 수정
	public void updateAsk(AskVO ask) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE ask SET ask_title=?,ask_content=?,ask_modifydate=SYSDATE WHERE ask_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ask.getAsk_title());
			pstmt.setString(2, ask.getAsk_content());
			pstmt.setInt(3, ask.getAsk_num());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	// 글 삭제
	public void deleteAsk(int ask_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			// 오토커밋 해제
			conn.setAutoCommit(false);
			
			// 댓글 삭제
			
			// 부모글 삭제
			sql = "DELETE FROM ask WHERE ask_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, ask_num);
			pstmt2.executeUpdate();
			
			// 예외 발생없이 정상적으로 SQL문 실행
			conn.commit();
		}catch(Exception e) {
			// 하나라도 SQL문이 실패하면
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	// 댓글 등록
	// 댓글 개수
	// 댓글 목록
	// 댓글 상세(댓글 수정, 삭제 시 작성자 회원번호 체크 용도로 사용)
	// 댓글 수정
	// 댓글 삭제
	
	
}
