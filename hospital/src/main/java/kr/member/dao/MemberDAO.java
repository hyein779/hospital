package kr.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kr.member.vo.MemberVO;
import kr.util.DBUtil;

public class MemberDAO {
	// 싱글턴 패턴
	private static MemberDAO instance = new MemberDAO();

	public static MemberDAO getInstance() {
		return instance;
	}

	private MemberDAO() {
	}

	// 회원가입
	public void registerMember(MemberVO member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		ResultSet rs = null;
		String sql = null;
		int num = 0;

		try {
			conn = DBUtil.getConnection();
			// 오토커밋 해제
			conn.setAutoCommit(false);
			// 회원번호(mem_num) 구하기
			sql = "SELECT member_seq.nextval FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt(1); // 컬럼인덱스 숫자로 읽어오기(mem_num)
			}
			// member 테이블에 데이터 저장
			sql = "INSERT INTO member (mem_num,mem_id) VALUES (?,?)";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, num);
			pstmt2.setString(2, member.getId());
			pstmt2.executeUpdate();

			// member_detail테이블에 데이터 저장
			sql = "INSERT INTO member_detail(mem_num,mem_name,mem_public,mem_pw,mem_phone,mem_email, "
					+ "mem_zipcode,mem_address1,mem_address2) VALUES (?,?,?,?,?,?,?,?,?)";
			pstmt3 = conn.prepareStatement(sql);
			pstmt3.setInt(1, num);
			pstmt3.setString(2, member.getName());
			pstmt3.setString(3, member.getCode());
			pstmt3.setString(4, member.getPasswd());
			pstmt3.setString(5, member.getPhone());
			pstmt3.setString(6, member.getEmail());
			pstmt3.setString(7, member.getZipcode());
			pstmt3.setString(8, member.getAddress1());
			pstmt3.setString(9, member.getAddress2());
			pstmt3.executeUpdate();
			conn.commit();

		} catch (Exception e) {
			conn.rollback();
			throw new Exception(e);
		} finally {

			DBUtil.executeClose(rs, pstmt3, conn);
			DBUtil.executeClose(rs, pstmt2, conn);
			DBUtil.executeClose(rs, pstmt, conn);
		}
	}

	// ID 중복 체크 및 로그인 처리
	public MemberVO checkMember(String id) throws Exception {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;

		try {
			// 커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM member m LEFT OUTER JOIN member_detail d ON m.mem_num = d.mem_num WHERE m.mem_id=?";
			// PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			// ?에 데이터 바인딩
			pstmt.setString(1, id);
			// SQL문 실행
			rs = pstmt.executeQuery();
			if (rs.next()) { // 회원관리에 필요한 정보를 담아둠
				member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setId(rs.getString("mem_id"));
				member.setAuth(rs.getInt("mem_auth"));
				member.setPasswd(rs.getString("mem_pw"));
				member.setEmail(rs.getString("mem_email"));
				member.setPhoto(rs.getString("mem_photo"));

			}

		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			// 자원정리
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}

	// 회원 상세 정보
	public MemberVO getMember(int mem_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberVO member = null;
		String sql = null;

		try {
			conn = DBUtil.getConnection(); 
			sql = "SELECT * FROM member m JOIN member_detail d ON m.mem_num=d.mem_num WHERE m.mem_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setId(rs.getString("mem_id"));
				member.setAuth(rs.getInt("mem_auth"));
				member.setName(rs.getString("mem_name"));
				member.setCode(rs.getString("mem_public"));
				member.setPhone(rs.getString("mem_phone"));
				member.setEmail(rs.getString("mem_email"));
				member.setZipcode(rs.getString("mem_zipcode"));
				member.setAddress1(rs.getString("mem_address1"));
				member.setAddress2(rs.getString("mem_address2"));
				member.setPhoto(rs.getString("mem_photo"));
				member.setDate(rs.getDate("mem_date"));
				member.setModify_date(rs.getDate("mem_modifyDate"));
				member.setVisited(rs.getDate("mem_visited"));
			}
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}

	// 회원 정보 수정
	public void updateMember(MemberVO member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			// 커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			// SQL문 작성
			sql = "UPDATE member_detail SET mem_name=?,mem_phone=?,mem_email=?,mem_zipcode=?,"
					+ "mem_address1=?,mem_address2=?,mem_modifydate=SYSDATE WHERE mem_num=?";
			// PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			// ?에 데이터 바인딩
			pstmt.setString(1, member.getName());
			pstmt.setString(2, member.getPhone());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getZipcode());
			pstmt.setString(5, member.getAddress1());
			pstmt.setString(6, member.getAddress2());
			pstmt.setInt(7, member.getMem_num());
			// SQL문 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			// 자원정리
			DBUtil.executeClose(null, pstmt, conn);
		}
	}

	// 비밀 번호 수정
	public void updatePassword(String passwd, int mem_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			// 커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			// SQL문 작성
			sql = "UPDATE member_detail SET mem_pw=? WHERE mem_num=?";
			// PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			// ?에 데이터 바인딩
			pstmt.setString(1, passwd); // 새비밀번호
			pstmt.setInt(2, mem_num); // 회원번호
			// SQL문 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			// 자원정리
			DBUtil.executeClose(null, pstmt, conn);
		}
	}

	// 회원 탈퇴(회원 정보 삭제)
	public void deleteMember(int mem_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		String sql = null;
		try {
			// 커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			// auto커밋 해제
			conn.setAutoCommit(false);

			sql = "UPDATE member SET mem_auth=0 WHERE mem_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			pstmt.executeUpdate();

			// zmember_detail의 레코드 삭제
			sql = "DELETE FROM member_detail WHERE mem_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, mem_num);
			pstmt2.executeUpdate();

			// 모든 SQL문의 실행이 성공하면 commit
			conn.commit();

		} catch (Exception e) {
			// SQL문이 하나라도 실패하면 롤백
			conn.rollback();

			throw new Exception(e);
		} finally {
			// 자원정리
			DBUtil.executeClose(null, pstmt2, conn);
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}
