package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;


/*
 * 
 * �û���������ӱ�
 * @author: yezi
 */

@Entity
public class Article {

	
	private String id ;	 
	private String userId;  // ���ӷ�����id
	private String title;// ���±���
	private String classificationId; // ����id �˵�����
	private String html; // ����������ת���� html ������ʽ�洢����
	private String date; // ����ʱ��
	private String type;//����   �������  �����ࣿ��
	private int flag; // ����״̬  1�� ����  0����ֹ 2 �������
	private int accessCount;//������
	private String  updateDate;//���¸���ʱ��
	private String reviewManagerId;//���� �����id	
	private int likeNum; // ������
	
	
	public  Article(){}
	
	public Article (String userid ,String title ,String type ,String html ,String classificationId,String date,int flag){
		
		this.classificationId=classificationId;
		this.html=html;
		this.title=title;
		this.type=type;
		this.userId=userid;
		this.date=date;
		this.flag=flag;
		
		
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

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getClassificationId() {
		return classificationId;
	}

	public void setClassificationId(String classificationId) {
		this.classificationId = classificationId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getAccessCount() {
		return accessCount;
	}

	public void setAccessCount(int accessCount) {
		this.accessCount = accessCount;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	public String getReviewManagerId() {
		return reviewManagerId;
	}

	public void setReviewManagerId(String reviewManagerId) {
		this.reviewManagerId = reviewManagerId;
	}

	public int getLikeNum() {
		return likeNum;
	}

	public void setLikeNum(int likeNum) {
		this.likeNum = likeNum;
	}

 
	
	
	
	
	
	
}
