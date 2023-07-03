package kr.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.member.vo.MemberVO;
import kr.order.vo.OrderVO;
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
				member.setName(rs.getString("mem_name"));
				member.setPhone(rs.getString("mem_phone"));
				member.setPasswd(rs.getString("mem_pw"));
				member.setEmail(rs.getString("mem_email"));
			}

		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			// 자원정리
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return member;
	}

	// 아이디 찾기
	public String findId(String mem_name, String mem_phone) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String id = null;

		try {
			conn = DBUtil.getConnection();
			sql = "SELECT m.mem_id FROM member m LEFT OUTER JOIN member_detail d ON "
					+ "m.mem_num = d.mem_num WHERE d.mem_name=? AND d.mem_phone=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mem_name);
			pstmt.setString(2, mem_phone);

			rs = pstmt.executeQuery();
			if (rs.next()) { // 회원관리에 필요한 정보를 담아둠
				id = rs.getString(1);
			}
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);

		}
		return id;
	}

	// 비밀번호 재발급
	public void findPw(String mem_id, String mem_name, String mem_phone,String mem_pw) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE (SELECT d.mem_pw FROM member_detail d, member m WHERE m.mem_num = d.mem_num AND "
					+ "m.mem_id=? AND d.mem_name=? AND d.mem_phone=?) SET mem_pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			pstmt.setString(2, mem_name);
			pstmt.setString(3, mem_phone);
			pstmt.setString(4, mem_pw);

			pstmt.executeUpdate();
			
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
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
			PreparedStatement pstmt3 = null;
			PreparedStatement pstmt4 = null;
			PreparedStatement pstmt5 = null;
			PreparedStatement pstmt6 = null;
			PreparedStatement pstmt7 = null;
			PreparedStatement pstmt8 = null;
			PreparedStatement pstmt9 = null;
			PreparedStatement pstmt10 = null;
			PreparedStatement pstmt11 = null;
			PreparedStatement pstmt12 = null;

			String sql = null;

			try {
				// 커넥션풀로부터 커넥션을 할당
				conn = DBUtil.getConnection();
				// auto커밋 해제
				conn.setAutoCommit(false);

				// 등급을 탈퇴회원으로 변경
				sql = "UPDATE member SET mem_auth=0 WHERE mem_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, mem_num);
				pstmt.executeUpdate();

				// member_detail의 레코드 삭제
				sql = "DELETE FROM member_detail WHERE mem_num=?";
				pstmt2 = conn.prepareStatement(sql);
				pstmt2.setInt(1, mem_num);
				pstmt2.executeUpdate();

				// fav레코드 삭제
				sql = "DELETE FROM fav WHERE mem_num=?";
				pstmt3 = conn.prepareStatement(sql);
				pstmt3.setInt(1, mem_num);
				pstmt3.executeUpdate();

				// review의 레코드 삭제
				sql = "DELETE FROM review WHERE mem_num=?";
				pstmt4 = conn.prepareStatement(sql);
				pstmt4.setInt(1, mem_num);
				pstmt4.executeUpdate();

				// reply의 레코드 삭제
				sql = "DELETE FROM reply where ask_num IN(select ask_num FROM ask WHERE mem_num=?)";
				pstmt5 = conn.prepareStatement(sql);
				pstmt5.setInt(1, mem_num);
				pstmt5.executeUpdate();

				// ask의 레코드 삭제
				sql = "DELETE FROM ask WHERE mem_num=?";
				pstmt6 = conn.prepareStatement(sql);
				pstmt6.setInt(1, mem_num);
				pstmt6.executeUpdate();
				// reservation의 레코드 삭제
				sql = "DELETE FROM reservation WHERE mem_num=?";
				pstmt7 = conn.prepareStatement(sql);
				pstmt7.setInt(1, mem_num);
				pstmt7.executeUpdate();

				// treservation의 레코드 삭제
				sql = "DELETE FROM treservation WHERE mem_num=?";
				pstmt8 = conn.prepareStatement(sql);
				pstmt8.setInt(1, mem_num);
				pstmt8.executeUpdate();

				// appvolunteer의 레코드 삭제
				sql = "DELETE FROM appvolunteer WHERE mem_num=?";
				pstmt9 = conn.prepareStatement(sql);
				pstmt9.setInt(1, mem_num);
				pstmt9.executeUpdate();

				// cart의 레코드 삭제
				sql = "DELETE FROM cart WHERE mem_num=?";
				pstmt10 = conn.prepareStatement(sql);
				pstmt10.setInt(1, mem_num);
				pstmt10.executeUpdate();

				// zorder_detail의 레코드 삭제
				sql = "DELETE FROM zorder_detail where order_num IN(select order_num FROM zorder WHERE mem_num=?)";
				pstmt11 = conn.prepareStatement(sql);
				pstmt11.setInt(1, mem_num);
				pstmt11.executeUpdate();

				// zorder의 레코드 삭제
				sql = "DELETE FROM zorder WHERE mem_num=?";
				pstmt12 = conn.prepareStatement(sql);
				pstmt12.setInt(1, mem_num);
				pstmt12.executeUpdate();

				// 모든 SQL문의 실행이 성공하면 commit
				conn.commit();

			} catch (Exception e) {
				// SQL문이 하나라도 실패하면 롤백
				conn.rollback();

				throw new Exception(e);
			} finally {
				// 자원정리
				DBUtil.executeClose(null, pstmt12, null);
				DBUtil.executeClose(null, pstmt11, null);
				DBUtil.executeClose(null, pstmt10, null);
				DBUtil.executeClose(null, pstmt9, null);
				DBUtil.executeClose(null, pstmt8, null);
				DBUtil.executeClose(null, pstmt7, null);
				DBUtil.executeClose(null, pstmt6, null);
				DBUtil.executeClose(null, pstmt5, null);
				DBUtil.executeClose(null, pstmt4, null);
				DBUtil.executeClose(null, pstmt3, null);
				DBUtil.executeClose(null, pstmt2, null);
				DBUtil.executeClose(null, pstmt, conn);
			}
		}

	// 관리자
	// 전체 글 개수, 검색 글 개수
	public int getMemberCountByAdmin(String keyfield, String keyword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;

		try {
			// 커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();

			if (keyword != null && !"".equals(keyword)) {
				if (keyfield.equals("1"))
					sub_sql += "WHERE mem_id LIKE ?";
				else if (keyfield.equals("2"))
					sub_sql += "WHERE mem_name LIKE ?";
				else if (keyfield.equals("3"))
					sub_sql += "WHERE mem_email LIKE ?";
			}

			sql = "SELECT count(*) FROM member m LEFT OUTER JOIN member_detail d USING(mem_num) " + sub_sql;
			pstmt = conn.prepareStatement(sql);

			if (keyword != null && !"".equals(keyword)) {
				pstmt.setString(1, "%" + keyword + "%");
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return count;
	}

	// 목록, 검색 글 목록
	public List<MemberVO> getListMemberByAdmin(int start, int end, String keyfield, String keyword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MemberVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;

		try {
			// 커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();

			if (keyword != null && !"".equals(keyword)) {
				if (keyfield.equals("1"))
					sub_sql += "WHERE mem_id LIKE ?";
				else if (keyfield.equals("2"))
					sub_sql += "WHERE mem_name LIKE ?";
			}

			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "(SELECT * FROM member m LEFT OUTER JOIN member_detail d USING(mem_num) " + sub_sql
					+ "ORDER BY mem_date DESC NULLS LAST)a) WHERE rnum >= ? AND rnum <= ?";

			pstmt = conn.prepareStatement(sql);
			if (keyword != null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%" + keyword + "%");
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);

			rs = pstmt.executeQuery();
			list = new ArrayList<MemberVO>();
			while (rs.next()) {
				MemberVO member = new MemberVO();
				member.setMem_num(rs.getInt("mem_num"));
				member.setId(rs.getString("mem_id"));
				member.setAuth(rs.getInt("mem_auth"));
				member.setPasswd(rs.getString("mem_pw"));
				member.setName(rs.getString("mem_name"));
				member.setPhone(rs.getString("mem_phone"));
				member.setEmail(rs.getString("mem_email"));
				member.setZipcode(rs.getString("mem_zipcode"));
				member.setAddress1(rs.getString("mem_address1"));
				member.setAddress2(rs.getString("mem_address2"));
				member.setPhoto(rs.getString("mem_photo"));
				member.setDate(rs.getDate("mem_date"));
				member.setModify_date(rs.getDate("mem_modifydate"));

				list.add(member);
			}

		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}

		return list;
	}

	// 회원정보수정
	public void updateMemberByAdmin(int auth, int mem_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;

		try {
			// 커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			// SQL문 작성
			sql = "UPDATE member SET mem_auth=? WHERE mem_num=?";
			// PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			// ?에 데이터 바인딩
			pstmt.setInt(1, auth);
			pstmt.setInt(2, mem_num);
			// SQL문 실행
			pstmt.executeUpdate();

		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}

	// 사용자 - 전체 주문 개수/검색 주문 개수
	public int getOrderCountByMem_num(String keyfield, String keyword, int mem_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;

		try {
			conn = DBUtil.getConnection();
			if (keyword != null && !"".equals(keyword)) {
				if (keyfield.equals("1"))
					sub_sql += "AND order_num=?";
				else if (keyfield.equals("2"))
					sub_sql += "AND order_name LIKE ?";
			}
			sql = "SELECT COUNT(*) FROM zorder WHERE mem_num=?" + sub_sql;
			pstmt = conn.prepareStatement(sql);
			// ?에 데이터 바인딩
			pstmt.setInt(1, mem_num);
			if (keyword != null && !"".equals(keyword)) {
				if (keyfield.equals("1")) {
					pstmt.setString(2, keyword);
				} else if (keyfield.equals("2")) {
					pstmt.setString(2, "%" + keyword + "%");
				}
			}
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return count;
	}

	// 사용자 - 전체 주문 목록/검색 주문 목록
	public List<OrderVO> getListOrderByMem_num(int start, int end, String keyfield, String keyword, int mem_num)
			throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<OrderVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;

		try {
			conn = DBUtil.getConnection();

			if (keyword != null && !"".equals(keyword)) {
				if (keyfield.equals("1"))
					sub_sql += "AND order_num=?";
				else if (keyfield.equals("2"))
					sub_sql += "AND order_name LIKE ?";
			}
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM zorder WHERE mem_num=? " + sub_sql
					+ " ORDER BY order_num DESC)a)WHERE rnum>=? AND rnum<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(++cnt, mem_num);
			if (keyword != null && !"".equals(keyword)) {
				if (keyfield.equals("1")) {
					pstmt.setString(++cnt, keyword);
				} else if (keyfield.equals("2")) {
					pstmt.setString(++cnt, "%" + keyword + "%");
				}
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);

			rs = pstmt.executeQuery();
			list = new ArrayList<OrderVO>();
			while (rs.next()) {
				OrderVO order = new OrderVO();
				order.setOrder_num(rs.getInt("order_num"));
				order.setOrder_name(rs.getString("order_name"));
				order.setOrder_total(rs.getInt("order_total"));
				order.setPayment(rs.getInt("payment"));
				order.setStatus(rs.getInt("status"));
				order.setReceive_name(rs.getString("receive_name"));
				order.setReceive_post(rs.getString("receive_post"));
				order.setReceive_address1(rs.getString("receive_address1"));
				order.setReceive_address2(rs.getString("receive_address2"));
				order.setReceive_phone(rs.getString("receive_phone"));
				order.setNotice(rs.getString("notice"));
				order.setReg_date(rs.getDate("reg_date"));
				order.setMem_num(rs.getInt("mem_num"));

				list.add(order);
			}
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
}
