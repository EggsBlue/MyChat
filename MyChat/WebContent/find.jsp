<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="layim/css/layui.css">
    <script src="layim/layui.js" charset="utf-8"></script>
</head>
<style>
	*{
		margin: 0;
		padding: 0;
	}
	li{
		margin: 10px;
		margin-left:35px;
		margin-bottom:20px;
		display: inline;
		float: left;
	}
</style>
<div class="layim-add-box" style="display: none;" id="box">
	<div class="layim-add-img">
		<img class="layui-circle" src="" id="uimg">
		<p id="uname">xxx</p>
	</div>
	<div class="layim-add-remark">
		<p>选择分组</p>
		<select class="layui-select" id="LAY_layimGroup" onchange="tabgroup(this)">
			
		</select>
	</div>
</div>

<body>

<fieldset class="layui-elem-field">
  <legend>找朋友(支持群)</legend>
	  <div class="layui-field-box layui-form">
	  	<input type="text" name="name" required lay-verify="required" placeholder="请输入内容" class="layui-input" style="width: 50%; display: inline;">&nbsp;&nbsp;&nbsp;&nbsp;<button class="layui-btn" style="display: inline;" id="btn_seach"  >搜索</button>
  	  </div>
</fieldset>
<div>
	<ul id="content">
  	  	<!-- <li style="">
  	  		<img style="border-radius: 20px; display: inline;width:100px; height:100px; float: left;" src='/mychat/imgs/1.jpg' >
  	  		<div style="float: left;">
	  	  		<span style="font-size: 24px; color: buttonshadow; margin: 4px; margin-left: 7px;">小明</span>
	  	  		<span style="color:#3FDD86;">在线</span>
	  	  		<span style="color:#DD691D;">离线</span>
	  	  		<div style="display: block; margin-top: 10px; margin-left: 5px;"><button class="layui-btn layui-btn-radius layui-btn-normal">加好友</button></div>
  	  		</div>
  	  	</li> -->
  	  </ul>
</div>


<script type="text/javascript">
	var layim;
	var layer;
	var laytpl;
	var $;
	var laypage;
	layui.use(['layim', 'laypage','form'], function(){
	   layim = layui.layim
	  ,layer = layui.layer
	  ,laytpl = layui.laytpl
	  ,$ = layui.jquery
	  ,laypage = layui.laypage;
	  
	  //查找好友btn
	   $('#btn_seach').click(function(){
		    var name = $("[name=name]").val();
			if($.trim(name) == ''){
				layer.alert("请输入要查找的用户名!");
				return;
			}
		   
			$.ajax({
				url:'/mychat/user/seachUser',
				dataType:'json',
				data:{name:name},
				async:false,
				success:function(data){
					$('#content').text("");
					console.log(data);
					var users = JSON.parse(data);
					if(undefined!=users && users.length>0){
						$(users).each(function(){
							var status = "";
							if(this.status == 'online'){
								status = "<span style=\"color:#3FDD86;\">在线</span>";
							}else{
								status = "<span style=\"color:#DD691D;\">离线</span>";
							}
							var li = '<li id='+this.id+'> <img style="border-radius: 20px; display: inline;width:100px; height:100px; float: left;" src=\''+this.avatar+'\' > <div style="float: left;"> <span style="font-size: 24px; color: buttonshadow; margin: 6px; margin-left: 17px;">'+this.username+'</span>'+status+' <div style="display: block; margin-top: 10px; margin-left: 5px;"><button class="layui-btn layui-btn-radius layui-btn-normal" data-type="agree" onclick="addFriend(this)">加好友</button></div> </div> </li>';
							$('#content').append(li);
						});
					}else{
						layer.alert("没查询到相关用户!");
					}
				}
			});
	   });
	   
	});
	
	  var fromgroup = 0;
		
	  //加好友
	  function addFriend(obj){
		 var _obj = obj;
		 //console.log($(_obj).parent().prev().prev());
		 var username = $(_obj).parent().prev().prev().text();
		 var avatar =  $(_obj).parent().parent().prev().attr('src');
		 var groups = parent.layui.layim.cache().friend;
		 
		 var me = '${username}';
		 if(me == username){
			 alert('不能添加自己为好友!');
			 return;
		 }
		 console.log("username:"+username);
		 console.log("avatar:"+avatar);
		 console.log("groups:"+groups);
		 $('#uimg').attr('src',avatar);
		 $('#uname').text(username);
		 console.log( $('#ugroup'));
	     $(groups).each(function(index,item){
	    	 if(index == 0){
	    		 fromgroup = item.id;
	    	 }
	    	 console.log("id:"+item.id);
	    	 console.log("groupname:"+item.groupname);
	    	 var op = "<option value='"+item.id+"'>"+item.groupname+"</option>";
	    	 console.log(op);
	    	 $('#LAY_layimGroup').append(op);
		 });
		 
		 layer.open({
			   title: '添加好友'
			  ,content: $('#box').html()
			  ,area: ['450px', '270px']
		 	  ,btn: ['确定', '取消']
		 	  ,yes: function(index, layero){
		 		  var uid = $($(_obj).parent().parent().parent()).attr('id');
		 		  console.log("uid:"+uid);
		 		  console.log("groupid:"+fromgroup);
		 		  
		 		   $.ajax({
		 			  url:'/mychat/user/applyFriend',
		 			  type:'get',
		 			  data:{'uid':uid,'from_group':fromgroup},
		 			  success:function(data){
		 				  console.log(data);
		 				  if(data.ok == 1){
		 					  layer.msg("发送成功!");
		 					 $('#LAY_layimGroup').text("");
		 				  }else{
		 					 layer.msg("发送失败!");
		 					 $('#LAY_layimGroup').text("");
		 				  }
		 			  }
		 			  
		 		  }); 
		 		  
		 	    //alert("按钮1");
		 	  }
		 	  ,btn2: function(index, layero){
		 	   $('#LAY_layimGroup').text("");
		 	    //return false 开启该代码可禁止点击该按钮关闭
		 	  },cancel:function(){
		 		 $('#LAY_layimGroup').text("");
		 	  }
		 });
		 
		  /* parent.layui.layim.setFriendGroup({
		        type: 'friend'
		        ,username: $(_obj).parent().prev().prev().text()
		        ,avatar: $(_obj).parent().parent().prev().attr('src')
		        ,group: parent.layui.layim.cache().friend //获取好友分组数据
		        ,submit: function(group, index){
		        }
		      }); */
	  }
	  
	  
	  function tabgroup(obj){
		  fromgroup = $(obj).val();
	  }
</script>
</body>
</html>