package userDao;


import java.io.*;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

import org.apache.tools.zip.*;

import data.DBConnection;
import data.DataAccessService;

public class FileDao {
	DataAccessService das = new DataAccessService();
	ResultSet rs = null;
	/**
	 * 创建文件夹
	 * @param path 文件夹
	 */
	public File createDir(String path) {
		File dirFile = null;
		try {
			dirFile = new File(path);
			if (!(dirFile.exists()) && !(dirFile.isDirectory())) {
				dirFile.mkdirs();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dirFile;
	}
	/**
	 * 下载文件
	 * @param clsid 表ID
	 * @param attr  字段名
	 * @param objid  记录ID
	 * @param dlpath 下载路径
	 * @param num 附件序号
	 */
	public String downloadFile(String objid,String dlpath){
		String resulte = "";
		String file="";
		das.setJdbcDriver("dm.jdbc.driver.DmDriver");
		das.setConStr("jdbc:dm://127.0.0.1:12345/dqmis");
		das.setUserName("SYSDBA");
		das.setPassWord("SYSDBA");
		
		return resulte;
	}
	/**
	 * 删除文件
	 * @param path 文件
	 */
	public boolean delFile(String path) throws Exception {
		boolean result = false;
		File file=new File(path); 
		if(file.exists()&&file.isFile()) 
		{
			file.delete();
			result = true;
		}
		return result;
	}
	/**
	 * 删除文件夹和文件
	 * @param folder 文件夹
	 */
	public boolean delDir(File folder) {
		boolean result = false;
		try {
			String childs[] = folder.list();
			if (childs == null || childs.length <= 0) {
				if (folder.delete()) {
					result = true;
				}
			} else {
				for (int i = 0; i < childs.length; i++) {
						String childName = childs[i];
						String childPath = folder.getPath() + File.separator + childName;
						File filePath = new File(childPath);
						if (filePath.exists() && filePath.isFile()) {
								if (filePath.delete()) {
									result = true;
								} else {
									result = false;
									break;
								}
						} else if (filePath.exists() && filePath.isDirectory()) {
								if (delDir(filePath)) {
									result = true;
								} else {
									result = false;
									break;
								}
						}
				}
			}
			folder.delete();
		} catch (Exception e) {
			e.printStackTrace();
			result = false;
		}
		return result;
	}
	/**
	 * 
	 * @param zipFilePath
	 * 打包文件存放路径
	 * @param inputFolderName
	 * 需要打包的文件夹
	 * @throws Exception
	 */
	public String zip(String zipFilePath, String inputFolderName)throws Exception {
		String zipFileName = zipFilePath; // 打包后文件名字
		File zipFile = new File(inputFolderName);
		zip(zipFileName, zipFile);
		return zipFileName;
	}
	private void zip(String zipFileName, File inputFolder) throws Exception {
		FileOutputStream fileOut = new FileOutputStream(zipFileName);
		ZipOutputStream out = new ZipOutputStream(fileOut);
		zip(out, inputFolder, "");
		out.close();
		fileOut.close();
	}
	private void zip(ZipOutputStream out, File inputFolder, String base)throws Exception {
		if (inputFolder.isDirectory()) {
			File[] fl = inputFolder.listFiles();
			out.putNextEntry(new ZipEntry(base + "/"));
			base = base.length() == 0 ? "" : base + "/";
			for (int i = 0; i < fl.length; i++) {
				zip(out, fl[i], base + fl[i].getName());
			}
		} else {
			out.putNextEntry(new ZipEntry(base));
			FileInputStream in = new FileInputStream(inputFolder);
			int b;
		//System.out.println(base);
			while ((b = in.read()) != -1) {
				out.write(b);
			}
			in.close();
		}
	}
}
