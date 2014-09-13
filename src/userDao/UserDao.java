package userDao;

import java.sql.ResultSet;
import java.sql.SQLException;

import userDto.UserBean;
import util.GUID;
import data.DataAccessService;

public class UserDao {
	DataAccessService das = new DataAccessService();
	public UserDao(){
		das.setJdbcDriver("dm.jdbc.driver.DmDriver");
		das.setConStr("jdbc:dm://127.0.0.1:12345/dqmis");
		das.setUserName("SYSDBA");
		das.setPassWord("SYSDBA");
	}
	
	public int Sign_in(UserBean user){
		GUID getId = new GUID();
		int flag = 1;
		String username = user.getUsername();
		String loginname = user.getLoginname();
		String password = user.getPassword();
		String email = user.getEmail();
		String id = getId.newGUID();
		String sql = "insert into dq_sys.act_id_user(id_,rev_,system_name_,login_name_,email_,pwd_)values('"+id+"',dq_sys.dispindex.nextval,'"+username+"','"+loginname+"','"+email+"','"+password+"')";
		das.executeNonQuery(sql);
		return flag;
	}
	
	
	
	//判断登录名和邮箱是否冲突_____,再写一个方法，就像下面的一样
	public String checkUser(UserBean user)
	{
		String username = "";
		ResultSet rs = null;
		int flag = 1;
		String loginname = user.getLoginname();
		String password = user.getPassword();
		String sql = "select * from dq_sys.act_id_user where login_name_='"+loginname+"' and pwd_='"+password+"'";
		rs = das.executeQuery(sql);
		try {
			if(rs.next()){
				username = rs.getString("system_name_");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			username="";
		}
		
		return username;
	}
	
	public int checkrepeat(UserBean user,String type)
	{
		String username = "";
		ResultSet rs = null;
		int flag = 0;
		String loginname = user.getLoginname();
		String email = user.getEmail();
		username = user.getUsername();
		if(type.equals("userName")){
			String sqluser = "select * from dq_sys.act_id_user where system_name_='"+username+"'";
			System.out.print(sqluser);
			rs = das.executeQuery(sqluser);
			try {
				if(rs.next()){
					
					flag = 4;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				flag = 3;
			}
			System.out.println(flag);
		}
		if(type.equals("loginName")){
			String sqllogin = "select * from dq_sys.act_id_user where login_name_='"+loginname+"'";
			
			rs = das.executeQuery(sqllogin);
			try {
				if(rs.next()){
					flag = 1;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				flag = 3;
			}
			
		}
		if(type.equals("email")){
			String sqlemail = "select * from dq_sys.act_id_user where email_='"+email+"'";
			//System.out.print(sqlemail);
			rs = das.executeQuery(sqlemail);
			try {
				if(rs.next()){
					//System.out.print("邮箱重复");
					flag = 2;
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				flag = 3;
			}
		}
		
		return flag;
	}
}
