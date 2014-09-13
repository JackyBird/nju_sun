<%@page language="java" import="java.util.*,java.util.Date" pageEncoding="utf-8"%>
<%@page import="java.sql.*,data.*,java.text.*"%>
<%@ include file="BasePage.jsp"%>
<%
	String pageNum = request.getParameter("pageNum")==null?"1":request.getParameter("pageNum");
	String sdate = request.getParameter("sdate")==null?"":request.getParameter("sdate");
	String edate = request.getParameter("edate")==null?"":request.getParameter("edate");
	String wavelength = request.getParameter("wavelength")==null?"":request.getParameter("wavelength");
	int first = (Integer.valueOf(pageNum)-1)*20;
	String filter = "1=1";
	if(!sdate.equals("")){
		filter = filter+" and date>='"+sdate+"'";
	}
	if(!edate.equals("")){
		filter = filter+" and date<='"+edate+"'";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>    
		<link type="text/css" rel="stylesheet" href="css/Loaddd.css"/>
		<link type="text/css" rel="stylesheet" href="css/home_Page.css"/>
    	<title>数据浏览及下载</title>
	<script type="text/javascript" src="js/jquery-1.6.2.min.js"></script>
	<script type="text/javascript" src="js/WdatePicker.js"></script>
	</head>  
	<body>
		<div id="container">	
			<div class="div_content_cont_only_condition">
				<table class="div_content_cont_only_condition_tab" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td align="right">开始时间：</td>
						<td align="left">
							<input class="div_time" id="sdate" type="text" onclick="WdatePicker({el:'sdate',skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"/>
						</td>
						<td align="right">结束时间：</td>
						<td align="left">
							<input class="div_time" id="edate" type="text" onclick="WdatePicker({el:'edate',skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"/>
						</td>
						<td align="right">波长：</td>
						<td align="left">
							<select id="" class="div_select">
								<option>WL3600</option>
								<option>6562.81</option>
								<option></option>
								<option></option>
							</select>
						</td>
						<td align="right">波长偏移量：</td>
						<td align="left">
							<select  class="div_select">
								<option>C00</option>
								<option></option>
								<option></option>
								<option></option>
							</select>
						</td>
						<td align="right">全或局部像：</td>
						<td align="left">
							<select  class="div_select">
								<option>FOV</option>
								<option></option>
								<option></option>
								<option></option>
							</select>
						</td>
						<td align="center">
							<input class="div_button" type="button" value=" 查询 " onclick="query()" />
						</td>
						<td align="center">
							<input class="div_button" id="package-btn" type="button" value="打包与下载" onclick="expZip()"/>
						</td>
					</tr>
				</table>
			</div>
			<table cellspacing="0" cellpadding="0" class="div_content_cont_table" >
				<tr class="div_content_cont_tr">
					<td width="3%"><input id="select-all" type="checkbox" name="all" onClick="allCheck(this)"></td>
					<td width="5%">序号</td>
					<td>文件名</td>
					<td>观测时间</td>
					<td>查看图像</td>
					<td>查看文件头</td>
					<td>下载</td>
				</tr>
				<%
					String allSql = "select count(*) num from DQ_APP.act_Sun_Pic where "+filter;
					//System.out.print(allSql);
					int allNum = 0;
					rs = das.executeQuery(allSql);
					if(rs.next()){
						allNum = rs.getInt("num");
					}
					int allPage = (allNum-1)/20+1;
					String sql = "select top "+first+",20 * from DQ_APP.act_Sun_Pic where "+filter;
					//System.out.println(sql);
					rs = das.executeQuery(sql);
					int i=(Integer.valueOf(pageNum)-1)*20;
					while(rs.next()){
						i++;
				%>
				<tr id="condition-lists" onMouseOver="this.style.backgroundColor='#ffff66';" onMouseOut="this.style.backgroundColor='#fff';">
					<td><input type="checkbox" name="ok" value="<%=rs.getString("ID_")%>"/></td>
					<td><%=i%></td>
					<td><%=rs.getString("FILE_NAME_")%></td>
					<td><%=rs.getString("DATE")%></td>
					<td><a href=# onclick="showPic('<%=rs.getString("ID_")%>')">查看图像</a></td>
					<td><a href="javascript:void(0);" onclick="showHeadInfo('<%=rs.getString("FILE_NAME_") %>');">查看头信息</a></td>
					<td><a href="<%=rs.getString("FILE_NAME_")%>" onclick="load()">下载文件</a></td>
				</tr>
				<%
					}
				%>
			</table>
			<div id="page" align="center">
				<table cellspacing="0" cellpadding="0" class="div_content_cont_table" style="width:37%;">
					<tr>
						<td><a onclick="getPage('first')"><span>首页</span></a></td>
						<td><a <%if(pageNum.equals("1")){ %>title="已经是第一页"<%}else{ %> onclick="getPage('up')"<%} %>><span>上一页</span></a></td>
						<td><a <%if(Integer.valueOf(pageNum)==allPage){ %>title="已经是最后一页"<%}else{ %> onclick="getPage('down')"<%} %>><span>下一页</span></a></td>
						<td><a onclick="getPage('end')"><span>末页</span></a></td>
						<td>共<%=allNum %>条记录</td>
						<td>第
							<select name="topage" size="1" onchange="getPage('go',this)">
						    	<%for(i=0;i<allPage;i++){ %>
									<option value="<%=i+1 %>" <%if(Integer.valueOf(pageNum)==(i+1)){ %>selected<%} %>><%=i+1 %></option>
								<%} %>
							</select>页
						</td>
						<td></td>
					</tr>
				</table>
			</div>	
		
				
			
		</div>			
	</body>
</html>
<script language="javascript">
　　function allCheck(check){
　　　　var checkbox=document.getElementsByName("ok");
　　　　if(check.checked){
　　　　　　for(var i=0;i<checkbox.length;i++){
　　　　　　　　checkbox[i].checked="checked";
　　　　　　}    	
　　　　}else{
　　　　　　for(var i=0;i<checkbox.length;i++){
　　　　　　　　checkbox[i].checked="";
　　　　　　} 
　　　　}
　　}
	function load(){
		var fileId = "ok";
		var checkbox=document.getElementsByName("ok");
		for(var i=0;i<checkbox.length;i++){
　　　　　　　　if(checkbox[i].checked==true){
			 	fileId = fileId+","+checkbox[i].value;
			 }
　　　　　} 
		if(fileId==""){
			alert("请选择需要打包下载的文件！");
		}else{
			$.ajax({
	              url:'ZipServlet?method=delDir',
	              type:'post',
	              data:{'ids':fileId},
	              success:function(data,statusText){
	              	if(data==1){
	              		alert("打包失败");
	              	}else{
	              		window.open("zip//"+data);
	              	}
	              }
	         });
         }
	}
	function expZip(){
		var fileId = "";
		var checkbox=document.getElementsByName("ok");
		for(var i=0;i<checkbox.length;i++){
　　　　　　　　if(checkbox[i].checked==true){
			 	fileId = fileId+","+checkbox[i].value;
			 }
　　　　　} 
		if(fileId==""){
			alert("请选择需要打包下载的文件！");
		}else{
			$.ajax({
	              url:'ZipServlet?method=delDir',
	              type:'post',
	              data:{'ids':fileId},
	              success:function(data,statusText){
	              	if(data==1){
	              		alert("打包失败");
	              	}else{
	              		window.open("zip//"+data);
	              	}
	              }
	         });
         }
	}
     
     
     function getPage(type,obj){
     	var pageNum=parseInt("<%=pageNum%>");
     	if(type=="first"){
     		pageNum=1;
     	}else if(type=="down"){
     		pageNum=pageNum+1;
     	}else if(type=="up"){
     		pageNum=pageNum-1;
     	}else if(type=="go"){
     		pageNum = obj.value;
     	}else if(type=="end"){
     		pageNum = "<%=allPage%>";
     	}
     	window.location="?pageNum="+pageNum;
     }
     
     function query(){
     	var pageNum=parseInt("<%=pageNum%>");
     	var sdate = $("#sdate").val();
     	var edate = $("#edate").val();
     	var wavelength = $("#wavelength").val();
     	window.location="?pageNum="+pageNum+"&sdate="+sdate+"&edate="+edate+"&wavelength="+wavelength;
     }
     function showHeadInfo(url){
     	///window.open("headinfo.jsp?url="+url,"_blank");
     	var url; //转向网页的地址;
		var name; //网页名称，可为空;
		var iWidth=600; //弹出窗口的宽度;
		var iHeight=500; //弹出窗口的高度;
		//window.screen.height获得屏幕的高，window.screen.width获得屏幕的宽
		var iTop = (window.screen.height-30-iHeight)/2; //获得窗口的垂直位置;
		var iLeft = (window.screen.width-10-iWidth)/2; //获得窗口的水平位置;
		window.open("headinfo.jsp?url="+url,"_blank",'height='+iHeight+',,innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
     }
     function showPic(id){
     	////alert(id);
     	window.open('ImageView.jsp?id='+id,'','width=630,height=630,toolbar=no, status=no, menubar=no, resizable=none, scrollbars=none');
     	return false;
     }
</script>








