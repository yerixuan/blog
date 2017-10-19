package util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.FileUtils;
import org.hibernate.service.spi.ServiceException;
import org.springframework.web.multipart.MultipartFile;



public class FileService {

	
private static final int maxEditorImageWidth = 800;
 
	
	public static String saveEditorImage(MultipartFile mf, String originalFilename,String tomcatAddress) throws ServiceException {
		
 
		
		 byte[] imageBytes=null;
		 String fileUri="";
		 String filepath=tomcatAddress;
		try {
			imageBytes = mf.getBytes();
		 
			
		} catch (IOException e1) {
			 
			e1.printStackTrace();
		}
		
	 
		try {
			BufferedImage image = ImageIO.read(new ByteArrayInputStream(imageBytes));
	 
			int width = image.getWidth();
			int height = image.getHeight();
			if (width > maxEditorImageWidth) {
				width = maxEditorImageWidth;
				height = maxEditorImageWidth * image.getHeight() / image.getWidth();
				imageBytes = ImageUtils.scaleImage(imageBytes, width, height, Image.SCALE_SMOOTH, null);
			}
			// 确定图片的存储路径
		  
			SimpleDateFormat sdf =new SimpleDateFormat("yyyyMMdd");
			String date =sdf.format(new Date());
		 
		 
			// 生成新的文件名
			 String newFileName= date+UUID.randomUUID().toString().replace("-", "")+originalFilename;
			
	         
			  fileUri="/image_file/"+newFileName;
			// 文件地址
			  filepath = tomcatAddress+fileUri; // ""; //  AppContext.getFilepath() + fileuri;
			 
		    //	ImageIO.write(image, "jpg", new File("E:\\myecplise2014\\项目\\cs\\file\\"+newFileName));
		 
			// 保存文件
			FileUtils.writeByteArrayToFile(new File(filepath), imageBytes);
		 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileUri;
 
	}
	
	
	public static  String saveMedia(MultipartFile mf, String originalFilename,String tomcatAddress){
		
		System.out.println("保存视频进来了");
		 
		 byte[] mediaBytes=null;
		 
		 try {
			mediaBytes=mf.getBytes();
		} catch (IOException e1) {
			 
			e1.printStackTrace();
		}
		 
		 String fileUri="";
		 String filepath=tomcatAddress;
		 
		 SimpleDateFormat sdf =new SimpleDateFormat("yyyy-MM-ddHH:mm:ss");
		 
		 String date =sdf.format(new Date()).replace(":", "-");
		 
		 
		 String newFileName=UUID.randomUUID().toString().replace("-", "")+date+originalFilename;
		 
		 fileUri="/media_file/"+newFileName;
		 
		 System.out.println("fileUri==" +fileUri);
		 
		 filepath=tomcatAddress+fileUri;
		 
		 System.out.println("filepath=="+filepath);
		 
		 System.out.println("2333");
		 
			try {
				FileUtils.writeByteArrayToFile(new File(filepath), mediaBytes);
			} catch (IOException e) {
			 
				e.printStackTrace();
			}
           System.out.println("保存视频完成");
		 
		
		return fileUri;
	}
	
	
	
}
