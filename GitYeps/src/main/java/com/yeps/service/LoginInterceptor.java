package com.yeps.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.yeps.model.MemberDTO;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// Session memberinfo check
		HttpSession session = request.getSession();
		MemberDTO dto = (MemberDTO) session.getAttribute("memberinfo");

		// Login false
		if (null == dto) {
			// login page 로 이동
			response.sendRedirect("member_login");
			return false;
		}
		// Login true
		else {
			return super.preHandle(request, response, handler);
		}
	}
}