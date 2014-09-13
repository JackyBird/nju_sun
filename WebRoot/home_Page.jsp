<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String username = session.getAttribute("username")==null?"":session.getAttribute("username").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<link type="text/css" rel="stylesheet" href="css/home_Page.css"/>
	<title>首页</title>
	<script type="text/javascript">
	 function ResumeError(){ 
		return true; 
	 } 
	 window.onerror = ResumeError; 
	</script>
	<script type="text/javascript" src="js/jquery-1.6.2.min.js"></script></head>
	<body>
	<img class="div_top_img" src="pic\top_bg.png"/>
	<div class="div_container">
  		<!-- top -->
  		<div class="div_top">
  			<div class="div_top_link" align="right">
  				<table cellspacing="0" cellpadding="0" >
  					<tr>
  						<%
							if(!"".equals(username)){
						%>
  						<td>当前用户：<%=username%></td>
						<td class="div_top_link_line">&nbsp;</td>
						<td><a href="javascript:void(0);" title="注销" onclick="logout()">注销</a></td>
						<%
							}
						%>
						<%
							if("".equals(username)){
						%>
						<td>当前用户：匿名</td>
						<%
							}
						%>
					</tr>
  				</table>
  			</div>
  			<div class="div_top_logo">
  				<table cellpadding="0" cellspacing="0">
  					<tr>
  						<td>
  							<div class="div_top_logo_item2" id="div_top_logo_item2">
  								&nbsp;
  							</div>
  						</td>
  						<td>
  								&nbsp;
						</td>
  					</tr>
  				</table>
  			</div>
  		</div>
  		<div class="div_nav">
			<div id="nav">
				<form action="LoginServlet" method="post" onsubmit="return sub()">
					<ul>
						<li><a href="home_Page.jsp">首页</a></li>
						<li><a id="intro" href="group_Research.jsp" target="main">课题组介绍</a></li>
						<li><a id="machine" href="observation_Instrument.jsp" target="main">观察设备</a></li>
						<li><a id="load" href="javascript:void(0);" target="main" onclick="loadpage()"><input type="hidden" id="id" value="<%=username%>" />数据浏览及下载</a></li>
						<li><a id="guid" href="operating_Guide.jsp" target="main">本站使用指南</a></li>
						<li><a id="contact" href="Contact.jsp" target="main">联系我们</a></li>
						<%
							if("系统管理员".equals(username)){
						%>
						<li id="lists"><a href="javascript:void(0);" target="main" onclick="sub()">数据维护</a></li>
						<!--li id="lists"><a href=# onclick="javascript:window.open('http://127.0.0.1:8080/NJU_Sun/path.jsp','','width=630,height=630,toolbar=no, status=no, menubar=no, resizable=none, scrollbars=none');return false;">路径选择</a></li-->
						<%
							}
						%>
						<%
							if("".equals(username)){
						%>
						<li id="lists"><a href="Sign_in.jsp" target="main">注册</a></li>
						<li id="lists"><a href="Login_in.jsp" target="main">登陆</a></li>
						<%
							}
						%>
						<!--input id="Resolve"  class="div_button" type="button" value="解析图片" onclick="sub()"/-->
					</ul>
				</form>
			</div>
		</div>
		<div class="div_content" id="introduce">
			<iframe id="main" name="main" src="main_Introduce.jsp" style="width:100%; height:100%;" frameborder="0"  marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe>
		</div>
		<!-- copyright -->
		<div class="div_copyright">
			南京鼎乾信息科技有限公司版权所有 2014 copyright
		</div>
	</div>
</body>
</html>
<script type="text/javascript">

function loadpage(){
	var id=document.getElementById("id").value;
      	if(id == ""){
            alert("没有用户登录");
            document.getElementById("main").src="Login_in.jsp";
		}else{
			document.getElementById("main").src="Load.jsp";
		}
}

function sub() {
		var url; //转向网页的地址;
		var name; //网页名称，可为空;
		var iWidth=600; //弹出窗口的宽度;
		var iHeight=500; //弹出窗口的高度;
		//window.screen.height获得屏幕的高，window.screen.width获得屏幕的宽
		var iTop = (window.screen.height-30-iHeight)/2; //获得窗口的垂直位置;
		var iLeft = (window.screen.width-10-iWidth)/2; //获得窗口的水平位置;
		window.open("resolve.jsp?url="+url,"_blank",'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
}
function logout() {
	$.ajax({
        url:'logout.jsp',
        type:'post',
        success:function(data,statusText){
        	if(data == "success"){
	        	alert("注销成功！");
        	}
        	window.location = window.location;
       	}
    });
}

</script>