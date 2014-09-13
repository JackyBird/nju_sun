<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="css/resolve.css"/>
<title>数据解析</title>
</head>
<script type="text/javascript" src="js/jquery-1.6.2.min.js"></script>
<body>


<div id="container">
	<div id="register-info">
		<h1>点击按钮从该路径进行解析</h1>
		<div id="user-info">
			<form action="ResolveServlet" method="post" onsubmit="return sub()">
				<p><span>IP地址:&nbsp</span><input type="text" name="ip" id="ip"/></p>
				<p><span>路径地址:</span><input type="text" name="path" id="path"/></p>
				<span></span><input id="button" type="button" value="解析图片" target="main" onclick="sub()"/>
			</form>
		</div>
	</div>
</div>




</body>
</html>

<script type="text/javascript">

function sub() {
	var ip = document.getElementById("ip").value;
	if(ip==""){
		alert("请填写IP！");
		return false;
	}
	var path = document.getElementById("path").value;
	if(path==""){
		alert("请填写路径！");
		return false;
	}
	$.ajax({
        url:'ResolveServlet?path='+path,
        type:'post',
        async:false,
        success:function(data,statusText){
                result = data;
                alert(data);
                window.close();
        }
    });
}

</script>