package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;


/*
 * 菜单栏 表
 * @author: yezi 
 */
@Entity
public class Menus {

	private String id ;
	private String menuAbbreviation; //菜单名缩写
	private String menuName ; // 菜单名
	private String createName;
	private String date;
	
	private int level; // 对应权限等级  0 :普通用户  1 :普通管理员  2 :高级管理员
	
	
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMenuAbbreviation() {
		return menuAbbreviation;
	}
	public void setMenuAbbreviation(String menuAbbreviation) {
		this.menuAbbreviation = menuAbbreviation;
	}
	public String getMenuName() {
		return menuName;
	}
	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}
	public String getCreateName() {
		return createName;
	}
	public void setCreateName(String createName) {
		this.createName = createName;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	
	
	
	
	
}
