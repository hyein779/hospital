package kr.member.action;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class FindUserPwAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		//전송된 데이터 반환(아이디,이름,전화번호)
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		Random random = new Random();
		String passwd = "";
		//난수 6자리를 받아 임시 비밀번호 생성
		for(int i = 0;i<6; i++) {
			int num = random.nextInt(9)+1;
			passwd += Integer.toString(num);
		}
		
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.checkMember(id);
		boolean check = false;
		
		if(member!=null && !"".equals(id)) {
			check = member.isCheckdUserPw(name, phone);
		}
		if(check) {
			dao.findPw(id, name, phone, passwd);
		}
		request.setAttribute("passwd", passwd);
		request.setAttribute("check", check);
		
		return "/WEB-INF/views/member/findUserPw.jsp";
	}

}
