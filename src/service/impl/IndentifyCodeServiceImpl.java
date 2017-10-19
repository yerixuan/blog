package service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import service.IndentifyCodeService;
import util.CreateIdentifyingCode;
import util.SendIdentifyingCode;
import dao.UserDao;

@Repository("indentifyCodeService")
public class IndentifyCodeServiceImpl  implements IndentifyCodeService{

	
	private UserDao userDao;
	
	
	
    @Resource(name="userDao")
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}




	@Override
	public String sendEmail(String Email) {
		 
		
		if(userDao.isExitUserEmail(Email))
			return null;
		
		
		String code =CreateIdentifyingCode.create();
		 try{
			 
			// 因邮箱被封 暂时发送不出 验证码  
		     SendIdentifyingCode.sendMessage(Email,code);
		 }catch(Exception e){
			 
			 return code;
			 
		 } 
		return code;
		 
		  
	}

}
