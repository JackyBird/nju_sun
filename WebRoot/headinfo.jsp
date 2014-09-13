<%@ page language="java" import="java.util.*,util.ListFits" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	String url = request.getParameter("url");
	//查询数据
	ListFits fit = new ListFits();
	String fitStr = fit.getFits(url);
	String[] list = fitStr.split("@@");
	int size = list.length;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'headinfo.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="css/home_Page.css">

  </head>
  
  <body>
  	<table   cellspacing="0" cellpadding="0" class="div_content_cont_table" style="width:100%;">
		<tr class="div_content_cont_tr">
  			<td colspan="2"><%=list[size-1] %></td>
  		</tr>
		<%
			for(int i = 0;i < size-1; i ++){	
		%>
  		<tr id="condition-lists" onMouseOver="this.style.backgroundColor='#ffff66';" onMouseOut="this.style.backgroundColor='#fff';">
  			<td><%=list[i].split("##")[0] %></td>
  			<td><%=list[i].split("##")[1] %></td>
  		</tr>
  		<%
			}
		%>
  	</table>
  </body>
</html>
