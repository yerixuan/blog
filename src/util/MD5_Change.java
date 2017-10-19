package util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import sun.misc.BASE64Encoder;

public class MD5_Change {
	
	Logger log =   LoggerFactory.getLogger(MD5_Change.class);
	private static MessageDigest md5=null;
	/**
	 * 
	 * @param password 原始密码
	 * @return
	 * @throws NoSuchAlgorithmException 
	 * @throws UnsupportedEncodingException 
	 */
	public static String  change(String  password) throws NoSuchAlgorithmException, UnsupportedEncodingException  {
		
		String password_change="";
	   
		System.out.println("源密码 ："+password);
		
		md5=MessageDigest.getInstance("MD5");
        BASE64Encoder base64en = new BASE64Encoder();
            //加密后的字符串
    
		password_change=base64en.encode(md5.digest(password.getBytes("utf-8")));
			
		 System.out.println("新密码 =" +password_change);
	 
		return password_change;
		
	}
	 

	 
	
}
