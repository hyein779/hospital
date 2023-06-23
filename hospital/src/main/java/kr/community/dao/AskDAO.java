package kr.community.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
	
	
	// 글 목록(검색글 목록)
	// 글 상세
	// 조회수 증가
	// 글 수정
	// 글 삭제
	
	// 댓글 등록
	// 댓글 개수
	// 댓글 목록
	// 댓글 상세(댓글 수정, 삭제 시 작성자 회원번호 체크 용도로 사용)
	// 댓글 수정
	// 댓글 삭제
	
	
}
