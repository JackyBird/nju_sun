package util;
/*
 * @(#)ListFits.java   $Revision: 1.4 $ $Date: 2004-01-12 13:13:23 $
 *
 * Copyright (C) 1999 European Southern Observatory 
 * License:  GNU General Public License version 2 or later
 */

import java.io.File;
import java.io.IOException;
import java.util.ListIterator;
import java.util.StringTokenizer;

import org.eso.fits.FitsException;
import org.eso.fits.FitsFile;
import org.eso.fits.FitsHDUnit;
import org.eso.fits.FitsHeader;
import org.eso.fits.FitsKeyword;

/**
 * ListFits class provides a static main method for listing a set of FITS
 * keywords in FITS files.
 * 
 * @version $Revision: 1.4 $ $Date: 2004-01-12 13:13:23 $
 * @author P.Grosbol, ESO, <pgrosbol@eso.org>
 */
public class ListFits {

	public String getFits(String url){
		String fitStr = "";
			
		int nofiles = 0;
		int nokwords = 0;
		long time = System.currentTimeMillis();
	
		String name = url;
		File file = new File(name);
		// if directory read all files in it
		if (!FitsFile.isFitsFile(name))
				fitStr = "";
		FitsFile ffile = null; // open FITS file
		try {
			ffile = new FitsFile(name);
		} catch (Exception e) {
			fitStr = "";
		}

		nofiles++; // get prime FITS header
		int noHDU = ffile.getNoHDUnits();
		FitsHDUnit hdu = ffile.getHDUnit(0);
		FitsHeader hdr = hdu.getHeader();
		nokwords += hdr.getNoKeywords();
		ListIterator itr = hdr.getKeywords();
		while (itr.hasNext()) {
			FitsKeyword kw = (FitsKeyword) itr.next();
			
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
			fitStr = fitStr + keyName+"##"+keyValue+"&nbsp;@@";
			//System.out.println(keyName + "-----" + keyValue);
		}
		if (0 < nofiles) {
			float dtime = (float) (0.001 * (System.currentTimeMillis() - time));
			float dtf = dtime / ((float) nofiles);
			float dtk = ((float) nokwords) / dtime;//ÿ���ȡ����keyword
			String temp = url+"  Time: " + dtf + " S/file, Rate: " + dtk
					+ " kw/S, Keywords: " + nokwords;
			fitStr = fitStr + temp;
		}
		//System.out.println(fitStr);
		return fitStr;
	}
	
	
	
	
	/**
	 * Static main method for listing keywords of a set of FITS files.
	 * 
	 * @param argv
	 *            First argument is a list of FITS files or directories, second
	 *            argument is a comma separated list of FITS keywords to be
	 *            listed.
	 */
	public static void main(String[] argv) {
		// get list of files
		File filess = new File("E:\\fits\\");

		argv = filess.list();
		// go through files one by one
		for(int i=0;i<argv.length;i++){
			int nofiles = 0;
			int nokwords = 0;
			long time = System.currentTimeMillis();
			System.out.println(argv[i]+"===================");
			String name = "E:\\fits\\"+argv[i];
			File file = new File(name);
			// if directory read all files in it
			if (!FitsFile.isFitsFile(name))
					continue;
			FitsFile ffile = null; // open FITS file
			try {
				ffile = new FitsFile(name);
			} catch (Exception e) {
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
				System.out.println(kw.getName() + "-----" + kw.getReal());
			}
			if (0 < nofiles) {
				float dtime = (float) (0.001 * (System.currentTimeMillis() - time));
				float dtf = dtime / ((float) nofiles);
				float dtk = ((float) nokwords) / dtime;//ÿ���ȡ����keyword
				System.out.println(argv[i]+"  Time: " + dtf + " S/file, Rate: " + dtk
						+ " kw/S, Keywords: " + nokwords);
			}
		}
		System.exit(0);
	}
}