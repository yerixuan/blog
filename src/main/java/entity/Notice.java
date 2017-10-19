package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;

/*
 * 
 * ������Ϣ��
 * @author�� yezi
 */
@Entity
public class Notice {
	
	
	private String id ;
	
	
	private String title; //�������
	
	private String content; // ��������
	
	private String PublisherId;// ������id
	
	private String publisherName;//������
	
	private String date;// ����ʱ�� �����ݶ�Ϊ String ����

	
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
