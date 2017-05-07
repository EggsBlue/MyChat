package com.mychat.controol;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.nutz.dao.Cnd;
import org.nutz.dao.Dao;
import org.nutz.ioc.loader.annotation.Inject;
import org.nutz.ioc.loader.annotation.IocBean;
import org.nutz.json.Json;
import org.nutz.lang.Strings;
import org.nutz.lang.util.NutMap;
import org.nutz.mvc.annotation.At;
import org.nutz.mvc.annotation.Attr;
import org.nutz.mvc.annotation.Ok;
import org.nutz.mvc.annotation.Param;

import com.mychat.dao.ChatMessageDao;
import com.mychat.dao.UserDao;
import com.mychat.entity.InitData;
import com.mychat.entity.JsonMsgModel;
import com.mychat.entity.Message;
import com.mychat.entity.User;
import com.mychat.msg.entity.ChatMessage;
/**
 * Describe: User Controll
 * Author:陆小不离
 * Age:Eighteen
 * Time:2017年4月24日 上午11:34:08
 */
@IocBean
@At("/user")
@Ok("json")
public class UserModule {
	
	@Inject(value="userDao")
	private UserDao userDao;
	@Inject
	private Dao dao;
	@Inject
	private ChatMessageDao chatMessageDao;
	
	/**
	 * 登陆
	 * @param u
	 * @param session
	 * @return
	 */
	@At
	public Object login(@Param("..")User u,HttpSession session){
		NutMap re = new NutMap();
		User user = userDao.getByNamPwd(u);
		if(user == null){
			re.setv("ok", false).setv("msg", "用户名或密码错误!");
			return re;
		}else{
			session.setAttribute("me", user.getId());
			session.setAttribute("username", user.getUsername());
			re.setv("ok", true).setv("msg", "登陆成功!");
			userDao.online(user.getId());
			return re;
		}
	}
	
	/**
	 * 注册
	 * @param user
	 * @param session
	 * @return
	 */
	@At
	public Object registry(@Param("..") User user,HttpSession session){
		NutMap re = new NutMap();
		String msg = checkUser(user,true);
		if(msg != null){
			re.setv("ok", false).setv("msg", msg);
			return re;
		}
		user.setAvatar("/mychat/imgs/user.jpg");
		User u = userDao.save(user);
		if(u==null){
			re.setv("ok", false).setv("msg", "注册失败!");
			return re;
		}else{
			session.setAttribute("me", user.getId());
			session.setAttribute("username", user.getUsername());
			re.setv("ok", true).setv("msg", "注册成功");
			//添加默认分组
			userDao.addGroup(u.getId(), "家人");
			userDao.addGroup(u.getId(), "朋友");
			return re;
		}
	}
	
	/**
	 * 查找用户
	 * @param name
	 * @return
	 */
	@At
	public Object seachUser(@Param("name") String name){
		List<User> users = userDao.getByLikeName(name);
		return Json.toJson(users);
	}
	
	
	
	/**
	 * 初始化数据
	 * @param me
	 * @return
	 */
	@At
	@Ok("raw")
	public String getInitData(@Attr("me") int me){
		String data = userDao.getInitData(me);
		System.out.println(data);
		return data;
	}
	
	
	/**
	 * 获取未读消息数量
	 * @param me
	 * @return
	 */
	@At
	public Object unreadMsgCount(@Attr("me") int me){
		List<Message> msgs = userDao.getMessages(me);
		int count = 0;
		for(Message msg : msgs){
			if(msg.getRead() == 0){//0未读
				count++;
			}
		}
		NutMap nm = new NutMap();
		nm.setv("ok", true).setv("count",count);
		return nm;
	}
	
	/**
	 * 获取我的消息
	 * @param me
	 * @return
	 */
	@At
	public Object getMsg(@Attr("me") int me){
		List<Message> msgs = userDao.getMessages(me);
		JsonMsgModel jmm = new JsonMsgModel();
		jmm.setCode(0);
		jmm.setPages(1);
		jmm.setData(msgs);
		return jmm;
	}
	
	/**
	 * 已读我的消息
	 * @param me
	 */
	@At
	public void markRead(@Attr("me") int me){
		userDao.markRead(me);
	}
	
	/**
	 * 申请添加好友
	 * @param me 我的id
	 * @param uid 对方id
	 * @param from_group  到哪个分组?
	 * @return
	 */
	@At
	public Object applyFriend(@Attr("me") int me,@Param("uid")int uid,@Param("from_group")int from_group ){
		NutMap nm = new NutMap();
		int i = userDao.applyFriend(uid, me, from_group);
		if(1>0)
			nm.setv("ok", 1);
		else
			nm.setv("ok", 0);
		
		return nm;
	}
	
