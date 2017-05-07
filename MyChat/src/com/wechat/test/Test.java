package com.wechat.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.nutz.json.Json;

import com.mychat.entity.Group;
import com.mychat.entity.InitData;
import com.mychat.entity.User;

public class Test {
	
	@org.junit.Test
	public void test(){
		InitData data=  new InitData();
		data.setCode(0);
		data.setMsg("success!");
		
		Map<String,Object> wrap = new HashMap<String,Object>();
		
		//我的信息
		Map<String,String> mine = new HashMap<String,String>();
		mine.put("username", "纸飞机");
		mine.put("id", "100000");
		mine.put("status", "online");
		mine.put("sign", "在深邃的编码世界，做一枚轻盈的纸飞机");
		mine.put("avatar", "a.jpg");
		
		wrap.put("mine", mine);
		
		//我的好友
		List<Group> groups = new ArrayList<Group>();
		Group g = new Group();
		g.setId(1);
		g.setGroupname("家人");
		List<User> us = new ArrayList<User>();
		for(int i=0; i<5; i++){
			User ui = new User();
			ui.setAvatar("a.jpg");
			ui.setId(1001+i);
			ui.setUsername("姜源"+i);
			ui.setPwd("123");
			ui.setSign("this is a dashabi");
			ui.setStatus("online");
			us.add(ui);
		}
		g.setList(us);
		groups.add(g);
		
		wrap.put("friend",groups);
		
		data.setData(wrap);
		System.out.println(Json.toJson(data));
	}

	@org.junit.Test
	public void test2(){
		Map<String,String> aa = new HashMap<String,String>();
		aa.put("aa", "1");
		aa.put("bb", "2");
	}
	
	
	
}
