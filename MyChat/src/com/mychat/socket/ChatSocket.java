package com.mychat.socket;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.plugins.mvc.websocket.AbstractWsEndpoint;
import org.nutz.plugins.mvc.websocket.NutWsConfigurator;
import org.nutz.plugins.mvc.websocket.WsHandler;
import org.nutz.plugins.mvc.websocket.handler.SimpleWsHandler;

import com.mychat.dao.UserDao;
import com.mychat.msg.entity.ReceiveMessage;
import com.mychat.msg.entity.SendMessage;
/**
 * Describe:Socket bate 1
 * Author:陆小不离
 * Age:Eighteen
 * Time:2017年5月5日 下午2:06:05
 */
@IocBean
@ServerEndpoint(value = "/chat", configurator=NutWsConfigurator.class)
public class ChatSocket extends AbstractWsEndpoint{
	
	@Inject
	private UserDao userDao;
	
	public static Map<String,Session> onlineUsers = new HashMap<String,Session>();//在线用户列表
	private String username;	//当前会话的用户名
	private int id;	//当前用户id
	
	public ChatSocket(){
		System.out.println("create chatsocket...");
	}
	
	/**
	 * 连接打开时的回调
	 * @param session
	 */
	public void onOpen(Session session, EndpointConfig config) {
		System.out.println("execute method open...");
		super.onOpen(session, config);
		String strs = session.getQueryString();
		System.out.println(strs);
		String username = strs.split("=")[1];
		username = username.substring(0,username.length()-3);
		int id = Integer.valueOf(strs.split("=")[2]);
		try {
			username = URLDecoder.decode(username,"utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		this.username = username;
		this.id = id;
		System.out.println(username+"上线了...");
		onlineUsers.put(username, session);
		System.out.println("当前在线:"+onlineUsers);
	}
	
	/**
	 * 连接关闭时的回调
	 * @param session
	 */
	@OnClose
	public void close(Session session){
		System.out.println("execute method close...");
		try {
			session.close();
		} catch (IOException e) {
			System.out.println("我捕获到了异常...");
			e.printStackTrace();
		}
		onlineUsers.remove(this.username);
		userDao.hide(id);
		System.out.println(username+"下线了...");
		System.out.println("当前在线:"+onlineUsers);
	}
	
	/**
	 * 接受到消息时的回调
	 * @param session 当前sessino
	 * @param msg 消息内容
	 */
	@OnMessage
	public void message(Session session,String msg){
		System.out.println("execute method message...");
		//解析消息内容
		ReceiveMessage message =Json.fromJson(ReceiveMessage.class,msg);
		Map<String, String> to = message.getTo();
		Map<String, String> mine = message.getMine();
		String toName = to.get("name");	
		Session toSession = onlineUsers.get(toName);
		//构建转发消息实体
		SendMessage sendMessage = new SendMessage();
		sendMessage.setUsername(mine.get("username"));
		sendMessage.setAvatar(mine.get("avatar"));
		sendMessage.setId(mine.get("id"));
		sendMessage.setType("friend");
		sendMessage.setContent(mine.get("content"));
//		if(to.get("username").equals(username)){
//			sendMessage.setMine(true);
//		}else{
//			sendMessage.setMine(false);
//		}
		sendMessage.setFromid(mine.get("id"));
		sendMessage.setTimestamp(System.currentTimeMillis());
		String strJson =Json.toJson(sendMessage);
//		String strJson = sendMessage.toJson();
		//发送消息,记得转成json
		try {
			toSession.getBasicRemote().sendText(strJson);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public WsHandler createHandler(Session session, EndpointConfig config) {
		System.out.println("覆盖父类heander...");
		SimpleWsHandler handler = new SimpleWsHandler(roomPrefix);
        handler.setRoomProvider(roomProvider);
        handler.setSession(session);
        return handler;
	}
}
