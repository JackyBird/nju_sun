package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import userDao.FileDao;
import java.io.File;
import java.util.*;

public class ZipServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public ZipServlet() {
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

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();


		String ids = request.getParameter("ids");///获取文件id
		//System.out.print(ids);
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
		try{
			fd.zip(filepath+".zip",filepath);
			fd.delDir(folder);
			out.print(filename+".zip");
		}
		catch(Exception e){
			out.print("1");
		}
		
			
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
