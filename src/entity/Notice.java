package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;

/*
 * 
 * 公告信息表
 * @author： yezi
 */
@Entity
public class Notice {
	
	
	private String id ;
	
	
	private String title; //公告标题
	
	private String content; // 公告内容
	
	private String PublisherId;// 发布者id
	
	private String publisherName;//发布者
	
	private String date;// 发布时间 类型暂定为 String 类型

	
	public Notice(){}
	
	public Notice(String title ,String content ,String  PublisherId,String publisherName,String date){
		
		this.title=title;
		this.PublisherId=PublisherId;
		this.content=content;
		this.date=date;
		this.publisherName=publisherName;
		
	}
	
	
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPublisherId() {
		return PublisherId;
	}

	public void setPublisherId(String publisherId) {
		PublisherId = publisherId;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPublisherName() {
		return publisherName;
	}

	public void setPublisherName(String publisherName) {
		this.publisherName = publisherName;
	}

	
	
	
	
}
