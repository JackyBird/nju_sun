package data;

import java.sql.ResultSet;
import com.sun.rowset.CachedRowSetImpl;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class DataAccessService extends DBConnection {
	
	CachedRowSetImpl rowset = null;
	public String jdbcDriver;
	public String conStr;
	public String userName;
	public String passWord;
	public ResultSet executeQuery(String sql){
		ResultSet rs = null;
		this.getConnection(this.jdbcDriver,this.conStr,this.userName,this.passWord);
		try {
			rowset = new CachedRowSetImpl();
			this._pst=this._con.prepareStatement(sql);
			rs = this._pst.executeQuery();
			//����������ݼ�
			rowset.populate(rs);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		this.closeCon(_con, _pst, rs);
		return rowset;
	}
	
	public int executeNonQuery(String sql){
		int result = 0;
		this.getConnection(this.jdbcDriver,this.conStr,this.userName,this.passWord);
		try {
			this._pst=this._con.prepareStatement(sql);
			result = this._pst.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		this.closeCon(_con, _pst);
		return result;
	}
	
	public static List<Date> findDates(Date dBegin, Date dEnd)
	{
	  	List lDate = new ArrayList();
		lDate.add(dBegin);
		Calendar calBegin = Calendar.getInstance();
		  // ʹ�ø����� Date ���ô� Calendar ��ʱ��
		calBegin.setTime(dBegin);
		Calendar calEnd = Calendar.getInstance();
		  // ʹ�ø����� Date ���ô� Calendar ��ʱ��
		calEnd.setTime(dEnd);
		  // ���Դ������Ƿ���ָ������֮��
		while (dEnd.after(calBegin.getTime()))
		{
		   // ���������Ĺ���Ϊ�����������ֶ���ӻ��ȥָ����ʱ����
		   calBegin.add(Calendar.DAY_OF_MONTH, 1);
		   lDate.add(calBegin.getTime());
		}
		return lDate;
	}

	public String getJdbcDriver() {
		return jdbcDriver;
	}

	public void setJdbcDriver(String jdbcDriver) {
		this.jdbcDriver = jdbcDriver;
	}

	public String getConStr() {
		return conStr;
	}

	public void setConStr(String conStr) {
		this.conStr = conStr;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassWord() {
		return passWord;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
}
