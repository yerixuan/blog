package util;

import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;

/**
 * 将来自页面的数据 用ftp 上传到 服务器端 的ftp服务器上
 * @author yezi
 *
 */
public class FTPService {
	
	
	
	public static boolean saveMedia(
			String url,// FTP服务器hostname  
            int port,// FTP服务器端口  
            String username, // FTP登录账号  
            String password, // FTP登录密码  
            String path, // FTP服务器保存目录  
            String filename, // 上传到FTP服务器上的文件名  
            InputStream input // 输入流 
			){
		
		String uri="";
		
		System.out.println("path=="+path);
		
		 boolean success = false;  
	        FTPClient ftp = new FTPClient();  
	        ftp.setControlEncoding("utf-8");  
	        try {  
	            int reply;  
	            ftp.connect(url, port);// 连接FTP服务器  
	            // 如果采用默认端口，可以使用ftp.connect(url)的方式直接连接FTP服务器  
	            ftp.login(username, password);// 登录  
	            reply = ftp.getReplyCode();  
	            if (!FTPReply.isPositiveCompletion(reply)) {  
	                ftp.disconnect();  
	                return false;  
	            }  
	            ftp.setFileType(FTPClient.BINARY_FILE_TYPE);  
	            ftp.makeDirectory(path);  
	            ftp.changeWorkingDirectory(path);  
	            ftp.storeFile(filename, input);  
	            input.close();  
	            ftp.logout();  
	            success = true;  
	        } catch (IOException e) {  
	            e.printStackTrace();  
	        } finally {  
	            if (ftp.isConnected()) {  
	                try {  
	                    ftp.disconnect();  
	                } catch (IOException ioe) {  
	                }  
	            }  
	        }  
	     
		
		
		return true;
	}
	
	
	
	
	
	

}
