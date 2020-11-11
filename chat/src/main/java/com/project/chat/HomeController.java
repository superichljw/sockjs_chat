package com.project.chat;

import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.VO.signupVO;
import com.project.chat.Interface.chat_signup;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Autowired
	@Resource(name = "sqlSession")
	private SqlSession sqlSession;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "main";
	}

	@RequestMapping(value = "/signup_page")
	public String signup_page() {
		return "signup";
	}

	@RequestMapping("/signup")
	public String signup(HttpServletRequest rq) {
		chat_signup cs = sqlSession.getMapper(chat_signup.class);
		signupVO svo = new signupVO();
		svo.setUserId(rq.getParameter("userid"));
		svo.setUserPw(rq.getParameter("pw"));
		svo.setUserName(rq.getParameter("name"));
		String adres = rq.getParameter("postcode") + " " + rq.getParameter("address") + " "
				+ rq.getParameter("detailAdd");
		svo.setUserAdres(adres);
		svo.setUserPhone(rq.getParameter("phone"));
		svo.setUserDate(rq.getParameter("birth"));
		svo.setUserEmail(rq.getParameter("email"));

		cs.chatSignup(svo);
		return "redirect:loginPage";
	}

	@RequestMapping("/id_check")
	public String personal_id_check(HttpServletRequest request, Model model) {
		String userid = request.getParameter("userid");
		chat_signup cs = sqlSession.getMapper(chat_signup.class);
		int result = cs.IdCheck(userid);
		if (result == 0) {
			result = -1;
		}
		model.addAttribute("userid", userid);
		model.addAttribute("result", result);
		return "idcheck";
	}
	
	@RequestMapping("/loginPage")
	public String loginPage() {
		return "login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String personalLogin(HttpServletRequest request, Model model) {
		chat_signup cs = sqlSession.getMapper(chat_signup.class);
		signupVO svo = cs.chatLogin(request.getParameter("id"), request.getParameter("pw"));
		if (svo == null) {
			model.addAttribute("msg", "아이디 또는 비밀번호를 잘못 입력하셨습니다.");
			return "loginAlert";
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", svo);
		}
		return "main";
	}

	// 로그아웃
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "main";
	}
}
