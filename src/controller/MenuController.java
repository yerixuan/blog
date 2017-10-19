package controller;

import javax.annotation.Resource;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import service.MenuService;
import util.AjaxObject;

@Controller
public class MenuController {

	
	private MenuService menuService;

	
	@Resource(name="menuService")
	public void setMenuService(MenuService menuService) {
		this.menuService = menuService;
	}





	@RequestMapping(value="/Menus",method=RequestMethod.POST)
	@ResponseBody
    public AjaxObject    getMenu(String userId,Model model){
    	
    	  
    	  
    	 return  new AjaxObject("200","获取菜单成功",menuService.getMenu(userId));    
    
	}
    
	
}
