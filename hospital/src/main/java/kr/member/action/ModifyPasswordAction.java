package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class ModifyPasswordAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 여부 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		//전송된 데이터 반환
		String id = request.getParameter("id");
		//현재 비밀번호
		String origin_passwd = request.getParameter("origin_passwd");
		//새비밀번호
		String passwd = request.getParameter("passwd");
		
		//현재 로그인 한 아이디
		String user_id = (String)session.getAttribute("user_id");
		
		MemberDAO dao = MemberDAO.getInstance();
		//입력한 아이디를 통해서 회원정보를 반환 받음
		MemberVO member = dao.checkMember(id);
		boolean check = false;
		//사용자가 입력한 아이디가 존재하고 && 로그인한 아이디와 일치하는지 체크
		if(member!=null && id.equals(user_id)) {
			//비밀번호 일치 여부 체크					현재 비밀번호
			check = member.isCheckesPassword(origin_passwd);
		}
		if(check) {//인증성공
			//비밀번호 변경
			dao.updatePassword(passwd, user_num);
		}
		request.setAttribute("check", check);
		//JSP 경로 반환
		return "/WEB-INF/views/member/modifyPassword.jsp";
	}

}
