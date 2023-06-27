package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class AdminDeleteUserAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 로그인 여부 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num==null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.jsp";
		}
		//로그인 된 경우
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		//전송된 데이터 반환(관리자한테서 받은거)
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		//로그인한 아이디(관리자번호가 필요할까?)
		String user_id = (String)session.getAttribute("user_id");
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO db_member = dao.checkMember(id);
		boolean check = false;
		//사용자가 입력한 아이디가 존재하고 로그인한 아이디와 입력한 아이디가 일치하고 
		//입력한 이메일과 저장된 이메일이 일치하는지 여부 체크
		if(db_member!=null&&id.equals(user_id)) {
			//비밀번호 일치여부 체크
			check = db_member.isCheckedPassword(passwd);
			if(check) {//인증성공
				int member_num = Integer.parseInt(request.getParameter("mem_num"));
				//회원탈퇴
				dao.deleteMember(member_num);
			}
		}
			request.setAttribute("check", check);
			// JSP 경로 반환
			return "/WEB-INF/views/member/adminDeleteUser.jsp";

	}

}
