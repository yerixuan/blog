package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Report {

	
	private String id ;
	
	private String articleId;//
	
	private String reportUserId;// 举报人id
	
	private String type;//举报类型
	
	private String reason;//举报原因
	
	private String date;//举报时间
	
	private int status; // 0:已审核 ，1：未审核

	
	public Report(){}
	
	public Report(String articleid ,String userid ,String type ,String reason,String date ,int status){
		this.articleId=articleid;
		this.reportUserId=userid;
		this.type=type;
		this.reason=reason;
		this.date=date;
		this.status=status;
		
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

	public String getArticleId() {
		return articleId;
	}

	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}

	public String getReportUserId() {
		return reportUserId;
	}

	public void setReportUserId(String reportUserId) {
		this.reportUserId = reportUserId;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
	
	
	
	
}
