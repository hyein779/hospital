package kr.community.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.community.dao.ReviewDAO;
import kr.community.vo.FavVO;
import kr.controller.Action;

public class FavGetAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		//전송된 데이터 반환
		int rev_num = Integer.parseInt(request.getParameter("rev_num"));
		Map<String,Object> mapAjax = new HashMap<String,Object>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		ReviewDAO dao = ReviewDAO.getInstance();
		
		if(user_num==null) {//로그인이 되지 않은 경우
			mapAjax.put("status", "noFav");
			mapAjax.put("count",dao.selectFavCount(rev_num));
		}else {//로그인 된 경우
			FavVO Fav = dao.selectFav(new FavVO(rev_num,user_num));
			if(Fav!=null) {
				//로그인한 회원이 해당 글에 좋아요 표시
				mapAjax.put("status", "yesFav");
				mapAjax.put("count",dao.selectFavCount(rev_num));
			}else { 
				//로그인한 회원이 해당 글에 좋아요 표시하지 않음
				mapAjax.put("status", "noFav");
				mapAjax.put("count", dao.selectFavCount(rev_num));
			}
		}
		
		//JSON 데이터 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		//JSP 경로 반환
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}
