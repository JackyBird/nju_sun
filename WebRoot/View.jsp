<%@page language="java"import="java.util.*"pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPEHTMLPUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		
		<title>My JSP 'index.jsp' starting page</title>
		<meta http-equiv="pragma"content="no-cache">
		<meta http-equiv="cache-control"content="no-cache">
		<meta http-equiv="expires"content="0">
		<meta http-equiv="keywords"content="keyword1,keyword2,keyword3">
		<meta http-equiv="description"content="This is my page">
		<!--www.mwcly.cn
		<link rel="stylesheet" type="text/css" href="styles.css">
		-->
	</head>
	<body>
		<form action="fuction.jsp"method="post">
			<table width="400"align="center"border="1"cellpadding="0"cellspacing="0">
				<tr><td colspan="2"align="center">向数据库插入信息测试</td></tr>
				<tr><td>username：</td><td><input type="text"name="username"/></td></tr>
				<tr><td>password：</td><td><input type="text"name="password"/></td></tr>
				<tr><td>roleID：</td><td><input type="text"name="roleID"/></td></tr>
				<tr><td colspan="2"align="center"><input type="submit"value="插入"/></td></tr>
			</table>
		</form>
	</body>
</html>