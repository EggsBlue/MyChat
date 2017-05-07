package com.mychat.handler;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.websocket.MessageHandler;
import javax.websocket.Session;

import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.lang.ContinueLoop;
import org.nutz.lang.Each;
import org.nutz.lang.ExitLoop;
import org.nutz.lang.LoopException;
import org.nutz.lang.Strings;
import org.nutz.lang.util.NutMap;
import org.nutz.mvc.Mvcs;
import org.nutz.plugins.mvc.websocket.WsHandler;
import org.nutz.plugins.mvc.websocket.handler.AbstractWsHandler;

import com.mychat.dao.ChatMessageDao;
import com.mychat.dao.UserDao;
import com.mychat.entity.User;
import com.mychat.msg.entity.ChatMessage;
import com.mychat.msg.entity.ReceiveMessage;
import com.mychat.msg.entity.SendMessage;
import com.mychat.socket.NutSocket;
/**
 * Describe:深度封装Session,每一个Handler代表一个连接对象
 * Author:陆小不离
 * Age:Eighteen
 * Time:2017年5月5日 下午2:05:18
 */
@IocBean
public class ChatHandler extends AbstractWsHandler implements MessageHandler.Whole<String> {
	@Inject
	private UserDao userDao;
	@Inject("chatMessageDao")
	private ChatMessageDao chatMessageDao;
	private int id;//用户id
	private String username;	//用户姓名存储
	private NutSocket nutSocket;
	
	public ChatHandler() {
	    this("wsroom:",null,null);
	}
	
	public ChatHandler(String prefix,NutSocket socket,UserDao userDao) {
		super(prefix);
		if(socket!=null){
			this.nutSocket = socket;
		}
		if(userDao!=null)
			this.userDao = userDao;
		
		chatMessageDao= Mvcs.ctx().getDefaultIoc().get(ChatMessageDao.class);
	}
	
