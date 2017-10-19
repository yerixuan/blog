package util;

/*
 * 
 * 验证码工具类 产生一个6位随机的验证码
 * @author: yezi
 * 
 */

public class CreateIdentifyingCode {
	
	
	public static String  create(){
		
		int code=0;
		
	      while(code<100000)
          code=(int ) (Math.random()*1000000);
			
		return   code+"";
		
	}
	
 
	

}
