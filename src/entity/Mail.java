package entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;


/*
 * 
 * ������֤����Ҫ�õ���������Ϣ
 * @author: yezi
 */


@Entity
public class Mail {
	
	
private String id ;
	
	private String mailAccount; // �����ʺ�
	
	private String password;  // ����
	
	private String SMTPHost;  // smtp ��������ַ
	
	private String date;  // ʱ���
	
	private String flag;  // ������; ��ͬ��;�ò�ͬ����

	
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMailAccount() {
		return mailAccount;
	}

	public void setMailAccount(String mailAccount) {
		this.mailAccount = mailAccount;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSMTPHost() {
		return SMTPHost;
	}

	public void setSMTPHost(String sMTPHost) {
		SMTPHost = sMTPHost;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}
	
	
	
	
	
	

}