	/**
	 * 同意添加
	 * @param me 我的id
	 * @param uid 对方的id
	 * @param group 我要添加到的分组id
	 * @param from_group 对方要添加到的分组id
	 * @return
	 */
	@At
	public Object addFridend(@Attr("me") int me,@Param("uid") int uid,@Param("group") int group,@Param("from_group") int from_group,@Param("msgid")int msgid){
		NutMap nm = new NutMap();
		
		//查出我的所有好友,判断是否已经添加过
		List<User> list = userDao.getFriends(me);
		if(list!=null && list.size()>0){
			for(User u : list){
				if(u.getId() == uid)
					return nm.setv("code", 1).setv("msg", "不可重复添加!");
			}
		}
		
		int id = userDao.addFriend(me, uid, group);
		int i = userDao.addFriend(uid, me, from_group);
		System.out.println("加好友成功!");
		//更新消息状态
		userDao.updateMsg(msgid, 3);  //更新状态为已同意
		nm.setv("code", 0);
		return nm;
	}
	
	/**
	 * 拒绝添加
	 * @param me
	 * @param msgid
	 * @return
	 */
	@At
	public Object declineApply(@Attr("me") int me,@Param("msgid")int msgid){
		NutMap nm = new NutMap();
		userDao.updateMsg(msgid, 2);
		nm.setv("code", 0);
		return nm;
	}
	
	/**
	 * 上线
	 * @param me
	 */
	@At
	public void online(@Attr("me") int me){
		userDao.online(me);
	}
	
	/**
	 * 下线
	 * @param me
	 */
	@At
	public void hide(@Attr("me") int me){
		userDao.hide(me);
	}
	
	/**
	 * 修改签名
	 * @param me
	 * @param sign
	 */
	@At
	public void updateSign(@Attr("me") int me,@Param("sign") String sign){
		userDao.updateSign(me, sign);
	}
	
	/**
	 * 根据id获取用户信息,可用于查看在线状态
	 * @param id
	 * @return
	 */
	@At
	public Object getUser(@Param("id") int id){
		User user = userDao.findbyid(id);
		return user;
	}
	
	/**
	 * 查询群成员
	 * @param id
	 * @return
	 */
	@At
	public Object getMembers(@Param("id") int fid){
		List<User> members = userDao.getMembers(fid);
		InitData id = new InitData();
		id.setCode(0);
		id.setMsg("");
		
		Map<String,Object> war = new HashMap<String,Object>();
		war.put("list", members);
		id.setData(war);
		return id;
	}
	
	/**
	 * 分页查询聊天记录
	 * @param me
	 * @param pageNo
	 * @param pageSize
	 * @param toid
	 * @param type
	 * @return
	 */
	@At
	@Ok("json")
	public Object getOldMsgs(@Attr("me") int me,@Param("pageNo") int pageNo,@Param("pageSize") int pageSize,@Param("toid") int toid,@Param("type") int type){
		/*
		   username: '纸飞机'
	      ,id: 1
	      ,avatar: 'http://tva3.sinaimg.cn/crop.0.0.512.512.180/8693225ajw8f2rt20ptykj20e80e8weu.jpg'
	      ,timestamp: 1480897882000
	      ,content: 'face[抱抱] face[心] 你好啊小美女'
		 */
		NutMap nm = chatMessageDao.pageMsg(pageNo, pageSize, me, toid, type);
		return nm;
	}
	
	/**
	 * Validate Data
	 * @param user
	 * @param create
	 * @return
	 */
	protected String checkUser(User user, boolean create) {
        if (user == null) {
            return "空对象";
        }
        if (create) {
            if (Strings.isBlank(user.getUsername()) || Strings.isBlank(user.getPwd()))
                return "用户名/密码不能为空";
        } else {
            if (Strings.isBlank(user.getPwd()))
                return "密码不能为空";
        }
        String passwd = user.getPwd().trim();
        if (6 > passwd.length() || passwd.length() > 12) {
            return "密码长度错误";
        }
        user.setPwd(passwd);
        if (create) {
            int count = dao.count(User.class, Cnd.where("username", "=", user.getUsername()));
            if (count != 0) {
                return "用户名已经存在";
            }
        } else {
            if (user.getId() < 1) {
                return "用户Id非法";
            }
        }
        if (user.getUsername() != null)
            user.setUsername(user.getUsername().trim());
        	return null;
	}
}
