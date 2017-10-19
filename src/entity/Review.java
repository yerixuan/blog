package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;

/**
 * 
 * 审核表 ，当帖子被举报时，就应该将 该帖子的id 保存在审核表中 ，
 *   管理员根据审核表中的帖子id来对对应的帖子进行审核。 
 * @author yezi  --弃用
 *
 */
@Entity
public class Review {

	private String id ;
	
    private String articleid; // 帖子id
    
    private String addDate; // 加入时间

    
    @Id
    @GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getArticleid() {
		return articleid;
	}

	public void setArticleid(String articleid) {
		this.articleid = articleid;
	}

	public String getAddDate() {
		return addDate;
	}

	public void setAddDate(String addDate) {
		this.addDate = addDate;
	}
    
    
    
	
	
}
