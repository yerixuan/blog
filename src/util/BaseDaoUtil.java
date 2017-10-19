package util;

import java.sql.DriverManager;
import java.sql.SQLException;

import com.mysql.jdbc.Connection;

/**
 * 操作 jdbc 工具类
 * @author yezi
 *
 */
public class BaseDaoUtil {
	
	private static String driver = "com.mysql.jdbc.Driver";

	private static String jdbcUrl = "jdbc:mysql://localhost:3306/cscw";

	private static String userName = "root";
	private  static String password = "root";
	private static Connection con;
	
	
	// 获得数据库连接
	public static Connection getConnection(){
		 
        try {
        	   Class.forName(driver); //classLoader,加载对应驱动
               con = (Connection) DriverManager.getConnection(jdbcUrl, userName, password);
        	
		} catch (Exception e) {
			 
			e.printStackTrace();
		}  
	
        return con;
	}
	

}
