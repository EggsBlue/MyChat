package com.mychat.setup;

import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.Ioc;
import org.nutz.mvc.NutConfig;
import org.nutz.mvc.Setup;
/**
 * Describe:服务器环绕处理
 * Author:陆小不离
 * Age:Eighteen
 * Time:2017年5月5日 下午2:01:34
 */
public class SystemSetup implements Setup{
	
	/**
	 * 在服务器销毁时将所有用户置为hide,防止非正常退出状态未改变的情况
	 */
	@Override
	public void destroy(NutConfig nc) {
		Ioc ioc = nc.getIoc(); // 拿到Ioc容器
	    Dao dao = ioc.get(Dao.class); // 通过Ioc容器可以拿到你想要的ioc bean
		int i = dao.update("user",Chain.make("status", "hide"),Cnd.where("1","=",1));
		System.out.println(i>0?"所有用户已下线...":"下线失败...");
	}

	@Override
	public void init(NutConfig nc) {
		
	}
}
