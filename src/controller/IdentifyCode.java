package controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import service.impl.IndentifyCodeServiceImpl;
import util.AjaxObject;

/**
 * 
 * 验证码控制类
 * @author yezi
 *
 */


@Controller
public class IdentifyCode {
	
	
	private IndentifyCodeServiceImpl indentifyCodeService;
	
	@Resource(name="indentifyCodeService")
	public void setIndentifyCodeService(
			IndentifyCodeServiceImpl indentifyCodeService) {
		this.indentifyCodeService = indentifyCodeService;
	} 


	@RequestMapping(value="getIndentifyCode" ,method=RequestMethod.POST)
	@ResponseBody
	public AjaxObject getIndentifyCode(String email,Model model){
		
		String code =indentifyCodeService.sendEmail(email);
		
	 	model.addAttribute("code", code);
		
		 
	 	if(code==null){
	 		
	 		return new AjaxObject("200","该邮箱已注册",null);
	 	}
		
	 	
		 return new AjaxObject("200","发送成功",code);
	}

	 

	
	
	

}
