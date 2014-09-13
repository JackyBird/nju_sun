<%@page language="java"import="java.util.*"pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPEHTMLPUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		
		<title>My JSP 'success.jsp' starting page</title>
		
		<meta http-equiv="pragma"content="no-cache">
		<meta http-equiv="cache-control"content="no-cache">
		<meta http-equiv="expires"content="0">
		<meta http-equiv="keywords"content="www.mwcly.cn,keyword2,keyword3">
		<meta http-equiv="description"content="This is my page">
		<!--
		<link rel="stylesheet" type="text/css" href="styles.css">
		-->
		
	</head>
	<body>
		成功插入数据！<a href="View.jsp">返回继续</a>
	</body>
</html>