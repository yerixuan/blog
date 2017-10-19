package controller;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;



import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import service.NoticeService;
import service.UserInfoService;
import service.impl.UserInfoServiceImpl;
import util.AjaxObject;
import util.FileService;
import entity.Notice;

 
/**
 * 
 * 用户基本信息控制类
 * @author yezi
 *
 */


@Controller
public class UserController {
	
	

	Logger log = Logger.getLogger(UserController.class);
	
	
	private UserInfoService userInfoService;
	
	private NoticeService noticeService ;
	
    @Resource(name="userInfoService")
	public void setUserInfoService(UserInfoServiceImpl userInfoService) {
		this.userInfoService = userInfoService;
	}

     
    @Resource(name="noticeService")
	public void setNoticeService(NoticeService noticeService) {
		this.noticeService = noticeService;
	}




	@RequestMapping(value="/checkUserName" ,method=RequestMethod.POST)
	@ResponseBody
	public  AjaxObject checkUserName(String userName  ){
		
		boolean isUserNameUnique= userInfoService.isUserNameUnique(userName);
		
		if(isUserNameUnique)
			return new AjaxObject("200" ,"用户名唯一" ,"false");
		else{
			return new AjaxObject("201","该用户名已存在","true");
		}
		 
	}
	
	
	@RequestMapping(value="/register" ,method=RequestMethod.POST)
	 
	public String register(String email , @RequestParam("file") MultipartFile file,String password,String userName , String phone,String schoolName, String description,String department ,HttpServletRequest request,Model model){
		
	 
		 //服务器物理地址
		String tomcatAddress=request.getSession().getServletContext().getRealPath("");
		 
		//项目名
		//String projectName=request.getContextPath()+"/";
    
		//新文件名
	//	String new_fileName=UUID.randomUUID()+file.getOriginalFilename();
		
		//图片相对地址
		String pictureurl="/cs";  //projectName+"prcture/"+new_fileName;
		 
		
		
		  try {
			
			// FileUtils.copyInputStreamToFile(file.getInputStream(), new File(tomcatAddress+"/picture/", new_fileName));
		
			  
			  pictureurl+=  FileService.saveEditorImage(file, file.getOriginalFilename(), tomcatAddress);
			  
			  
			  
		  } catch (Exception e) {
			
			e.printStackTrace();
		} 
	
		boolean saveUser =userInfoService.register(email, password,userName, phone, schoolName, description,department,pictureurl);
		
		Notice notice = noticeService.getNoticeByFlag("注册成功");
 
		if(saveUser) {
			
			model.addAttribute("flag", notice.getContent());
			return  "login/login"; //new AjaxObject("200" ,"保存成功" ,notice);
		}else {
			
			model.addAttribute("flag", "注册失败，请重试");
			return  "login/login";//new AjaxObject("201" ,"保存失败" ,"");
		}
		 
	}
	
	
	
	@RequestMapping(value={"/login","/logout" ,"/" ,""} ,method=RequestMethod.GET)
	public String login(){

		log.info(new Date()+"用户登录");
		
		return "login/login";
	}
	
	
	
	//跳到用户查看自己发帖  写贴等页面 
	@RequestMapping(value="/myArticle")
	public String myarticle(String userid,Model model){
		
		
		model.addAttribute("userid", userid);
		
		
		return "Article/myArticle";
	}
	
	
//	@RequestMapping(value="/testSession" )
//	public String testSession (HttpServletRequest  request,String userid,Model model){
//		
//		 
//		
//	return "main/test";	
//	}
//	
//	
//	
//	@RequestMapping(value="/testSessionid" ,method=RequestMethod.POST)
//	@ResponseBody
//	public String testSeession(String userid,HttpServletRequest request){
//		
//	    HttpSession session =request.getSession();
// 	 
//		
//		return "main/test2";
//	}
	
	
	@RequestMapping(value="/login" ,method=RequestMethod.POST)
	public String login(String email,String password,Model model,HttpServletRequest  request){
     
		String userid=userInfoService.checkLogin(email, password,"0");
	 
		String noticeIds;
	 
		//登录成功
		if(!userid.equals("")){
			
			log.info(new Date()+ "  "+userid+"用户登录成功");
			// 获取公告列表
			noticeIds=userInfoService.getNoticeIds(userid);
			System.out.println("登录成功");
		    model.addAttribute("userId", userid);	
		    model.addAttribute("noticeIds", noticeIds);
	   
		    if(noticeIds!=null)
		    if(!noticeIds.equals(""))
			model.addAttribute("noticeNum", noticeIds.split(",").length);
	    
			return "main/manage";
		}
		
		model.addAttribute("info", "帐号或密码错误，请检查");
		return "login/login";
	}
	
	@RequestMapping(value="/getUserInfo",method=RequestMethod.POST)
	@ResponseBody
	public AjaxObject getUserInfoById(String id){
		
		 
		return new AjaxObject("200","个人信息获取成功" , userInfoService.getUserInfoById(id));
	}
	
	
	
	@RequestMapping(value="/updateInfo" ,method=RequestMethod.POST)
	@ResponseBody
	public AjaxObject updateUserInfo(String id ,String userName ,String phone ,String schoolName ,String department ,String description ){
		
		
		boolean update =userInfoService.updateUser(id, userName, phone, schoolName, department, description);
		
		if(update)
			return new AjaxObject("200" ,"用户信息更新成功" , null);
		
		return new AjaxObject("401" ,"用户信息更新失败" ,null);
		 
	}
	
 
 
	
}
