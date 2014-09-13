<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="BasePage.jsp"%>
<%
	String id = request.getParameter("id");
	String sql = "select * from DQ_APP.act_Sun_Pic where id_='"+id+"'";
	String picName = "";
	rs = das.executeQuery(sql);
	if(rs.next()){
		picName = rs.getString("FILE_NAME_").replace(".fits",".jpg").replace("E://fits//","");
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ImageView.jsp' starting page</title>
  </head>
  
  <body>
    <div><img src="pic/<%=picName %>" width="618" height="619"></div>
  </body>
</html>
