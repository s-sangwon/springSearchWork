package com.test.first.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

import com.test.first.member.model.vo.Member;

public class LoginCheckInterceptor implements HandlerInterceptor {
	private Logger logger = LoggerFactory.getLogger(getClass());

	// 컨트롤러로 넘어가기 전에 로그인 상태를 확인하는 용도
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub

		HttpSession session = request.getSession(); // 세션없으면 null이 리턴됨
		Member loginMember = (Member) session.getAttribute("loginMember");

		// 또는 session 안에 저장된 loginMember 라는 이름의
		// 저장 객체가 존재하는지 확인하는 방법도 있음

		if (loginMember != null) {
			logger.info("로그인 상태 : " + request.getRequestURI() + " 요청");
		}

		else {
			logger.info("비로그인 상태 : " + request.getRequestURI() + " 요청");

			// 돌려보냄
			// Referer 이용 : request 객체에 기록되어 있음
			String referer = request.getHeader("Referer");
			logger.info("Referer : " + referer);

			// 브라우저 이름[전송방식] 확인
			String origin = request.getHeader("Origin");
			logger.info("Origin : " + origin);
			// chrome[GET], ie[GET|POST], firefox[POST] => null

			String url = request.getRequestURL().toString();
			logger.info("url : " + url);

			String uri = request.getRequestURI().toString();
			logger.info("url : " + uri);

			// 크롬 브라우저일 때
			if (origin == null) {
				origin = uri.replace(uri, "");
			}

			String location = referer.replace(origin + request.getContextPath(), "");

			request.setAttribute("loc", location);
			request.setAttribute("message", "로그인해야 이용할 수 있는 서비스 입니다.");
			request.getRequestDispatcher("/WEB-INF/views/common/error.jsp").forward(request, response);
			return false;
		}

		// 로그인 상태의 요청이라면 컨트롤러로 넘김
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}

}
