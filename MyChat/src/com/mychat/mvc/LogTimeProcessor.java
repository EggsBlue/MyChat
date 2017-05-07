package com.mychat.mvc;

import javax.servlet.http.HttpServletRequest;

import org.nutz.lang.Stopwatch;
import org.nutz.log.Log;
import org.nutz.log.Logs;
import org.nutz.mvc.ActionContext;
import org.nutz.mvc.impl.processor.AbstractProcessor;
/**
 * Describe:标准日志记录
 * Author:陆小不离
 * Age:Eighteen
 * Time:2017年4月24日 上午11:52:16
 */
public class LogTimeProcessor extends AbstractProcessor{
	private static final Log log = Logs.get();
	@Override
	public void process(ActionContext ac) throws Throwable {
		Stopwatch sw = Stopwatch.begin();
		try {
			doNext(ac);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			sw.stop();
			if (log.isDebugEnabled()) {
                HttpServletRequest req = ac.getRequest();
                log.debugf("[%4s]URI=%s %sms", req.getMethod(), req.getRequestURI(), sw.getDuration());
            }
		}
	}
}
