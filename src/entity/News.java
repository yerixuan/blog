package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class News {

	
	private String id ;
	
	private String title ;// 新闻标题
	 
	private String html ; // 新闻页面代码
	
	private String pageAddress; // 新闻网页地址
	
	
	private String date ; // 保存时间


	
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getHtml() {
		return html;
	}


	public void setHtml(String html) {
		this.html = html;
	}


	public String getPageAddress() {
		return pageAddress;
	}


	public void setPageAddress(String pageAddress) {
		this.pageAddress = pageAddress;
	}


	public String getDate() {
		return date;
	}


	public void setDate(String date) {
		this.date = date;
	}
	
	
	
	
}
