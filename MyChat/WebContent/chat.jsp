<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ChatTest1</title>
	<link rel="stylesheet" href="layim/css/layui.css">
    <script src="layim/layui.js" charset="utf-8"></script>
</head>
<body>
<script type="text/javascript">
    var socket;
    var $;
	layui.use('layim',function(layim){
		$ = layui.jquery;
	    layim.config({
	        init:{
	          url:'/mychat/user/getInitData',
	          type:'get'
	        },
	        chatLog: layui.cache.dir + 'css/modules/layim/html/chatlog.html',
	        msgbox: layui.cache.dir + 'css/modules/layim/html/msgbox.html',
	        brief:false,
	        find:'/mychat/find.jsp', //发现页面地址，若不开启，剔除该项即可,
	        title:'${username}',
	        //可同时配置多个
	        tool: [] ,
	        uploadImage: {
	           url: '/mychat/upload/image'
	       	}
	        //查看群员接口
	        ,members: {
	          url: '/mychat/user/getMembers'
	          ,data: {}
	        }
	    });
	    layim.on('tool(img)',function(insert,send,obj){
	    	console.log(insert);
	    	console.log(send);
	    	console.log(obj);
	    });
	    
	    //接入websocket
	    socket = new WebSocket('ws://localhost:8080/mychat/chat2?name=${username}&id=${me}');
	 	//连接成功时触发
	    socket.onopen = function(){
	 		console.log("${username}登陆成功...");
	 		socket.send(JSON.stringify({'action':'oldMsg'}));	//取查历史消息
	 		console.log(JSON.stringify({'action':'oldMsg'}));
	 		console.log("查询历史消息完毕...");
	 		
	 		layer.msg('我上线了...',{icon: 1,offset: 'lb'});
	    }
	 	
	    socket.onclose = function(){
	    	console.log("${username} 下线成功...");
	    	layer.msg('您已下线...',{icon: 5,offset: 'lb'});
	    }
	    
	    //监听发送消息事件
	    layim.on('sendMessage', function(res){
	    	console.log("发送消息...");
	    	res.action = 'send';
	    	if(res.to.type == 'friend'){
	    		res.type = 'friend';
	    	}else if(res.to.type == 'group'){
	    		res.type = 'group';
	    	}
	    	console.log(res);
	    	res = JSON.stringify(res);
	    	socket.send(res); 
	    	// layim.msgbox(5);
	    });
	    
	    //监听接受到消息事件
	    socket.onmessage = function(res){
	    	 console.log("接收到消息...");
	    	 console.log(res);
	    	 var data  = res.data;
	    	 console.log(data);
	    	 data = JSON.parse(data);
	    	 console.log("data.action:"+data.action);
	    	 if(data.action!='undefined'){
	    		 if(data.action == 'offline'){
	    			 layer.msg(data.msg,{icon: 5,offset: 'lb'}); 
	    			 return;
	    		 }else if(data.action == 'online'){
	    			 layer.msg(data.msg,{icon: 1,offset: 'lb'}); 
	    			 return;
	    		 }
	    	 }
	    	 //res = JSON.parse(res);
	    	 layim.getMessage(data); //res.data即你发送消息传递的数据（阅读：监听发送的消息） 
	    };
	    
	    //监听页面就绪回调
	    layim.on('ready', function(options){
	    	  console.log(options);
	    	  layim.setFriendStatus(2, 'offline');
	    	  //查询是否有未读消息
	    	  $.ajax({
	    		  url:'/mychat/user/unreadMsgCount',
	    		  success:function(data){
	    			  console.log(data);
	    			  if(data.count >0){
	    				  layim.msgbox(data.count); //数字即为你通过websocket或者Ajax实时获取到的最新消息数量
	    			  }
	    		  }
	    	  });
	    	  //do something
	    });
	    
	    
	    
	    //监听切换在线状态回调
	    layim.on('online', function(status){
	    	if(status == 'online'){
	    		$.get('/mychat/user/online');
	    	}else{
	    		$.get('/mychat/user/hide');
	    	}
	    });
	    
	    //监听修改签名回调
	    layim.on('sign', function(value){
	    	$.get('/mychat/user/updateSign',{'sign':value});
	    });
	    
	    //每次窗口打开或切换，即更新对方的状态
	    layim.on('chatChange', function(res){
	      var type = res.data.type;
	      console.log(res);
	      if(type === 'friend'){
	    	  var id = res.data.id;
	    	  $.get('/mychat/user/getUser',{'id':id},function(data){
	    		 console.log(data);
	    		 if(data.status == 'online'){
	    			 layim.setChatStatus('<span style="color:#FF5722;">在线</span>'); //模拟标注好友在线状态
	    		 }else{
	    			 layim.setChatStatus('<span style="color:#8D9794;">离线</span>'); //模拟标注好友在线状态
	    		 }
	    	  });
	    	  
	        
	      } else if(type === 'group'){
	        
	      }
	    });
	});
	
	  //刷新页面,关闭页面等操作时关闭socket连接通道
	  window.onbeforeunload = function(){
		  socket.close();
	  };
	  
</script>
	
</body>
</html>