package com.mychat.filter;

import javax.servlet.FilterChain;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.nutz.mvc.ActionContext;
import org.nutz.mvc.ActionFilter;
import org.nutz.mvc.View;
/**
 * Describe:用于解决跨域问题的Filter,不过没用到
 * Author:陆小不离
 * Age:Eighteen
 * Time:2017年5月5日 下午2:05:03
 */
public class PassHttpFilter implements ActionFilter  {

	@Override
	public View match(ActionContext actionContext) {
			System.out.println("execute passHttpFilter...");
			HttpServletResponse res = actionContext.getResponse();
			HttpServletRequest request = actionContext.getRequest();
	        res.setContentType("textml;charset=UTF-8");
	        res.setHeader("Access-Control-Allow-Origin", request.getHeader("Origin"));
	        res.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
	        res.setHeader("Access-Control-Max-Age", "0");
	        res.setHeader("Access-Control-Allow-Headers", "Origin, No-Cache, X-Requested-With, If-Modified-Since, Pragma, Last-Modified, Cache-Control, Expires, Content-Type, X-E4M-With,userId,token");
	        res.setHeader("Access-Control-Allow-Credentials", "true");
	        res.setHeader("XDomainRequestAllowed","1");
	        return null;
	}
	
}
