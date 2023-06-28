package kr.community.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.community.vo.FavVO;
import kr.community.vo.ReviewVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class ReviewDAO {
	// 싱글턴 패턴
	private static ReviewDAO instance = new ReviewDAO();
	public static ReviewDAO getInstance() {
		return instance;
	}
	private ReviewDAO() {}
	
	// 글등록
	public void insertReview(ReviewVO review) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO review (rev_num,rev_type,rev_title,rev_content,mem_num) VALUES(review_seq.nextval,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, review.getRev_type());
			pstmt.setString(2, review.getRev_title());
			pstmt.setString(3, review.getRev_content());
			pstmt.setInt(4, review.getMem_num());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	// 총 레코드 수
	public int getReviewCount() throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT COUNT(*) FROM review";
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
	
	// 글 목록
	public List<ReviewVO> getReviewList(int start,int end,int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ReviewVO> list = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM ("
					+ "SELECT * FROM review r JOIN member_detail m USING(mem_num) "
					+ " LEFT OUTER JOIN (SELECT 'clicked' clicked,rev_num FROM fav WHERE mem_num=?) USING(rev_num)"
					+ " LEFT OUTER JOIN (SELECT rev_num, COUNT(*) cnt FROM fav GROUP BY rev_num) USING(rev_num)"
					+ "ORDER BY rev_num DESC)a) WHERE rnum>=? AND rnum<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<ReviewVO>();
			while(rs.next()) {
				ReviewVO review = new ReviewVO();
				review.setRev_num(rs.getInt("rev_num"));
				review.setRev_title(StringUtil.useNoHtml(rs.getString("rev_title")));
				review.setRev_content(rs.getString("rev_content"));
				review.setRev_type(rs.getInt("rev_type"));
				review.setRev_date(rs.getDate("rev_date"));
				review.setMem_num(rs.getInt("mem_num"));
				review.setMem_name(rs.getString("mem_name"));
				review.setCnt(rs.getInt("cnt"));
				review.setClicked(rs.getString("clicked"));
				
				list.add(review);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	// 글 선택
	public ReviewVO getReview(int rev_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ReviewVO review = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM review WHERE rev_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rev_num);
			rs  = pstmt.executeQuery();
			if(rs.next()) {
				review = new ReviewVO();
				review.setRev_num(rs.getInt("rev_num"));
				review.setRev_title(rs.getString("rev_title"));
				review.setRev_content(rs.getString("rev_content"));
				review.setRev_type(rs.getInt("rev_type"));
				review.setRev_date(rs.getDate("rev_date"));
				review.setRev_modifydate(rs.getDate("rev_modifydate"));
				review.setMem_num(rs.getInt("mem_num"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return review;
	}		
	
	// 글 수정
	public void updateReview(ReviewVO review) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "UPDATE review SET rev_type=?,rev_title=?,rev_content=?,rev_modifydate=SYSDATE WHERE rev_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, review.getRev_type());
			pstmt.setString(2, review.getRev_title());
			pstmt.setString(3, review.getRev_content());
			pstmt.setInt(4, review.getRev_num());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	// 글 삭제
	public void deleteReview(int rev_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			// 오토커밋 해제
			conn.setAutoCommit(false);
			
			// 좋아요 삭제
			sql= "DELETE FROM fav WHERE rev_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rev_num);
			pstmt.executeUpdate();
			
			// 부모글 삭제
			sql = "DELETE FROM review WHERE rev_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, rev_num);
			pstmt2.executeUpdate();
			
			// 예외 발생없이 정상적으로 SQL문 실행
			conn.commit();
		}catch(Exception e) {
			// 하나라도 SQL문이 실패하면
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	// 좋아요 등록
	public void insertFav(FavVO favVO) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "INSERT INTO fav (fav_num,rev_num,mem_num) VALUES (fav_seq.nextval,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, favVO.getRev_num());
			pstmt.setInt(2, favVO.getMem_num());
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	// 좋아요 개수
	public int selectFavCount(int rev_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			 conn = DBUtil.getConnection();
			 sql = "SELECT COUNT(*) FROM fav WHERE rev_num=?";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, rev_num);
		     rs = pstmt.executeQuery();
		     if(rs.next()) {
		        count = rs.getInt(1);
		     }
		  }catch(Exception e) {
		     throw new Exception(e);
		  }
		  finally {
		     DBUtil.executeClose(rs, pstmt, conn);
		  }
		return count;
	}
	
	// 회원번호와 게시물 번호를 이용한 좋아요 정보 (회원이 게시물을 호출할 때 좋아요 선택 여부 표시)
	public FavVO selectFav(FavVO favVO)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		FavVO fav = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM fav WHERE rev_num=? AND mem_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, favVO.getRev_num());
			pstmt.setInt(2, favVO.getMem_num());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				fav = new FavVO();
				fav.setFav_num(rs.getInt("fav_num"));
				fav.setRev_num(rs.getInt("rev_num"));
				fav.setMem_num(rs.getInt("mem_num"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}		
		return fav;
	}
	
	// 좋아요 삭제
	public void deleteFav(int fav_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			sql = "DELETE FROM fav WHERE fav_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fav_num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
}
