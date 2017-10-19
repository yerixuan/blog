package util;

import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

 

/*
 * 
 * 验证码工具类，负责用邮箱发送验证码
 * @author: yezi
 */

public class SendIdentifyingCode {
	
	
	private static String EmailAccount="yezideemail@163.com"; 
	
	private static  String password="yezidehao233";// 这里是 邮箱 授权密码 不是登录密码
	
	private static  String SMTPHost="smtp.163.com";
	
	
	public SendIdentifyingCode(){
		
	}
	
	public SendIdentifyingCode(List<String> list){  // 在构造函数中 传入参数 给邮箱帐号等赋值
		
		// 感觉也可以用 map 才传参数 
		 this.EmailAccount=list.get(0);  
		 this.password=list.get(1);
		 this.SMTPHost=list.get(2);
		
	}
	
	
	
	
	public  static  boolean sendMessage(String receiveMailAccount,String code){
		
		
		System.out.println("发送邮箱是 ： "+receiveMailAccount);
		
		 // 1. 创建参数配置, 用于连接邮件服务器的参数配置
        Properties props = new Properties();                    // 参数配置
        props.setProperty("mail.transport.protocol", "smtp");   // 使用的协议（JavaMail规范要求）
        props.setProperty("mail.host",  SMTPHost);        // 发件人的邮箱的 SMTP 服务器地址
        props.setProperty("mail.smtp.auth", "true");            // 请求认证，参数名称与具体实现有关

        // 2. 根据配置创建会话对象, 用于和邮件服务器交互
        Session session = Session.getDefaultInstance(props);
        //session.setDebug(true);                                 // 设置为debug模式, 可以查看详细的发送 log
        try {
        // 3. 创建一封邮件
        MimeMessage message = createMimeMessage(session,  EmailAccount, receiveMailAccount,code);

        // 4. 根据 Session 获取邮件传输对象
        Transport transport = session.getTransport();

        // 5. 使用 邮箱账号 和 密码 连接邮件服务器
        //    这里认证的邮箱必须与 message 中的发件人邮箱一致，否则报错
        
			transport.connect(EmailAccount, password);
		

        // 6. 发送邮件, 发到所有的收件地址, message.getAllRecipients() 获取到的是在创建邮件对象时添加的所有收件人, 抄送人, 密送人
        transport.sendMessage(message, message.getAllRecipients());

        // 7. 关闭连接
        transport.close();
        } catch ( Exception e) {
			 
			e.printStackTrace();
			return false ;
		}
		
		return true;
	}
	
	
	
	
	
	public static MimeMessage createMimeMessage(Session session, String sendMail, String receiveMail,String code) throws Exception {
        // 1. 创建一封邮件
        MimeMessage message = new MimeMessage(session);

        // 2. From: 发件人
        message.setFrom(new InternetAddress(sendMail, "叶子", "UTF-8"));

        // 3. To: 收件人（可以增加多个收件人、抄送、密送）
        message.setRecipient(MimeMessage.RecipientType.TO, new InternetAddress(receiveMail, "注册用户", "UTF-8"));

        // 4. Subject: 邮件主题
        message.setSubject("验证码", "UTF-8");

        // 5. Content: 邮件正文（可以使用html标签）
        
        
        // 更好的做法是  把 用户id 跟 验证码 保存到数据库  并设置个时间  超过 30分钟 验证码无效 
        message.setContent( "您此次注册的验证码为 ："+code, "text/html;charset=UTF-8");

        // 6. 设置发件时间
        message.setSentDate(new Date() );

        // 7. 保存设置
        message.saveChanges();

        return message;
    }
	
 
	

}
