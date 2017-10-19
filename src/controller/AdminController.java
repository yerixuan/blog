package controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import service.UserInfoService;
import service.impl.UserInfoServiceImpl;
import util.AjaxObject;
import util.PageAjaxObject;
import util.Pager;

/**
 * 
 * 处理管理员各种请求操作
 * @author yezi
 *
 */
@Controller
public class AdminController {

	
    private UserInfoService userInfoService;
 
    @Resource(name="userInfoService")
	public void setUserInfoService(UserInfoServiceImpl userInfoService) {
		this.userInfoService = userInfoService;
	}

	
	
	//管理员登录跳转页面
	@RequestMapping(value={"/manager","/logout_manager"})
	public String manager(){
	 
		return "manager/login";
	}
	
	
	//管理员登录验证
	@RequestMapping(value="/manager",method=RequestMethod.POST)
	public String manager(String email ,String password,Model model){
		
		String role="1";
		
		String userid=userInfoService.checkLogin(email, password, role);
		
		if(userid=="" || userid.equals("")){
			
			model.addAttribute("info", "用户名或密码错误，请重新输入！");
			return "manager/login";
			}
		
		model.addAttribute("managerid", userid);
		return "manager/manager";
	}
	
	
	    //系统管理员登录
		@RequestMapping(value={"/admin","/logout_admin"})
		public String admin(){
			
			return "admin/login";
		}
		
		@RequestMapping(value="/admin",method=RequestMethod.POST)
		public String admin_login(String email,String password,Model model){
			
		 
			String userid =userInfoService.checkLogin(email, password, "2");
	 
			//登录失败
			if(userid==null || userid==""){
				
				model.addAttribute("info", "账号或密码错误");
				return "admin/login";
		   	}else{
			
			 model.addAttribute("userid", userid);
			 return "admin/admin";
			 }
		}
		
	
		@RequestMapping(value={"/addManager" ,"/removeManager"} ,method=RequestMethod.POST)
		@ResponseBody
		public PageAjaxObject getUserListByPage(int currentPage ,int pageSize,int role){
			
			// 查询普通 用户
			Pager pager =  new Pager(currentPage ,pageSize);
			
			//起始记录
			int startItem=  (currentPage-1)*pageSize;
		    //总记录数
			int totalCount=userInfoService.getUserTotalCount(role);
			
			int totalPage;
			
		//计算总页数	
		if (totalCount % pageSize == 0) {
			totalPage = totalCount / pageSize;
		} else {
			totalPage = totalCount / pageSize + 1;
		}
			if(totalPage==0)
				totalPage=1;
		    
		    pager.setPageSize(pageSize);
		    pager.setCurrPage(currentPage);
			pager.setStartItem(startItem);
			pager.setTotalCount(totalCount);
			pager.setTotalPage( totalPage);
			
			 
			
			return new PageAjaxObject("200" ,"获取列表成功",currentPage, totalPage,totalCount,userInfoService.getUserList(pager, role));
		} 
	
		
		@RequestMapping(value="/updateUser",method=RequestMethod.POST)
		@ResponseBody
		public AjaxObject updateUserToManager(String userid,int flag){
 	
			 boolean success=userInfoService.updateUserToManager(userid ,flag);
			
			 if(success) 
				  return new AjaxObject("200","升级成功","");
			 
			return new AjaxObject("500" ,"升级失败，请重试","");
			
		}
		
		
		 
		
		
}
