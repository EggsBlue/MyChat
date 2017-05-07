package com.mychat.socket;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.websocket.CloseReason;
import javax.websocket.EndpointConfig;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.json.JsonFormat;
import org.nutz.lang.util.NutMap;
import org.nutz.plugins.mvc.websocket.AbstractWsEndpoint;
import org.nutz.plugins.mvc.websocket.NutWsConfigurator;
import org.nutz.plugins.mvc.websocket.WsHandler;

import com.mychat.dao.ChatMessageDao;
import com.mychat.dao.UserDao;
import com.mychat.entity.Flock;
import com.mychat.handler.ChatHandler;
import com.mychat.msg.entity.ChatMessage;
import com.mychat.msg.entity.SendMessage;
/**
 * Describe:核心Socket,用于实现通讯功能
 * Author:陆小不离
 * Age:Eighteen
 * Time:2017年5月5日 下午2:06:20
 */
@IocBean
@ServerEndpoint(value = "/chat2", configurator=NutWsConfigurator.class)
public class NutSocket extends AbstractWsEndpoint {
	
	@Inject
	private UserDao userDao;
	@Inject
	private ChatMessageDao chatMessageDao;
	
	private String username;	//当前会话的用户名
	private int id;	//当前用户id
	private Session session;
	
	/**
	 * 连接打开时的回调
	 * @param session
	 */
	public void onOpen(Session session, EndpointConfig config) {
		changeSessionId(session);
        String wsid = session.getId();
     	String strs = session.getQueryString();//获取请求参数
		System.out.println(strs);
		String username = strs.split("=")[1];
		username = username.substring(0,username.length()-3);//截取用户名
		int id = Integer.valueOf(strs.split("=")[2]);	//截取id
		try {
			username = URLDecoder.decode(username,"utf-8");	//转码
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		this.username = username;
		this.id = id;
		this.session = session;
		//维护当前session
        WsHandler handler = createHandler(session, config);
//        handler.setRoomProvider(roomProvider);
//        handler.setSession(session);
        session.addMessageHandler(handler);
        sessions.put(wsid, session);
        handlers.put(username, handler);
        
//        try {
//			Thread.sleep(2000);
//		} catch (InterruptedException e) {
//			e.printStackTrace();
//		}
        
        
        System.out.println(username+"上线了...");
		System.out.println("当前在线:"+handlers);
		
		//广播上线通知
		Enumeration<String> keys = handlers.keys();
		while(keys.hasMoreElements()){
			String key = keys.nextElement();
			ChatHandler h = (ChatHandler) handlers.get(key);
			boolean flag = userDao.isFriend(this.id, h.getId());
			if(flag){
				try {
					NutMap nm = new NutMap("action", "online").setv("msg", this.username+"上线了...");
					h.getSession().getBasicRemote().sendText(Json.toJson(nm));
//					handler.getSession().getBasicRemote().sendText("{action:'offline',msg:'"+handler.getUsername()+"下线了...'}");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	/**
	 * 连接关闭时回调
	 */
	public void onClose(Session session, CloseReason closeReason) {
		System.out.println(username+" execute onClose...");
		sessions.remove(session.getId());
		String username = null;
		int me = 0;
		//移除当前handler
		Enumeration<String> keys = handlers.keys();
		while(keys.hasMoreElements()){
			String key = keys.nextElement();
			ChatHandler handler = (ChatHandler) handlers.get(key);
			if(session.equals(handler.getSession())){
				username = handler.getUsername();
				me = handler.getId();
				handlers.remove(key);
				userDao.hide(handler.getId());
			}
		}
		Enumeration<String> keys2 = handlers.keys();
		while(keys2.hasMoreElements()){
			String key = keys2.nextElement();
			ChatHandler handler = (ChatHandler) handlers.get(key);
			boolean flag = userDao.isFriend(me, handler.getId());
			if(flag){
				try {
					NutMap nm = new NutMap("action", "offline").setv("msg", username+"下线了...");
					handler.getSession().getBasicRemote().sendText(Json.toJson(nm));
//					handler.getSession().getBasicRemote().sendText("{action:'offline',msg:'"+handler.getUsername()+"下线了...'}");
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
        System.out.println("当前在线:"+handlers);
	}
	
	/**
     * WebSocket会话出错时调用,默认调用onClose.
     */
    public void onError(Session session, java.lang.Throwable throwable) {
    	System.out.println(username+" execute onError...");
        onClose(session, null);
        throwable.printStackTrace();
        System.out.println("当前在线:"+handlers);
    }
	
	/**
	 * 创建createHandler,覆盖父类
	 */
    public WsHandler createHandler(Session session, EndpointConfig config) {
		System.out.println("覆盖父类heander...");
		ChatHandler handler = new ChatHandler(roomPrefix,this,userDao);
        handler.setRoomProvider(roomProvider);
        handler.setSession(session);
        //初始化分组信息
        List<Flock> list = userDao.getFlocks(id);
        if(list!=null && list.size()>0){
        	for(Flock f : list){
        		handler.join(f.getGroupname());
        	}
        }
        handler.setId(this.id);
        handler.setUsername(this.username);
        return handler;
	}
    
    
    /**
     * 根据username获取其WsHandler实例
     * @param wsid session的id
     */
    public WsHandler getHandler(String username) {
        return handlers.get(username);
    }
    
    /**
     * 异步非阻塞发送文本信息到指定的WebSocket Session
     * @param username 
     * @param msg 将转换为Json字符串的对象
     * @return session存活即返回true
     */
    public boolean sendJson(String username, Object msg) {
    	ChatHandler handler = (ChatHandler) getHandler(username);
        if (handler == null)
            return false;
        handler.getSession().getAsyncRemote().sendText(Json.toJson(msg, JsonFormat.full()));
        return true;
    }
    
    /**
     * 异步非阻塞发送文本信息到指定的WebSocket Session
     * @param wsid session的id
     * @param msg 将转换为Json字符串的对象
     * @return session存活即返回true
     */
    public boolean sendJson2(String wsid, Object msg) {
        Session session = getSession(wsid);
        if (session == null)
            return false;
        session.getAsyncRemote().sendText(Json.toJson(msg, JsonFormat.nice()));
        return true;
    }
    
    /**
     * 获取在线列表
     * @return
     */
    public List<String> getOnlines(){
    	List<String> onlines = new ArrayList<String>();
    	Enumeration<String> keys = handlers.keys();;
    	while(keys.hasMoreElements()){
    		onlines.add(keys.nextElement());
    	}
    	
    	return onlines;
    }
    
	public Session getSession() {
		return session;
	}

	public void setSession(Session session) {
		this.session = session;
	}
}
