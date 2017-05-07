package com.mychat.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.nutz.dao.Chain;
import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.mvc.Mvcs;
//由于nutz提供的ioc不兼容Listencer所以采用nutz提供的Setup
public class TomcatListener implements ServletContextListener{

	private Dao dao;
	
	//tomcat关闭前触发
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		System.out.println("Tomcat destroyed...");
		//dao.update("user",Chain.make("status", "hide"),Cnd.where("1","=",1));
	}
	
	//Servlet启动后触发
	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		//dao = Mvcs.ctx().getDefaultIoc().get(Dao.class);
		System.out.println("Tomcat init...");
	}
	
}
