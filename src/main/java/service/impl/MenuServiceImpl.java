package service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import service.MenuService;
import dao.MenuDao;
import entity.Menus;

@Service("menuService")
@Transactional
public class MenuServiceImpl implements MenuService {

	 
	private MenuDao menuDao;
 
    @Resource(name="menuDao")
	public void setMenuDao(MenuDao menuDao) {
		this.menuDao = menuDao;
	}

 

    @Transactional
	public Map getMenu(String userId) {
		 
		
		Map<String ,String> menuMap= new LinkedHashMap<String,String>();
		
		List<Menus> list=  menuDao.getMenu(userId);
		
	    for(Menus m:list){
          
    		menuMap.put(m.getMenuAbbreviation(), m.getMenuName());
    		
    	}
		
		return menuMap;
	}
	
	

}
