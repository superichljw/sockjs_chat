package com.project.chat.Interface;

import com.project.VO.signupVO;

public interface chat_signup {
	public void chatSignup(signupVO svo);
	public signupVO chatLogin(String userId, String userPw);
	public int IdCheck(String userid);
}
