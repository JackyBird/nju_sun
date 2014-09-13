<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link type="text/css" rel="stylesheet" href="css/operating_Guide.css"/>
		<title>本站使用指南</title>
	</head>
	<body>
		<div id="introduce">
			<h1></br>光学和近红外太阳爆发探测仪-ONSET</h1>
			</br>
			<li>
				一、本网站是南京大学太阳数据处理中心为ONSET太阳数据观测站建立的数据库数据处理及共享查询系统。<br/>
				二、如想使用本网站，请先正确注册成为本网站合法用户，每次登陆后可以按照菜单提示，查询有关数据和应用软件。<br/>
				三、查询系统中列出的数据为共享数据，提供给研究者下载，为避免有人恶意下载，我们将做一定的限制。<br/>
				四、如有研究者需要某些特殊时段的数据，可以向网站管理员用Email提出申请，中心审核后，若同意将用Email方式予以回复，并通知如何下载数据。<br/>
				五、本站提供下载的数据为FITS或JPG格式。<br/><br/>
			</li>
			<div id="pic1"><img src="pic\main_pic1.jpg">
				<li id="pic-describe">位于云南省澄江县抚仙湖畔的ONSET观测站</li>
			</div>
			<div id="pic2"><img src="pic\main_pic2.jpg">
				<li id="pic-describe">工作中的ONSET望远镜</li>
			</div>	
		</div>		
	</body>
</html>					