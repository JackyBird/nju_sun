package userDao;

/*
 * @(#)ListFits.java   $Revision: 1.4 $ $Date: 2004-01-12 13:13:23 $
 *
 * Copyright (C) 1999 European Southern Observatory 
 * License:  GNU General Public License version 2 or later
 */

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ListIterator;
import java.util.StringTokenizer;

import org.eso.fits.FitsException;
import org.eso.fits.FitsFile;
import org.eso.fits.FitsHDUnit;
import org.eso.fits.FitsHeader;
import org.eso.fits.FitsKeyword;

import data.DataAccessService;

import util.GUID;

/**
 * ListFits class provides a static main method for listing a set of FITS
 * keywords in FITS files.
 * 
 * @version $Revision: 1.4 $ $Date: 2004-01-12 13:13:23 $
 * @author P.Grosbol, ESO, <pgrosbol@eso.org>
 */
public class FitsDao {
	DataAccessService das = new DataAccessService();

	public FitsDao() {
		das.setJdbcDriver("dm.jdbc.driver.DmDriver");
		das.setConStr("jdbc:dm://127.0.0.1:12345/dqmis");
		das.setUserName("SYSDBA");
		das.setPassWord("SYSDBA");
	}

	public String getResult(String path) {// /path="E://fits//"
		String argv[];
		String result = "没有fits文件";
		// get list of files
		File filess = new File(path);

		argv = filess.list();
		// go through files one by one
		for (int i = 0; i < argv.length; i++) {
			if(argv[i].lastIndexOf('.')>-1 && argv[i].substring(argv[i].lastIndexOf('.'),argv[i].length()).equals(".fits")){
				ResultSet rs = null;
				int nofiles = 0;
				int nokwords = 0;
				long time = System.currentTimeMillis();
				GUID getId = new GUID();
				String id = getId.newGUID();
				String name = path + argv[i];
				double BITPIX = 0;
				double DATE = 0;
				// ///查找是否有该文件
				String selSql = "select * from  dq_app.act_Sun_Pic where file_name_='"
						+ name + "'";
				rs = das.executeQuery(selSql);
				try {
					if (rs.next()) {
						result = "解析成功";
					} else {
						// //插入数据库ID_,REV_,FILE_NAME_
						String sql = "INSERT INTO dq_app.act_Sun_Pic(ID_,REV_,FILE_NAME_,BITPIX,DATE)values('"
								+ id
								+ "',dq_sys.dispindex.nextval,'"
								+ name
								+ "','"
								+ BITPIX + "','" + DATE + "')";
						// System.out.print(sql);
						das.executeNonQuery(sql);
	
						File file = new File(name);
						// if directory read all files in it
						if (!FitsFile.isFitsFile(name)) {
							result = "解析失败";
							continue;
						}
						FitsFile ffile = null; // open FITS file
						try {
							ffile = new FitsFile(name);
						} catch (Exception e) {
							result = "解析失败";
							continue;
						}
	
						nofiles++; // get prime FITS header
						int noHDU = ffile.getNoHDUnits();
						FitsHDUnit hdu = ffile.getHDUnit(0);
						FitsHeader hdr = hdu.getHeader();
						nokwords += hdr.getNoKeywords();
						ListIterator itr = hdr.getKeywords();
						while (itr.hasNext()) {
							FitsKeyword kw = (FitsKeyword) itr.next();
							//System.out.println(kw.getName() + "-----" + kw.getReal());
							String keyName = kw.getName();
							String keyValue = "";
							switch (kw.getType()) {
							    case FitsKeyword.COMMENT:
							    	keyValue = kw.getComment();
								break;
							    case FitsKeyword.STRING:
							    	keyValue =  kw.getString();
								break;
							    case FitsKeyword.BOOLEAN:
							    	keyValue = String.valueOf(kw.getBool());
								break;
							    case FitsKeyword.INTEGER:
							    	keyValue = String.valueOf(kw.getInt());
								break;
							    case FitsKeyword.REAL:
							    	keyValue = String.valueOf(kw.getReal());
								break;
							    case FitsKeyword.DATE:
							    	keyValue = kw.getString().replace("T"," ");
								break;
							    default:
							}
							// //更新字段
							if (keyName.equals("BITPIX")) {
								sql = "update DQ_APP.act_Sun_Pic set BITPIX='"
										+ keyValue + "' where id_='" + id + "'";
								das.executeNonQuery(sql);
							}
							if (keyName.equals("DATE")) {
								sql = "update DQ_APP.act_Sun_Pic set DATE='"
										+ keyValue + "' where id_='" + id + "'";
								das.executeNonQuery(sql);
							}
							if (keyName.equals("OBJECT")) {
								sql = "update DQ_APP.act_Sun_Pic set OBJ='"
										+ keyValue + "' where id_='" + id + "'";
								das.executeNonQuery(sql);
							}
							if (keyName.equals("WAVELNTH")) {
								sql = "update DQ_APP.act_Sun_Pic set WAVELNTH='"
										+ keyValue + "' where id_='" + id + "'";
								das.executeNonQuery(sql);
							}
						}
						if (0 < nofiles) {
							float dtime = (float) (0.001 * (System.currentTimeMillis() - time));
							float dtf = dtime / ((float) nofiles);
							float dtk = ((float) nokwords) / dtime;//
							System.out.println(argv[i] + "  Time: " + dtf
									+ " S/file, Rate: " + dtk + " kw/S, Keywords: "
									+ nokwords);
						}
						result = "解析成功";
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					result = "解析失败";
				}
			}
		}

		return result;
	}
}