<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link type="text/css" rel="stylesheet" href="css/observation_Instrument.css"/>
		<title>观测设备</title>
	</head>
	<body>
		<div id="introduce">
			<h1></br>ONSET仪器介绍</h1>
			</br>
			<li>
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbspOptical and NIR Solar Eruption Trancer(ONSET)望远镜由四个镜筒组成，采用真空镜筒，尽量减少一起的散射光，并防止周围气流的干扰。观测由计算机自动控制进行，可准同时地采集三个波段处的全日面相或视场为10角分的局部像。<br/>
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbspONSET仪器参数如下：<br/>
				1）10830镜有效口径：275毫米，太阳像直径24毫米；工作波段：10830±4.0A，采用VersArray CCD，1340×1300，像元 20.0μm<br/>
				2）Hα镜有效口径：275毫米，太阳像直径24毫米；工作波段：6563±2.5A，PIXIS 2048BRCCD，2048×2048pixel，像元13.5μm<br/>
				3）白光镜有效口径：200毫米,太阳像直径24毫米；工作波段：3600±15A，4250±15A，采用PCO.4000CCD，4008×2672pixel，像元9μm<br/>
				4）光电导航镜有效口径：140毫米<br/><br/>
				ONSET光电路图如下：<br/><br/>
			</li>
			<div id="pic1"><img src="pic\observation_Instrument.jpg"></div>
		</div>		
	</body>
</html>		