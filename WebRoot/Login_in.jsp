<%@page language="java" import="java.util.*,java.util.Date" pageEncoding="utf-8"%>
<%@page import="java.sql.*,data.*,java.text.*"%>
<!DOCTYPE html>
<html>
	<head>
		<link type="text/css" rel="stylesheet" href="css/Login_in.css"/>
		<title>登录</title>
	</head>
	<body>	
		<div id="container">
			<div id="register-info">
				<h3>
					登录
				</h3>
				<div id="user-info">
					<form action="LoginServlet" method="post" onsubmit="return sub()">
						<ul>
							<li>
								<span>登录名</span>
								<input id="loginname" name="loginname" tabindex="1" class="login-name" type="text" value="">
								<span id="loginnameInfo"></span>
							</li>
							<li>
								<span>登录密码</span>
                  				<input id="password" name="password" tabindex="2" class="password main-password" type="password" value="">
                  				<span id="passwordInfo"></span>
               	 			</li>
            				<!--tr>  
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
    						<br/><br/-->
            				<li class="next-btn">
			                	<span></span>
			                	
			                	<input class="next-step" value="登陆" tabindex="4" type="submit""/>
			                	<span id="next-stepInfo"></span>
			                	<li><a id="contact" href="Sign_in.jsp" target="main">注册一个账号</a></li>
			                </li>
						</ul>
					</form>
				</div>
			</div>
		</div>
	</body>
</html>	
<script type="text/javascript">
function sub() {
	var loginname = document.getElementById("loginname").value;
	if(loginname==""){
		alert("请填写登陆名！");
		return false;
	}
	var password = document.getElementById("password").value;
	if(password==""){
		alert("请填写密码！");
		return false;
	}
	var vercode = $('#vercode').val();
	if(vercode==""){
		alert("请填写验证码！");
		return false;
	}else{
		var result=0;
		$.ajax({
            url:'LoginServlet?method=checkCode',
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
function refresh_img(){  
    var yzm = document.getElementById("yzm");
    var num = Math.random(100);
    yzm.innerHTML = "<img alt='' src='authImg?"+num+"' mce_src='authImg' id='authImg' align='absmiddle'>";
     
    return false; 
}
// function show(){
// 	if (!loginname=="" && !password=="") {
// 		alert();
// 	};
// }
</script>