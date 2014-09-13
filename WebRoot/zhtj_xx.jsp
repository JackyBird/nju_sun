<%@page language="java" import="java.util.*,java.sql.*,java.text.*" pageEncoding="UTF-8"%>
<%@ include file="BasePage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>信号</title>
<style>
.title_tr{
	background-color:#C8E0FB;
	height:25px;
}
.title_td{
	background-color:#E2EDFB;
}
.bw_td{
	background-color:#EFF5FD;
}
.Tab{ border-collapse:collapse;}
.Tab td,th{ border:solid 1px #ccc;font-size:14px;font-family: "Arial","Verdana","sans-serif";text-align:center;}
.hoverTr{background-color:#EAEAEB;}
.leaveTr{background-color:#F2F6FB;}
</style>
</head>

<body><img src="images/exl.gif" title="导出excel" style="margin-top:2px;margin-left:2px;cursor:hand" onclick="ExportToExcel()"/>
<center>
	<table id="t1" width="100%" class="Tab" cellspacing="0" cellpadding="0" >
	  <thead>
	  <tr class="title_tr" style="cursor:hand">
		<th width="10%"  scope="col" id="num">序号</th>
		<th width="15%"  scope="col" id="areaname">地区</th>
		<th width="20%" scope="col" id="facname">变电站</th>
		<th  scope="col" width="35%" id="xhname">信号名称</th>
		<th  scope="col" width="20%" id="fzsj">动作时间</th>
	</tr>
	 </thead>
	<tbody> 
<%
	String sql = "";//out.print(sql);
	rs = das.executeQuery(sql);
	int j=0;
	while(rs.next()){
			j++;
			if(j%2==0){
				out.print("<tr height='25' bgcolor='#EAEAEB'>");
			}else{
				out.print("<tr height='25' bgcolor='#F2F6FB'>");
			}
			out.print("<td>"+j+"</td>");
			out.print("<td>"+rs.getString("AREA_NAME")+"</td>");
			out.print("<td>"+rs.getString("FAC_NAME")+"</td>");
			out.print("<td>"+rs.getString("TIMES")+"</td></tr>");
		//}
	}	
%>
	</tbody>
	</table>
</center>
<script type="text/javascript" src="scripts/jquery-1.4.1.min.js"></script>
<script src="scripts/TableOrder.js" type="text/javascript"></script>
<script src="scripts/ZhCN_Pinyin.min.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript">
        TableOrderOper.Init("t1", 0, {
            OnShow: function (i, trJqObj, _tbodyObj) {
                trJqObj.attr("class", ((i + 1) % 2 == 0 ? "hoverTr" : "leaveTr"));
            }
        });
	TableOrderOper.SetOrder("num", 0, {DataType: "int"});
	TableOrderOper.SetOrder("areaname", 1, {DataType: "string"});
	TableOrderOper.SetOrder("facname", 2, {DataType: "string"});
	TableOrderOper.SetOrder("xhname", 3, {DataType: "string"});	
	TableOrderOper.SetOrder("fzsj", 4, {DataType: "date"});		
</script>
<script>
function ExportToExcel() 
 	{ 
     	if(navigator.userAgent.indexOf("MSIE")<0){  
       alert('请用ie浏览器进行表格导出');  
       return ;  
	   }  
	
	   var curTbl = document.getElementById("t1");
	   var oXL = null;   
	   try {  
	       oXL = GetObject("", "Excel.Application");  
	   }  
	   catch (E) {  
	       try {  
	           oXL = new ActiveXObject("Excel.Application");  
	       }  
	       catch (E2) {  
	           alert("请确认Excel是否安装\n 如果安装，请设置：\n工具=>Internet选项=>安全=>自定义级别=>对未标记可安全执行脚本的ActiveX控件初始化并执行=>启用");  
	           return;  
	       }  
	   }  
	 
	   //创建AX对象excel   
	   var oWB = oXL.Workbooks.Add();   
	    //获取workbook对象   
	   var oSheet = oWB.ActiveSheet;   
	          
	   
	  //定义列宽  
	   oSheet.Columns('A:A').ColumnWidth = 6;
	   oSheet.Columns('B:B').ColumnWidth = 10;
	   oSheet.Columns('C:C').ColumnWidth = 18;
	   oSheet.Columns('D:D').ColumnWidth = 35;
	   oSheet.Columns('E:E').ColumnWidth = 18;
	 
	   var sel = document.body.createTextRange(); //激活当前sheet   
	   sel.moveToElementText(curTbl); //把表格中的内容移到TextRange中  
	   //sel.select(); //全选TextRange中内容   
	   sel.execCommand("Copy"); //复制TextRange中内容   
	   oSheet.Paste(); //粘贴到活动的EXCEL中   
	   oXL.Visible = true; //设置excel可见属性  
	      
	   oSheet.Application.Quit();  //结束当前进程  
	 
	   window.opener=null;  
	   //window.close();//关闭当前窗口  
      
	}  
</script>
</body>
</html>
