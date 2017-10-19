package util;

import java.io.InputStream;

/**
 * 
 * 上传视频 线程类
 * @author yezi
 *
 */
public class UploadMediaThread extends Thread {
	
  private	String url;
  private	int port;
  private	String userName;
  private	String password;
  private	String path;
  private	String fileName;
  private	InputStream input;
  private String userid;
  
  boolean success=true;
  
 

	public UploadMediaThread(){}
	
	public UploadMediaThread(String url,int port ,String userName,String password,String fileName,String path,InputStream input,String userid){
		this.url=url;
		this.port=port;
		this.userName=userName;
		this.password=password;
		this.fileName=fileName;
		this.path=path;
		this.input=input;
        this.userid=userid;
	}

	@Override
	public void run() {
	  
	 
		 
		 try{
		//这里处理 上传视频文件
		boolean success= FTPService.saveMedia(url, port, userName, password, path, fileName, input);
		 super.run(); 
		 }catch(Exception e){
			 
			 success=false;
			 
		     
		 }
		 String noticeid=""; 
	  
		  if(success==false){
			 
			// 插入一条 公告  
			   noticeid= SendUploadMediaInfo.insertNotice("文件上传失败", fileName+" 文件上传失败，请重新上传", "系统发布", "");
			
			 
		 }else{
			 // 上传成功 告知用户 成功了
 		 	  noticeid= SendUploadMediaInfo.insertNotice("文件上传成功", fileName+" 文件上传成功！", "系统发布", "");
			 
		     } 
		  
		  // 将公告id 写到用户表中 
		   SendUploadMediaInfo.updateUserNoticeId(userid, noticeid);
	  
	}
	
  
		
	}
	
	

 
