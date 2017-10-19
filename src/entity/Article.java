package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;


/*
 * 
 * 用户发表的帖子表
 * @author: yezi
 */

@Entity
public class Article {

	
	private String id ;	 
	private String userId;  // 帖子发表者id
	private String title;// 文章标题
	private String classificationId; // 分类id 菜单分类
	private String html; // 将文章内容转化成 html 代码形式存储起来
	private String date; // 发布时间
	private String type;//分类   计算机类  管理类？？
	private int flag; // 帖子状态  1： 正常  0：禁止 2 ：待审核
	private int accessCount;//访问量
	private String  updateDate;//最新更新时间
	private String reviewManagerId;//保存 审核者id	
	private int likeNum; // 点赞数
	
	
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