	@Override
	public void onMessage(String message) {
		try {
			Session currentSession = this.getSession();
            NutMap msg = Json.fromJson(NutMap.class, message);
            String action = msg.getString("action");
            if (Strings.isBlank(action))
                return;
            String room = msg.getString("room");
            switch (action) {
            case "join":
                join(room);
                break;
            case "left":
                left(room);
                break;
            case "send":
            	// 处理发送过来的消息
            	System.out.println("execute method message...");
            	//解析消息内容
            	ReceiveMessage msgData =Json.fromJson(ReceiveMessage.class,message);
            	Map<String, String> to = msgData.getTo();
            	Map<String, String> mine = msgData.getMine();
            	String toName = to.get("name");	
            	
            	String type = msg.getString("type");
            	if("friend".equals(type)){
            		System.out.println("send friend message...");
            		WsHandler handler = nutSocket.getHandler(toName);
            		if(handler!=null){
            			//构建转发消息实体
                		SendMessage sendMessage = new SendMessage();
                		sendMessage.setUsername(mine.get("username"));
                		sendMessage.setAvatar(mine.get("avatar"));
                		sendMessage.setId(mine.get("id"));
                		sendMessage.setType("friend");
                		sendMessage.setContent(mine.get("content"));
//                		if(to.get("username").equals(username)){
//                			sendMessage.setMine(true);
//                		}else{
//                			sendMessage.setMine(false);
//                		}
                		sendMessage.setFromid(mine.get("id"));
                		sendMessage.setTimestamp(System.currentTimeMillis());
                		String strJson =Json.toJson(sendMessage);
                		System.out.println(strJson);
//                		String strJson = sendMessage.toJson();
                		//发送消息,记得转成json
                		try {
//                			Session toSession = socket.getSession(toName);
//                			toSession.getBasicRemote().sendText(strJson);
                			nutSocket.sendJson(toName, sendMessage);
                		} catch (Exception e) {
                			e.printStackTrace();
                		}finally{
                			//存储消息
                    		ChatMessage cm = new ChatMessage();
                    		cm.setAvatar(mine.get("avatar"));
                    		cm.setContent(mine.get("content"));
                    		cm.setFrom(Integer.valueOf(mine.get("id")));
                    		cm.setTimestamp(String.valueOf(System.currentTimeMillis()));
                    		cm.setToid(Integer.valueOf(to.get("id")));
                    		cm.setType(1);
                    		cm.setUnreadpoint(0);	//0.已读,1.未读
                    		cm.setUsername(mine.get("username"));
                    		
                    		chatMessageDao.addChatMsg(cm);
                		}
            		}else{
            			//存储消息
                		ChatMessage cm = new ChatMessage();
                		cm.setAvatar(mine.get("avatar"));
                		cm.setContent(mine.get("content"));
                		cm.setFrom(Integer.valueOf(mine.get("id")));
                		cm.setTimestamp(String.valueOf(System.currentTimeMillis()));
                		cm.setToid(Integer.valueOf(to.get("id")));
                		cm.setType(1);
                		cm.setUnreadpoint(1);//0.已读,1.未读
                		cm.setUsername(mine.get("username"));
                		
                		chatMessageDao.addChatMsg(cm);
            		}
            		
            		
            	}else if("group".equals(type)){
            		System.out.println("send group "+toName+" message...");
            		
            		//构建转发消息实体
            		SendMessage sendMessage = new SendMessage();
            		sendMessage.setUsername(mine.get("username"));
            		sendMessage.setAvatar(mine.get("avatar"));
            		sendMessage.setId(to.get("id"));
            		sendMessage.setType("group");
            		sendMessage.setContent(mine.get("content"));
            		sendMessage.setFromid(null);
//            		if(to.get("username").equals(username)){
//            			sendMessage.setMine(true);
//            		}else{
//            			sendMessage.setMine(false);
//            		}
//            		sendMessage.setFromid(mine.get("id"));
            		sendMessage.setTimestamp(System.currentTimeMillis());
            		String strJson =Json.toJson(sendMessage);
//            		String strJson = sendMessage.toJson();
            		System.out.println(strJson);
            		//发送消息,记得转成json
            		try {
//            			Session toSession = socket.getSession(toName);
//            			toSession.getBasicRemote().sendText(strJson);
//            			nutSocket.sendJson(toName, sendMessage);
            			nutSocket.each(prefix+toName, new Each<Session>(){
            				@Override
            				public void invoke(int index, Session ele, int length)
            						throws ExitLoop, ContinueLoop, LoopException {
            					if(!ele.equals(currentSession)){
            						nutSocket.sendJson2(ele.getId(), sendMessage);
            					}
            				}
            			});
            		} catch (Exception e) {
            			e.printStackTrace();
            		}finally{
            			//存储消息
                		ChatMessage cm = new ChatMessage();
                		cm.setAvatar(mine.get("avatar"));
                		cm.setContent(mine.get("content"));
                		cm.setFrom(Integer.valueOf(mine.get("id")));
                		cm.setTimestamp(String.valueOf(System.currentTimeMillis()));
                		cm.setToid(Integer.valueOf(to.get("id")));
                		cm.setType(2);	//2为群组消息
                		cm.setUnreadpoint(1);	//0.已读,1.未读
                		cm.setUsername(mine.get("username"));
                		String unreadNumbers = "";
            			List<String> list = nutSocket.getOnlines();
            			int groupId = Integer.valueOf(to.get("id"));
            			List<User> users = userDao.getMembers(groupId);
            			for(int i=0; i<users.size(); i++){//过滤在线用户
            				for(String name : list){
            					if(users.get(i).getUsername().equals(name)){//如果在线,则移除列表
            						users.remove(i);
            					}
            				}
            			}
            			for(User u : users){//设置未在线的人
            				unreadNumbers+=u.getUsername()+",";
            			}
            			if(unreadNumbers.length()>0){
            				unreadNumbers = unreadNumbers.substring(0, unreadNumbers.length()-1);
            			}
            			cm.setUnreadnumbers(unreadNumbers);
            			System.out.println("unreadNumbers:"+unreadNumbers);
            			chatMessageDao.addChatMsg(cm);
            		}
            	}
                break;
            case "oldMsg":
            	//查看是否有离线消息
                List<ChatMessage> list = chatMessageDao.getUnRead(id,username);
                if(list!=null && list.size()>0){
                	for(ChatMessage c : list){
                		if(1 == c.getType()){	//单聊
                			SendMessage sendMessage = new SendMessage();
                    		sendMessage.setUsername(c.getUsername());
                    		sendMessage.setAvatar(c.getAvatar());
                    		sendMessage.setId(c.getFrom().toString());
                    		sendMessage.setType("friend");
                    		sendMessage.setContent(c.getContent());
//                    		if(to.get("username").equals(username)){
//                    			sendMessage.setMine(true);
//                    		}else{
//                    			sendMessage.setMine(false);
//                    		}
                    		sendMessage.setFromid(c.getFrom().toString());
                    		sendMessage.setTimestamp(Long.valueOf(c.getTimestamp()));
                    		String strJson =Json.toJson(sendMessage);
                    		System.out.println("好友消息:"+strJson);
//                    		session.getAsyncRemote().sendText(strJson);
                    		try {
        						session.getBasicRemote().sendText(strJson);
        					} catch (IOException e) {
        						// TODO Auto-generated catch block
        						e.printStackTrace();
        					}
                		}else if(2 == c.getType()){	//群聊
                			System.out.println("send group message...");
                    		
                    		//构建转发消息实体
                    		SendMessage sendMessage = new SendMessage();
                    		sendMessage.setUsername(c.getUsername());
                    		sendMessage.setAvatar(c.getAvatar());
                    		sendMessage.setId(c.getToid().toString());
                    		sendMessage.setType("group");
                    		sendMessage.setContent(c.getContent());
                    		sendMessage.setFromid(null);
//                    		if(to.get("username").equals(username)){
//                    			sendMessage.setMine(true);
//                    		}else{
//                    			sendMessage.setMine(false);
//                    		}
//                    		sendMessage.setFromid(mine.get("id"));
                    		sendMessage.setTimestamp(Long.valueOf(c.getTimestamp()));
                    		String strJson =Json.toJson(sendMessage);
//                    		String strJson = sendMessage.toJson();
                    		System.out.println(strJson);
//                    		session.getAsyncRemote().sendText(strJson);
                    		try {
        						session.getBasicRemote().sendText(strJson);
        					} catch (IOException e) {
        						// TODO Auto-generated catch block
        						e.printStackTrace();
        					}
                		}
                	}
//                	session.getAsyncRemote().sendText(arg0);
                }
            	break;
            default:
                break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
	}

	public Session getSession() {
		return session;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public ChatMessageDao getChatMessageDao() {
		return chatMessageDao;
	}

	public void setChatMessageDao(ChatMessageDao chatMessageDao) {
		this.chatMessageDao = chatMessageDao;
	}

	

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public NutSocket getNutSocket() {
		return nutSocket;
	}

	public void setNutSocket(NutSocket nutSocket) {
		this.nutSocket = nutSocket;
	}
	
}
