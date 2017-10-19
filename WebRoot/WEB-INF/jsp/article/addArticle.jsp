<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
 

%>
<metacontent="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no;" name="viewport" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>新增帖子</title>
  
  </head>
  
    <link rel='stylesheet' href='./css/bootstrap.min.css'>

	<script src='./js/jquery-3.1.1.min.js'></script>

	<script src='./js/bootstrap.min.js'></script>
	<script src='./js/kindeditor-min.js'></script>
	
  
  
  <body>
 
 <div class="container">
 
 <form class="form-horizontal" role="form"> 
 
 <table class="table">
 
 <tr>
 <td> <label  >标题：</label></td>
 <td> <input type="text" id="title" /></td>
 </tr>
 
 
 
 <tr>
 <td><label>菜单分类：</label></td>
 <td>
   <select id="classificationId">
    
    <option value="zyzn">志愿指南</option>
    <option value="gxfj">高校风景</option>
    <option value="wtjl">问题交流</option>
   
   </select>
 
 </td>
 
 </tr>
 
 
 <tr>
 <td><label >学科类别：</label></td>
 <td> <input type="text" id="type"/></td>
 </tr>
 
 
 
 <tr>
 <td><label > 内容： </label></td>
 <td>
 <textarea id="html"   >
 
 </td>
 
 </textarea>
 
 
 </tr>
 
  
 </table>
 
 </form>
 
 
 <div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
					<button type="button" id="submitButton" class="btn btn-primary"  onclick="addArticle()">提交</button>
				</div>
 
 
 </div>
 
 
 
 <script type="text/javascript">
 
 
 
 
 
 
 function addArticle(){
	 
	 
	 
	 
 }
 
 
 
 
 var serverAddress = '<%=basePath%>';
 
var add_order_photo_dir_photoGuideEditor;
   KindEditor.ready(function(K) {
			add_order_photo_dir_photoGuideEditor = KindEditor.create(
					'#html', {
						width : '345px',
						minWidth : 345,
						height : '400px',
						resizeType : 0,
						filterMode : false,
						allowFlashUpload : false,
						allowMediaUpload : false,
						allowFileUpload : false,
						allowPreviewEmoticons : false,
						imageTabIndex : 1,
						allowImageRemote : true,
						formatUploadUrl : false,
						// 这里处理 帖子 上传图片
						uploadJson : serverAddress+'common/ajax/editor_image_upload',
						items : [ 'source', '|', 'undo', 'redo', '|',
								'wordpaste', 'quickformat', 'clearhtml', '|',
								'justifyleft', 'justifycenter', 'justifyfull',
								'insertorderedlist', 'insertunorderedlist',
								'indent', 'outdent', '|', 'fontname',
								'fontsize', '|', 'forecolor', 'hilitecolor',
								'bold', 'removeformat', '|', 'table', 'hr',
								'image', 'link' ]
					});
		});
</script>
 
 
 
 
 
  </body>
</html>
