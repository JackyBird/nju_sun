<%@page language="java" import="java.util.*,java.util.Date" pageEncoding="utf-8"%>
<%@page import="java.sql.*,data.*,java.text.*"%>
<%
	DataAccessService das = new DataAccessService();
	das.setJdbcDriver("dm.jdbc.driver.DmDriver");
	das.setConStr("jdbc:dm://127.0.0.1:12345/dqmis");
	das.setUserName("SYSDBA");
	das.setPassWord("SYSDBA");
	ResultSet rs = null;
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>