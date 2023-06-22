package kr.community.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.community.vo.NoticeVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class NoticeDAO {
	// 싱글턴 패턴
	private static NoticeDAO instance = new NoticeDAO();
	public static NoticeDAO getInstance() {
		return instance;
	}
	private NoticeDAO() {}
	
	// 글 등록
	public void insertNotice(NoticeVO notice) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO notice (notice_num,notice_title,notice_content) VALUES(notice_seq.nextval,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, notice.getNotice_title());
			pstmt.setString(2, notice.getNotice_content());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			// 자원정리
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	// 총레코드 수(검색 레코드 수)
	public int getNoticeCount(String keyfield,String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = ""; // 검색할 때 사용할 변수
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT COUNT(*) FROM notice";
			pstmt = conn.prepareStatement(sql);
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
	public List<NoticeVO> getListNotice(int start,int end,String keyfield,String keyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<NoticeVO> list = null;
		String sql = null;
		String sub_sql = "";
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM notice "
				+ "ORDER BY notice_num DESC)a) WHERE rnum>=? AND rnum<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			// SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<NoticeVO>();
			while(rs.next()) {
				NoticeVO notice = new NoticeVO();
				notice.setNotice_num(rs.getInt("notice_num"));
				notice.setNotice_title(StringUtil.useNoHtml(rs.getString("notice_title")));
				notice.setNotice_hit(rs.getInt("notice_hit"));
				notice.setNotice_date(rs.getDate("notice_date"));
				
				// 자바빈을 ArrayList에 저장
				list.add(notice);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	// 글 상세
	public NoticeVO getNotice(int notice_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NoticeVO notice = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM notice WHERE notice_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				notice = new NoticeVO();
				notice.setNotice_num(rs.getInt("notice_num"));
				notice.setNotice_title(rs.getString("notice_title"));
				notice.setNotice_content(rs.getString("notice_content"));
				notice.setNotice_hit(rs.getInt("notice_hit"));
				notice.setNotice_date(rs.getDate("notice_date"));
				notice.setNotice_modifydate(rs.getDate("notice_modifydate"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return notice;
	}
	
	// 조회수 증가
	public void updateReadCount(int notice_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE notice SET notice_hit=notice_hit+1 WHERE notice_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice_num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	// 글 수정
	public void updateNotice(NoticeVO notice) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE notice SET notice_title=?,notice_content=?,notice_modifydate=SYSDATE WHERE notice_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, notice.getNotice_title());
			pstmt.setString(2, notice.getNotice_content());
			pstmt.setInt(3, notice.getNotice_num());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	// 글 삭제
	public void deleteNotice(int notice_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "DELETE FROM notice WHERE notice_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, notice_num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}
