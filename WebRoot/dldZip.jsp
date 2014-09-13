<%@page language="java" import="java.util.*,userDao.*,java.io.*" pageEncoding="utf-8"%><%@ include file="BasePage.jsp"%>
<% 
		String ids = request.getParameter("ids");///获取文件id
		
		Calendar calendar = Calendar.getInstance(); 
		String filename = String.valueOf(calendar.getTimeInMillis());//压缩包名:以当前时间命名
		
		FileDao fd = new FileDao();
		String filepath = request.getRealPath("zip\\"+filename);///文件下载路径"zip\\201407201822\\"
		File folder=fd.createDir(filepath);//如果没有则新建文件夹
		
		String fileName = "";
		for(int i=1;i<ids.split(",").length;i++){
			String objId = ids.split(",")[i];
			fd.downloadFile(objId,filepath);
		}
		fd.zip(filepath+".zip",filepath);
		fd.delDir(folder);
		out.print(filename+".zip");
%> 