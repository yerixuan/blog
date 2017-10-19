package controller;
 
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import util.AjaxObject;
import util.FileService;
import util.UploadMediaThread;
 
/**
 * 
 * 通用控制类  如图片上传
 * @author yezi
 *
 */

@Controller
@RequestMapping(value="/common")
public class CommonController {

	
	
	
	@RequestMapping(value = "/ajax/editor_image_upload", method = RequestMethod.POST)
	@ResponseBody
	public AjaxObject editorImageUpload(HttpServletRequest request,  HttpServletResponse response,Model model,String serverAddress,String userid,String dir ) {
		
	 
		  String fileuri ="";
		
		 MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		
		PrintWriter out=null;
		try {
			  out = response.getWriter();
		} catch (IOException e1) {
			 
			e1.printStackTrace();
		}
		
		
		 String fileUri=null;
		try {
		  	Iterator<MultipartFile> itr = multipartRequest.getFileMap().values().iterator();
		 	MultipartFile mf = itr.next();
		 	
			 
			
			 String tomcatAddress=request.getSession().getServletContext().getRealPath("");
		 
			String projectName=request.getContextPath()+"/";
			 
			
			
			//图片存储位置
			if(dir.equals("image")){
			   fileuri = projectName+FileService.saveEditorImage(mf, mf.getOriginalFilename(),tomcatAddress);
	
			}else if(dir.equals("media")){
				
				// 视频的话 应该采用 ftp 方式来传输 文件
				
 
				 SimpleDateFormat sdf= new SimpleDateFormat("yyyyMMddHHmmss");
				 String date =sdf.format(new Date());
				 String newFileName=UUID.randomUUID().toString().replace("-", "")+date+mf.getOriginalFilename();
				 
				 // ftp 服务器的一些配置

				 //文件保存 物理路径
				 String path=tomcatAddress+"/media_file/";
				
				 String file_url = serverAddress+"media_file/";// 应该是 服务器
				 				 
				 String url="127.0.0.1" ;//request.getLocalAddr(); // ftp 服务器地址
				 
				 String userName="yezi";
				 String password="yezi";
				 
				 // 启动线程  后台处理上传视频
				  
				  UploadMediaThread upload= new UploadMediaThread(url,21,userName,password,newFileName,path,mf.getInputStream(),userid);
				  upload.start();
				 //文件访问地址
				 fileuri=serverAddress+"media_file/"+newFileName;
			
			}
		} catch (Exception e) {
			e.printStackTrace();
			 
		}
          Map<String ,Object> map=new HashMap<String,Object>();
          map.put("url",fileuri );
       
 
         
         JSONObject obj = new JSONObject();
         obj.put("error", 0);
         obj.put("url", fileuri);
         
         out.println(obj.toJSONString());
      
         model.addAttribute("flag", 1);
         model.addAttribute("url", fileUri);
        
	 	 return  null;   
 	
	}
 
	private String getError(String message) {
		JSONObject obj = new JSONObject();
		obj.put("error", 1);
		obj.put("message", message);
		return obj.toJSONString();
	}
	
	
	
	
	@RequestMapping(value="file_manager_json",method=RequestMethod.GET)
	public String uploadVideo(){
		
		
		return "main/file_manager_json";
	}
	
	
	
	
	 
	 
	
	
}
