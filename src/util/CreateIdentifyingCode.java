package util;

/*
 * 
 * ��֤�빤���� ����һ��6λ�������֤��
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
