package dao;

 
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import entity.Menus;
import entity.User_Menu;

@Repository("menuDao")
public class MenuDao {

    SessionFactory sessionFactory;
	
    @Resource(name="sessionFactory")
	public void setSessionFactory(SessionFactory sessionFactory) 
    {
		this.sessionFactory = sessionFactory;
	}
    
    
    public  List  getMenu(String userId){
    	
        
    	Session session = sessionFactory.getCurrentSession();
    	String hql ="select menuId from User_Menu where userId='"+userId+"'";
    	
    	 Query query =session.createQuery(hql);
    	 List<String> list = query.list();
    
 
    	 String menuHql="from Menus where id in (:ids)";
    	 query = session.createQuery(menuHql);
    	 query.setParameterList("ids", list);
    	  
    	
    	List<Menus>menulist= query.list();
   
   
    	return menulist;
    }
    
	
}
