package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TestController {
	
	 
//	@RequestMapping(value="/login", method = RequestMethod.GET)
//	public String test(){
//		
//		System.out.println("浙江鳄梨都是flak家");
//	 
//		return "login/login";
//	}
//	
//	@RequestMapping(value="/", method = RequestMethod.GET)
//	public String test1(){
//		
//	 System.out.println("sdadffdsaafsd");
//		return "login/login";
//	}
	
	@RequestMapping(value="/test")
	public String test2(){
		
		System.out.println("test");
		return "main/manage";
	}
	

}
