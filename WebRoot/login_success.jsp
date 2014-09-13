<%@ page language="java" contentType="text/html; charset=UTF-8" 

 pageEncoding="UTF-8"%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 

<html> 

 <head> 

  <title>My JSP 'login_failure.jsp' starting page</title> 

  <meta http-equiv="content-type" content="text/html; 

charset=UTF-8"> 

  <meta http-equiv="pragma" content="no-cache"> 

  <meta http-equiv="cache-control" content="no-cache"> 

  <meta http-equiv="expires" content="0"> 

  <meta http-equiv="keywords" 

content="keyword1,keyword2,keyword3"> 

  <meta http-equiv="description" content="This is my page"> 

  <!-- 

 <link rel="stylesheet" type="text/css" href="styles.css"> 

 --> 

 </head>   <body> 

  <% 

   String username = (String)session.getAttribute ( "username" ); 

  %> 

  <div align=center> 

	<%=username%> 

   欢迎您，登录成功！ 

  </div> 

 </body> 

</html>
<script type="text/javascript">

function jumurl(){
window.parent.location.href="home_Page.jsp"; 

}

setTimeout(jumurl,2000); 
</script>