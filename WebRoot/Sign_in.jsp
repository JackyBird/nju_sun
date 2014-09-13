<%@page language="java" import="java.util.*,java.util.Date" pageEncoding="utf-8"%>
<%@page import="java.sql.*,data.*,java.text.*"%>

<!DOCTYPE html>
<html>
	<head>
		<link type="text/css" rel="stylesheet" href="css/Sign_in.css"/>
		<title>注册账号</title>
	<script type="text/javascript" src="js/jquery-1.6.2.min.js"></script>
	</head>
	<body>	
		<div id="container">
			<div id="register-info">
				<h3>
					注册账号
				</h3>
				<div id="user-info">
					<form action="SignServlet?method=sign" method="post" onsubmit="return sub()">
						<ul>
							<li>
								<span>用户名</span>
								<input type="hidden" id="isSign" value="1"/>
								<input id="username" name="userName" tabindex="1" class="user-name" type="text" value="">
								<span id="usernameInfo"></span>
							</li>
							<li>
								<span>登录名</span>
								<input type="hidden" id="isLogin" value="1"/>
								<input id="loginname" name="loginname" tabindex="2" class="login-name" type="text" value="">
								<span id="loginnameInfo"></span>
							</li>
							<li>
								<span>登录邮箱</span>
								<input type="hidden" id="isEmail" value="1"/>
								<input id="email" name="email" tabindex="3" class="email" type="text" value="">
								<span id="emailInfo"></span>
							</li>
							<li>
								<span>登录密码</span>
                  				<input id="password" name="password" tabindex="4" class="password main-password" type="password" value="">
                  				<span id="passwordInfo"></span>
               	 			</li>
               	 			<li>
               	 				<span>再输一次</span>
                  				<input  id="confirmpassword" type="password" tabindex="5" class="password password-again" name="confirmpassword">
                  				<span id="confirmpasswordInfo"></span>
                			</li>
            				<tr>  
        					<td>验证码</td>
        						<td valign="bottom">
        							<input id="vercode" type="text" name="vercode" size="10"/>
        							<span id="yzm"><img alt="" src="authImg" mce_src="authImg" id="authImg" align="absmiddle"></span>
        							<a href="#" mce_href="#" onclick="refresh_img()">
        								<span style="font-size:12px" mce_style="font-size:12px">刷新验证码
        								</span>
        							</a>
        						</td>  
    						</tr> 
    						<br/><br/>
            				<li class="next-btn">
			                	<span></span>
			                	<input class="next-step" value="注册" tabindex="7" type="submit"/>
			                	<span id="next-stepInfo"></span>
			                </li>
			                
						</ul>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>	
<script type="text/javascript">










function refresh_img(){  
    var yzm = document.getElementById("yzm");
    var num = Math.random(100);
    yzm.innerHTML = "<img alt='' src='authImg?"+num+"' mce_src='authImg' id='authImg' align='absmiddle'>";
     
    return false; 
}

    $(function(){
    	$('#username').focusout(function(){
			if($('#username').val()==""){
				$('#usernameInfo').html('<font color="red" size="2">用户不能为空</font>');
				return false;
			}
                $.ajax({
                    url:'SignServlet?method=checkUser',
                    type:'post',
                    data:{'userName':$('#username').val()},
                    success:function(data,statusText){
                        if(data=='4'){
                        	$("#isSign").val("0");
                            $('#usernameInfo').html('<font color="red" size="2">用户名被占用</font>');
                        }
                        if(data=='0'){
                        	$("#isSign").val("1");
                            $('#usernameInfo').html('<font color="green" size="2">用户名可用</font>');
                        }
                    }
                });
        });
    
    
    
    
        $('#loginname').focusout(function(){
			if($('#loginname').val()==""){
				$('#loginnameInfo').html('<font color="red" size="2">登录不能为空</font>');
				return false;
			}
                $.ajax({
                    url:'SignServlet?method=checkLogin',
                    type:'post',
                    data:{'loginname':$('#loginname').val()},
                    success:function(data,statusText){
                    	//alert(data);
                        if(data=='1'){
                        	$("#isLogin").val("0");
                           	$('#loginnameInfo').html('<font color="red" size="2">登录名被占用</font>');
                        }
                        if(data=='0'){
                        	$("#isLogin").val("1");
                            $('#loginnameInfo').html('<font color="green" size="2">登录名可用</font>');
                    	}
                    }
                });
        });
 
        $('#email').focusout(function(){
			if($('#email').val()==""){
				$('#emailInfo').html('<font color="red" size="2">邮箱不能为空</font>');
				return false;
			}
                $.ajax({
                    url:'SignServlet?method=checkEmail',
                    type:'post',
                    data:{'email':$('#email').val()},
                    success:function(data,statusText){
                    	//alert(data);
                        if(data=='2'){
                        	$("#isEmail").val("0");
                            $('#emailInfo').html('<font color="red" size="2">邮箱被占用</font>');
                        }
                        if(data=='0'){
                        	$("#isEmail").val("1");
                            $('#emailInfo').html('<font color="green" size="2">邮箱可用</font>');
                    	}
                    }
                });
        });

		
      
                
    });
    
    
    
function sub() {
	var isSign = $("#isSign").val();
	if(isSign == "0"){
		alert("用户名被占用！");
		return false;
	}
	var isLogin = $("#isLogin").val();
	if(isLogin == "0"){
		alert("登陆名被占用！");
		return false;
	}
	var isEmail = $("#isEmail").val();
	if(isEmail == "0"){
		alert("邮箱被占用！");
		return false;
	}
	var username = document.getElementById("username").value;
	if(username==""){
		alert("请填写用户名！");
		return false;
	}
	var loginname = document.getElementById("loginname").value;
	if(loginname==""){
		alert("请填写登陆名！");
		return false;
	}
	var email = document.getElementById("email").value;
	if(email==""){
		alert("请填写邮箱！");
		return false;
	}
	var password = document.getElementById("password").value;
	if(password==""){
		alert("请填写密码！");
		return false;
	}
	var confirmpassword = document.getElementById("confirmpassword").value;
	if(confirmpassword=="" || password!=confirmpassword){
		alert("请再输入一次正确密码");
		return false;
	}
	var vercode = $('#vercode').val();
	if(vercode==""){
		alert("请填写验证码！");
		return false;
	}else{
		var result=0;
		$.ajax({
            url:'SignServlet?method=checkCode',
            type:'post',
            async:false,
            data:{'vercode':vercode},
            success:function(data,statusText){
                    result = data;
            }
        });
        if(result==1){
        	alert("验证码错误");
        	return false;
        }
	}
}
    
</script>		
