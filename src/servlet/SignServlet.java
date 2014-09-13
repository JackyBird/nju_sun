package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import userDao.UserDao;
import userDto.UserBean;

public class SignServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public SignServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    This is ");
		out.print(this.getClass());
		out.println(", using the GET method");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		UserDao userDao = new UserDao();
		UserBean userBean = new UserBean();
		
		String username = request.getParameter("userName");
		String loginname = request.getParameter("loginname");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String method = request.getParameter("method");
		String vercode = request.getParameter("vercode");
		
		userBean.setUsername(username);
		userBean.setLoginname(loginname);
		userBean.setPassword(password);
		userBean.setEmail(email);
		
		PrintWriter out = response.getWriter();
		if(method.equals("sign")){
			int flag = userDao.Sign_in(userBean);
			
			if(flag==1){
				response.sendRedirect("success.html");
			}else{
				response.sendRedirect("false.html");
			}
		}else if(method.equals("checkUser")){
			int result = 0;
			result = userDao.checkrepeat(userBean,"userName");
			out.print(result);
		}else if(method.equals("checkEmail")){
			int result = 0;
			result = userDao.checkrepeat(userBean,"email");
			out.print(result);
		}else if(method.equals("checkLogin")){
			int result = 0;
			result = userDao.checkrepeat(userBean,"loginName");
			out.print(result);
		}else if(method.equals("checkCode")){
			int result = 0;
			HttpSession session=request.getSession();
			String rand = (String)session.getAttribute("rand");
			if(vercode.equalsIgnoreCase(rand)){
				result = 0;
			}else{
				result = 1;
			}
			System.out.print(result);
			out.print(result);
		}
//		else if(method.equals("checkUser")){
//			int result = 0;
//			result = userDao.checkrepeat(userBean,"userName");
//			out.print(result);
//		}
		
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
