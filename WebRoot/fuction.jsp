<%@page language="java"import="java.util.*,java.sql.*"pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPEHTMLPUBLIC"-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>My JSP 'fuction.jsp' starting page</title>
		<meta http-equiv="pragma"content="no-cache">
		<meta http-equiv="cache-control"content="no-cache">
		<meta http-equiv="expires"content="0">
		<meta http-equiv="keywords"content="keyword1,keyword2,keyword3">
		<meta http-equiv="description"content="This is my page">
		<!--
		<link rel="stylesheet" type="text/css" href="styles.css">
		-->
	</head>
	<body>
		<%
		String username=request.getParameter("username");
		String passwd=request.getParameter("password");
		String roleID=request.getParameter("roleID");
		//int roleID=Integer.parseInt(request.getParameter("roleID"));
		String className="dm.jdbc.driver.DmDriver";
		String url="jdbc:dm://127.0.0.1:12345/dqmis";
		String user="SYSDBA";
		String password="SYSDBA";
		Connection conn = DriverManager.getConnection(url, user, password);;
		//Statement st;
		Class.forName(className);

		String sql="INSERT INTO dq_app.user(username,password,roleID)values('"+username+"','"+passwd+"','"+roleID+"')";
		//VALUES('"+username+"','"+passwd+"',"+roleID+")";
		
		//st = (Statement) conn.createStatement();    // 创建用于执行静态sql语句的Statement对象
		Statement st = conn.createStatement();
		int row=st.executeUpdate(sql); // 执行插入操作的sql语句，并返回插入数据的个数
		if(row>0)
		{
		response.sendRedirect("success.jsp");
		}	
		conn.close();   //关闭数据库连接
		
		%>
	</body>
</html>