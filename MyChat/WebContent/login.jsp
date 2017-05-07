<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
		<script src="js/jquery-1.11.1.js"></script>
		<script>
			$(document).ready(function() {
				$(".form").slideDown(500);
				$("#landing").addClass("border-btn");
				$("#registered").click(function() {
					$("#landing").removeClass("border-btn");
					$("#landing-content").hide(500);
					$(this).addClass("border-btn");
					$("#registered-content").show(500);
					
				})

				$("#landing").click(function() {
					$("#registered").removeClass("border-btn");
					$(this).addClass("border-btn");
					
					$("#landing-content").show(500);
					$("#registered-content").hide(500);
				})
			});
		</script>
		<style>
			* {
				margin: 0;
				padding: 0;
				font-family: "微软雅黑";
			}
			
			body {
				background: #F7F7F7;
			}
			
			.form {
				position: absolute;
				top: 50%;
				left: 50%;
				margin-left: -185px;
				margin-top: -210px;
				height: 420px;
				width: 340px;
				font-size: 18px;
				-webkit-box-shadow: 0px 0px 10px #A6A6A6;
				background: #fff;
			}
			
			.border-btn {
				border-bottom: 1px solid #ccc;
			}
			
			#landing,
			#registered {
				float: left;
				text-align: center;
				width: 170px;
				padding: 15px 0;
				color: #545454;
			}
			
			#landing-content {
				clear: both;
			}
			
			.inp {
				height: 30px;
				margin: 0 auto;
				margin-bottom: 30px;
				width: 200px;
			}
			
			.inp>input {
				text-align: center;
				height: 30px;
				width: 200px;
				margin: 0 auto;
				transition: all 0.3s ease-in-out;
			}
			
			.login {
				border: 1px solid #A6A6A6;
				color: #a6a6a6;
				height: 30px;
				width: 202px;
				text-align: center;
				font-size: 13.333333px;
				margin-left: 70px;
				line-height: 30px;
				margin-top: 30px;
				transition: all 0.3s ease-in-out;
			}
			
			.login:hover {
				background: #A6A6A6;
				color: #fff;
			}
			
			#bottom {
				margin-top: 30px;
				font-size: 13.333333px;
				color: #a6a6a6;
			}
			
			#registeredtxt {
				float: left;
				margin-left: 80px;
			}
			
			#forgotpassword {
				float: right;
				margin-right: 80px;
			}
			
			#photo {
				border-radius: 80px;
				border: 1px solid #ccc;
				height: 80px;
				width: 80px;
				margin: 0 auto;
				overflow: hidden;
				clear: both;
				margin-top: 30px;
				margin-bottom: 30px;
			}
			
			#photo>img:hover {
				-webkit-transform: rotateZ(360deg);
				-moz-transform: rotateZ(360deg);
				-o-transform: rotateZ(360deg);
				-ms-transform: rotateZ(360deg);
				transform: rotateZ(360deg);
			}
			
			#photo>img {
				height: 80px;
				width: 80px;
				-webkit-background-size: 220px 220px;
				border-radius: 60px;
				-webkit-transition: -webkit-transform 1s linear;
				-moz-transition: -moz-transform 1s linear;
				-o-transition: -o-transform 1s linear;
				-ms-transition: -ms-transform 1s linear;
			}
			
			
			#registered-content {
				margin-top: 40px;
				display: none;
			}
			
			.fix {
				clear: both;
			}
			.form{
				display: none;
			}
		</style>
	</head>

	<body>
		<div class="form">
			<div id="landing">登录</div>
			<div id="registered">注册</div>
			<div class="fix"></div>
			<div id="landing-content">
				<div id="photo"><img src="img/photo.png" /></div>
				<div class="inp"><input type="text" id="uname" name="username" placeholder="用户名" /></div>
				<div class="inp"><input type="password" id="upwd" name="pwd" placeholder="密码" /></div>
				<div class="login" onclick="login()">登录</div>
			</div>
			<div id="registered-content">
				<div class="inp"><input type="text" id="uname2" name="username" placeholder="请输入用户名" /></div>
				<div class="inp"><input type="password" id="upwd2" name="pwd" placeholder="请输入密码" /></div>
				<div class="inp"><input type="password" id="upwdto"  placeholder="请再次输入密码" /></div>
				<div class="inp"><input type="text" name="sign" id="sign" placeholder="来个个性签名吧" /></div>
				<div class="login" onclick="registry()">立即注册</div>
			</div>
		</div>
		<div style="text-align:center;">
</div>
	</body>
	<script type="text/javascript">
	function login(){
		//alert($('#uname').val());
		
		if($.trim($('#uname').val())==''){
			alert('请输入用户名!');
			return;
		}
		if($.trim($('#upwd').val())==''){
			alert('请输入密码!');
			return;
		} 
		
		var name = $('#uname').val();
		var pwd = $('#upwd').val();
		$.ajax({
			url:'/mychat/user/login',
			data:{username:name,pwd:pwd},
			dataType:'json',
			success:function(data){
				console.log(data);
				if(data.ok==true){
					alert('登陆成功!');
					location.href='/mychat/chat.jsp';
				}else{
					alert('用户名或密码错误!');
				}
			}
		});
	}
	
	
	function registry(){
		var name = $.trim($('#uname2').val());
		var pwd = $.trim($('#upwd2').val());
		var sign = $.trim($("#sign").val());
		if(name==''){
			alert('请输入用户名!');
			return;
		}
		if(pwd==''){
			alert('请输入密码!');
			return;
		} 
		if($.trim($('#upwdto').val())==''){
			alert('请再次输入密码!');
			return;
		} 
		if($.trim($('#upwd2').val()) != pwd){
			alert('两次密码不正确!');
			return;
		} 
		
		$.ajax({
			url:'/mychat/user/registry',
			data:{username:name,pwd:pwd,sign:sign},
			dataType:'json',
			success:function(data){
				console.log(data);
				if(data.ok==true){
					alert('注册成功!');
					location.href='/mychat/chat.jsp';
				}else{
					alert(data.msg);
				}
			}
		});
		
	}
	
	</script>
</html>