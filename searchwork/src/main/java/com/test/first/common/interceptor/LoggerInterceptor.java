package com.test.first.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoggerInterceptor implements HandlerInterceptor{
	//log4j.xml 에서 debug 레벨로 로그를 남기도록 설정하고, 
	//LoggerFactory.getLogger 메소드의 매개변수로 현재 클래스를 전달함

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// DispacterServlet 에서 Controller 로 가기 전에 구동됨
		
		if(logger.isDebugEnabled()) {
			logger.debug("========================START============================");
			logger.debug(request.getRequestURI());
			logger.debug("=========================================================");
		}
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// Controller 에서 리턴되어 뷰리졸버로 가기 전에 구동됨
		
		if(logger.isDebugEnabled()) {
			logger.debug("======================== view ============================");
		}
		
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// 뷰리졸버가 뷰를 찾아서 내보내고 나면 구동됨
		if(logger.isDebugEnabled()) {
			logger.debug("======================== END ============================");
		}
		
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}
}
