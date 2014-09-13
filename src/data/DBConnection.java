package data;

import java.sql.*;
import java.util.*;
import java.util.Date;

public class DBConnection {

	/**
	 * @param args
	 * 
	 */
	
	Connection _con = null;
	PreparedStatement _pst = null;
	
	public Connection getConnection(String jdbcDriver,String conStr,String userName,String passWord){
		Connection result=null;
		try {
			Class.forName(jdbcDriver);
			//String url = "jdbc:oracle:thin:@172.23.67.248:1521:o2000";
			//String url = "jdbc:oracle:thin:@127.0.0.1:1521:NT3000";
			//String url = "jdbc:oracle:thin:@172.23.206.180:1521:o2000";
			//String url = "jdbc:oracle:thin:@172.24.79.70:1521:o20001";
			_con = DriverManager.getConnection(conStr,userName,passWord);
			result = _con;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	public boolean closeCon(Connection con,PreparedStatement pst,ResultSet rs){
		boolean result=false;
		try {
			rs.close();
			result=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			result=false;
			e.printStackTrace();
		}
		try {
			pst.close();
			result=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			result=false;
			e.printStackTrace();
		}
		try {
			con.close();
			result=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			result=false;
			e.printStackTrace();
		}
		return result;
	}
	public boolean closeCon(Connection con,PreparedStatement pst){
		boolean result=false;
		
		try {
			pst.close();
			result=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			result=false;
			e.printStackTrace();
		}
		try {
			con.close();
			result=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			result=false;
			e.printStackTrace();
		}
		
		return result;
		
	}
	public boolean closeCon(Connection con){
		boolean result=false;
		try {
			con.close();
			result=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			result=false;
			e.printStackTrace();
		}
		return result;
	}	

}
