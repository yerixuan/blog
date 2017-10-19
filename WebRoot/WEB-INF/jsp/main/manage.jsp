<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html lang="en">
<metacontent="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no;" name="viewport" />

<head>
<meta charset="UTF-8">
<title>主页</title>
<link rel="stylesheet" href="././css/bootstrap.min.css">
<link rel="stylesheet" href="./css/main.css">

    <link rel="stylesheet" href="./js/themes/default/default.css" />
	<link rel="stylesheet" href="./js/plugins/code/prettify.css" />
 
</head>

<body>
	<nav class="navbar navbar-default">
		<!-- inverse -->
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">叶子的网站 ${menu}  </a>
 
			</div>
			<form class="navbar-form navbar-right" role="search">
				<!--  
            <div class="form-group">
                <input type="text" class="form-control" placeholder="Search">
            </div>
            <button type="submit" class="btn btn-default">提交按钮</button>
            -->
            <br>
			 <tr>  
				<table class="table">
					<tr>
						<td>
							<ul class="list-group">
								<li><a href="#"  data-toggle="modal" id="person" class="glyphicon glyphicon-user"
						onclick="personInfo()"	>个人信息</a></li>
								<input type="hidden" id="userId" value="${userId}"/>
								 
								<!-- <li><a href="#">另一个东西</a></li> -->
							</ul>
						</td>
						<td>
							<ul class="list-group">
								 
								<li><a href="#"  data-toggle="modal" class="glyphicon glyphicon-bell"
								 onclick="notice()" >公告 <span class="badge" id="noticenum">${noticeNum }</span>
								<input type="hidden" id="noticeIds" value="${noticeIds }"> 
								
								</a></li>
								<li><a href="logout" class="glyphicon glyphicon-log-in">注销</a></li>
							</ul>
						</td>
					</tr>
				</table>
			</form>


		</div>
	</nav>
	<!--  
    <ul class="nav  nav-pills">   
       <li class="pull-left"> <a href="#" >注销 </a>  </li>      
    </ul>
   -->

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-2">
			 
				<div class="panel panel-default">
					<div class="panel-heading">  
						<h3 class="panel-title1">菜单</h3>
					</div>
					<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<div class="accordion" id="accordion-897486"></div>
     			 
					</div>
				</div>
			</div>

			<div class="col-sm-10">
			  
				<div class="panel panel-default">
					<div class="panel-heading">
						<div class="center-block"> 
							<p class="panel-title text-center">内容详情</p>
						</div>
					</div>
					<div class="panel-body">
						<div class="table-responsive">
							<table class="table table-bordered content-table">
								<thead class="well well-sm">
									<tr>
										<!--  
										<td>标题</td>
										
										<td>内容详情</td>-->
									</tr>
								</thead>
								<tbody id="newslist"></tbody>

							</table>
							<br> <br>
							<div class="well well-sm">
								<div class="well-inner">
									<p>
										共 <span class="num"></span> 条
									</p>
									&nbsp;&nbsp;&nbsp;&nbsp; <a href="#" class="first_page">首页</a>
									&nbsp;&nbsp; <a href="#" class="prev_page">上一页</a> &nbsp;&nbsp;
									<a href="#" class="next_page">下一页</a> &nbsp;&nbsp; <a href="#"
										class="last_page">尾页</a> &nbsp;&nbsp;&nbsp;&nbsp;
									<p>
										每页
										<!-- <span class="perpage_num">10</span>
									-->
										<select name="perpage_num" id="perpage_num">
											<option value="10" selected>10</option>
											<option value="20">20</option>
											<option value="50">50</option>
										</select> 条
									</p>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<p>
										当前第 <span class="page_num"></span> 页/共 <span
											class="whole_page_num"></span> 页
									</p>
									<!-- <p class="skip_page">
										跳转到第 <input type="text" id="skip_to"> 页 <a href="#"
											class="go_page">跳转</a>
									</p> -->
								</div>
							</div>
						</div>
				

					</div>
				</div>
			</div>
		</div>
	</div>



<div class="modal fade" id="notice" tabindex="-1" role="dialog"
		aria-labelledby="noticeList" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="noticeList"><p class="text-center">公告信息</p></h4>
				</div>
        
        <table class="table table-hover">
        
        <tr>
        <td>标题</td>
         <td>内容</td>
         <td>发布时间</td>
         
        </tr>
        
        <tbody id="noticeListBody">
        
       
        
        
        </tbody>
        
        
        </table>



            </div>
         </div>
   </div>





<!-- 查看个人信息模态框 -->
<div class="modal fade" id="personInfo" tabindex="-1" role="dialog"
		aria-labelledby="myPersonInfo" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myPersonInfo"><p class="text-center">个人信息</p></h4>
				</div>
				
				<div class="alert alert-success"  ><span id="updateInfo"></span></div>
				
				<form role="form" class="form-horizontal">
				
				<table class="table">

						<tr>
							<td><label >用户名：</label></td>
							<td><input type="text" id="userName" class="change" onblur="checkUserName()"  disabled/>
							    <input type="hidden" id="oldName" />  
							     <span id="userNamefalg"></span>
							</td>

						</tr>
						
						<tr>
						
						<td><label>头像：</label></td>
						<td>
						 <img alt="获取头像失败" src="" id="user_picture">
						</td>
						</tr>
						
						<tr>
							<td><label>邮箱：</label> </td>
							<td><input type="text" id="email"  disabled/>
							    <span style="color:red">*注册邮箱不能改 </span>
							 </td>

						</tr>
						<tr>
							<td><label >手机号：</label> </td>
							<td><input type="text" id="phone" class="change" disabled /></td>

						</tr>
						<tr>
							<td> <label>学校名称：</label> </td>
							<td><input type="text" id="schoolName" value="" class="change" disabled/>  </td>

						</tr>
						<tr>
							<td><label> 所属院系：</label> </td>
							<td><input  type="text" id="department" class="change"  disabled/></td>

						</tr>
						<tr>
							<td><label> 个人简介：</label></td>
							<td> 
							  <textarea id="description"   rows="" cols="50"  class="change" disabled >
							  
							  </textarea>
							
							</td>

						</tr>




					</table>
				
				
				
				</form>
				
				
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
					<button type="button" id="updateButton" class="btn btn-primary"  style="" onclick="changeReadonly()">修改</button>
			          
			        <!-- 当点击修改的时候  确定按钮出现 修改按钮隐藏 -->
			        <button type="button" id="submitButton" class="btn btn-primary"  style="display:none;" onclick="updateInfo()"  >确定</button>   
				</div>
	 	
			</div>
		</div>
	</div>


<!-- 新增帖子 模态框 -->
	<div class="modal fade" id="AddArticleModal" tabindex="-1"
		role="dialog" aria-labelledby="ArticleModal">
		<div class="modal-dialog" role="document" style="width:800px">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="ArticleModal">
						<p class="text-center">新增帖子</p>
						
						<div class="alert alert-success" > <span id="AddArticleSuccess"></span></div>
						
					</h4>
				</div>
				<div class="modal-body">
 
					<form class="form-horizontal" name="articleForm" role="form">

						<table class="table">

							<tr>
								<td><label>标题：</label></td>
								<td><input type="text" id="title" /></td>
							</tr>
  
                           <tr>
                           
                           <td><label >菜单分类</label></td>
                           <td>
                           <select id="classificationId">
                           <option value="zyzn">志愿指南</option>
                           <option value="gxfj">高校风景</option>
                           <option value="wtjl">问题交流</option>                   
                           </select>
                           
                           
                           </td>
                           </tr> 
 
							<tr>
								<td><label>学科类别：</label></td>
								<td><input type="text" id="type" />
								    
								</td>
							</tr>

							<tr>
								<td><label> 内容： </label></td>
								<td>
								
										<textarea name="articleHtml"  id="articleHtml"   rows="8" style="width:550px;height:200px;visibility:hidden;"> </textarea>
								
   
								</textarea>
                            </td>
							</tr>
						</table>

					</form>
					<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>  
			        <button type="button" id="submitArticleButton" class="btn btn-primary"    onclick="addArticle()"  >确定</button>   
				</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">消息推送</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">推送内容</label>
							<div class="col-sm-8">
								<input type="text" class="form-control push-content"
									id="inputEmail3" required>
								<p style="display:none" class="hidden-id"></p>
							</div>
							<div class="col-sm-2"></div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">有效时间(秒)</label>
							<div class="col-sm-8">
								<input type="number" class="form-control expire-time"
									id="inputPassword3" required>
							</div>
							<div class="col-sm-2"></div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">推送对象</label>
							<div class="col-sm-8 radio-content">
								<label class="checkbox-inline"> <input type="radio"
									name="optionsRadiosinline" id="optionsRadios3" value="1"
									checked>所有对象
								</label> <label class="checkbox-inline" style="display:none"> <input
									type="radio" name="optionsRadiosinline" id="optionsRadios4"
									value="0" class="special-btn">指定对象
								</label> <input type="text" class="spobj" style="display:none">

							</div>
							<div class="col-sm-2"></div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">推送时间</label>
							<div class="col-sm-6">
								<div class="input-group clockpicker" data-placement="right"
									data-align="top" data-autoclose="true">
									<input type="text" class="form-control time-selector"
										value="09:32"> <span class="input-group-addon">
										<span class="glyphicon glyphicon-time"></span>
									</span>
								</div>
							</div>
							<div class="col-sm-4"></div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<!-- <button type="button" class="btn btn-default btn-cancel"
						data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary dopush">推送</button> -->
				</div>
			</div>
		</div>
	</div>

	<script src="./js/jquery-3.1.1.min.js"></script>
	<script src="./js/script01.js"></script>
	 
	
	
	<script src="./js/bootstrap.min.js"></script>
	<script src="./js/bootstrap-clockpicker.min.js"></script>
 
   
	<script   src="./js/kindeditor.js"></script>
	<script   src="./js/lang/zh_CN.js"></script>
	<script   src="./js/plugins/code/prettify.js"></script>
  
 
 <script>
 
 window.onload = function() {
  
	  var serverAddress='<%=basePath%>';
		
	  //获取菜单
   $.ajax({
       url: serverAddress+'Menus',
       data:  "userId="+ $('#userId').val()  ,
       method: 'POST',
       success: function(data, status) {
       	
       	console.log(data.data);
       	
           if (data.status === '200') {
               console.log(data.data);
               for (var i in data.data) {
                   console.log(i);
                 
                   if(i=='wdtz'){
                   	var new_elem='<div class="accordion-group">' +
                       '<div class="accordion-heading">' +
                      
                       //dropdown
                       '<li class="" ><a  '
                       
                       +    
                       ' data-parent="#accordion-897486"  href="#accordion-element-708546"  class="btn btn-default accordion-toggle collapsed  " data-toggle="collapse"  >' + data.data[i] + ' <span class="caret"></span> </a>  ' +
                      
                       '<div id="accordion-element-708546" class="accordion-body collapse">'+
                       ' <div class="accordion-inner">'+
                      
                       '<ul class="" >  <li><a  href="#" id="wdtz"> 已发贴</a> </li> <li><a data-toggle="collapse" href="#" id="addArticle" onclick="openAddArticle()" > 新增帖子</a> </li>  '+   // <li><a> aa</a>
                
                       
                       '</div>' +
                       '<div   '   + '  class="accordion-body collapse" style="display:inline">' +
                       '<div class="accordion-inner">' +
                       '<ul>' +
                       '<li>' +
                       '<a href="#" id="' + i + '-hot">热门</a>' +
                       '</li>' +
                       '</ul>' +
                       '</div>' +
                       '</div>'
                   '</div>';
                   	
                   }
                   else{
                   var new_elem = '<div class="accordion-group">' +
                       '<div class="accordion-heading">' +
                       
                       '<li><a class="btn btn-default " data-toggle="collapse"' +
                       ' data-parent="#accordion-897486" id="' + i + '">' + data.data[i] + '</a> </li> ' +
                       '</div>' +
                       '<div id="' + i + '" class="accordion-body collapse" style="display:inline">' +
                       '<div class="accordion-inner">' +
                       '<ul>' +
                       '<li>' +
                       '<a href="#" id="' + i + '-hot">热门</a>' +
                       '</li>' +
                       '</ul>' +
                       '</div>' +
                       '</div>'
                   '</div>';
                   }
                   
                   $('.accordion').append(new_elem);

                   (function(index) {
                   	 
                   		 
                       $('#' + index).on('click', function() {
                       	
                           
                           var perpage_num = $('#perpage_num').val();
                           console.log(perpage_num);
                           

                           getAllArticle(index, 1, perpage_num);
                           
                       });
                       $('#' + index + '-hot').on('click', function() {
                           var perpage_num = $('#perpage_num').val();
                           getAllHotNews(index, 1, perpage_num);
                       });
                   }(i));
               }
           } else {
               alert('获取新闻失败,请重新刷新');
           }
       }
   });
	
	
	 
	   
	   var getAllArticle = function(id, curpage, pagesize) {
	        $('#newslist').text('');
	        var data = {
	            channelId: id,
	            currentPage: curpage,
	            pageSize: pagesize ,
	            userid :$('#userId').val()
	            
	        };
	        $.ajax({
	            url: serverAddress+'getArticleListByPager',
	            method: 'POST',
	            data: data,
	            success: function(data, status) {
	                console.log(data);
	                $('.num').text(data.totalCount);
	                $('.page_num').text(data.currentPage);
	                $('.whole_page_num').text(data.pageCount);
	                $('.first_page,.next_page,.prev_page,.last_page,.go_page').off('click');
	                $('#perpage_num').off('change');
	                $('.first_page').on('click', function() {
	                    var perpage_num = $('#perpage_num').val();
	                    getAllArticle(id, 1, perpage_num);
	                });
	                $('.last_page').on('click', function() {
	                    var perpage_num = $('#perpage_num').val();
	                    getAllArticle(id, data.pageCount, perpage_num);
	                });
	                $('.go_page').on('click', function() {
	                    var skipto = $('#skip_to').val();
	                    if (skipto <= data.pageCount && skipto >= 1) {
	                        var perpage_num = $('#perpage_num').val();
	                        getAllArticle(id, skipto, perpage_num);
	                    } else {
	                        alert('请输入合理的页数');
	                    }
	                });
	                if (curpage < data.pageCount) {
	                    $('.next_page').on('click', function() {
	                        var perpage_num = $('#perpage_num').val();
	                        getAllArticle(id, ++curpage, perpage_num);
	                    });
	                } else {
	                    $('.next_page').on('click', function() {
	                        return false;
	                    });
	                }
	                if (curpage > 1) {
	                    $('.prev_page').on('click', function() {
	                        var perpage_num = $('#perpage_num').val();
	                        getAllArticle(id, --curpage, perpage_num);
	                    });
	                } else {
	                    $('.prev_page').on('click', function() {
	                        return false;
	                    });
	                }
	                $('#perpage_num').change(function() {
	                    var perpage_num = $('#perpage_num').val();
	                    console.log(perpage_num);
	                    getAllArticle(id, 1, perpage_num);
	                    $('#perpage_num').blur();
	                });

	                if (status === 'success') {
	                	
	                if(data.status=='200'){
	                	
	                    for (var i = 0; i < data.data.length; i++) {
	                        var new_elem = '<tr>' +
	                            '<td>' +
	                            '<input type="checkbox" name="checkbox" value="' + data.data[i].newsId + '">' +
	                            '</td>' +
	                            '<td>' +
	                            '<a  title="点击查看详情" href="myArticleDetail?articleId=' + data.data[i].id + '&userid='+$('#userId').val() +'">' +data.data[i].type +": "+ data.data[i].title +" -(" +data.data[i].userId +")" + '</a>' +
	                            '</td>' +
	                            '<td>' +
	                           // '<a href="' + data.data[i].htmlpath + '">查看详情</a>' +
	                            '</td>' +
	                            '</tr>';
	                        $('#newslist').append(new_elem);
	                    }
	                }else{
	                		 
	                	
	                    for (var i = 0; i < data.data.length; i++) {
	                        var new_elem = '<tr>' +
	                            '<td>' +
	                            '<input type="checkbox" name="checkbox" value="' + data.data[i].newsId + '">' +
	                            '</td>' +
	                            '<td>' +
	                            '<a  title="点击查看详情" href="articleDetail?articleId=' + data.data[i].id + '&userid='+$('#userId').val() +'">' +data.data[i].type +": "+ data.data[i].title +" -(" +data.data[i].userId +")" + '</a>' +
	                            '</td>' +
	                            '<td>' +
	                           // '<a href="' + data.data[i].htmlpath + '">查看详情</a>' +
	                            '</td>' +
	                            '</tr>';
	                        $('#newslist').append(new_elem);
	                    }
	                }
	                }
	            }
	        });
	    };
	   
    
}
 
 
 
 function addArticle(){
 
	 var ServerAddress= '<%=basePath%>';
	 
	 $.ajax({
		
		 url: ServerAddress+"addArticle"  ,
		 method: 'POST' ,
		 data:{"userid" : $('#userId').val() ,"title" : $('#title').val() ,"type" :$('#type').val() ,"articleHtml" : add_order_photo_dir_photoGuideEditor.html() ,"classificationId":$('#classificationId').val()},
		 success: function (data, status ){
			 
			 console.log(data.data);
			 
			 alert("帖子发布成功");
		 }
		 
	 });
	 
	// 保存成功关闭 关闭默认模态框
	 $('#AddArticleModal').modal("hide");
	 
 }
 
 
 
 
 </script>
 
 
 <script type="text/javascript">
 var serverAddress = '<%=basePath%>';
  
 
var add_order_photo_dir_photoGuideEditor;
KindEditor.ready(function(K) {
	add_order_photo_dir_photoGuideEditor = K.create(  'textarea[name="articleHtml"]', {
		cssPath : './js/plugins/code/prettify.css',
		uploadJson : 'common/ajax/editor_image_upload?serverAddress='+serverAddress+'&userid='+$('#userId').val(),
		fileManagerJson : 'common/file_manager_json',
		allowFileManager : true,
		afterCreate : function() {
			var self = this;
			K.ctrl(document, 13, function() {
				self.sync();
				document.forms['articleForm'].submit();
			});
			K.ctrl(self.edit.doc, 13, function() {
				self.sync();
				document.forms['articleForm'].submit();
			});
		}
	});
	prettyPrint();
});
</script>
 
 <script>
 
 // 新增帖子 模态框关闭的时候 将 里面的内容清空 
 $('#AddArticleModal').on('hide.bs.modal' ,function(){
	 
	 $('#title').val("");
	 $('#type').val("");
	 $('#classificationId').val("");
	 KindEditor.instances[0].html("");
	 
 });
 
 
 // js 控制打开新 页面用于 写帖子
 function openAddArticle(){
	 
	 
	 $('#AddArticleModal').modal({backdrop: 'static'});
	 $('#AddArticleModal').modal("show");
	 
 }
 
 

 
 // 模态框关闭时 清除 公告内容
 $('#notice').on('hide.bs.modal', function () {
	  
	 $('#noticenum').html("");
	 $('#noticeListBody').html("")
	 
 })
 
 // 加载公告内容
  function notice(){
	 
	 $('#notice').modal({backdrop: 'static'});
	 $('#notice').modal('show');
	 
	 var serverAddress= '<%=basePath %>'
  
			   $.ajax(
						{
				    url: serverAddress+"getNoticeList" ,
				    method: 'POST' ,
				    data: {"ids":$('#noticeIds').val() ,"userId" :$('#userId').val()} ,
					success:function(data, status) {
						
						console.log(data.data);
						
						
						 if (status === 'success') {
			                    for (var i = 0; i < data.data.length; i++) {
			                        var new_elem = '<tr>' +
			                            '<td>' +
			                            '<input type="checkbox" name="checkbox" value="' + data.data[i].id + '">' +
			                            '</td>' +
			                            '<td>' +
			                            '<p  title=""   >' +data.data[i].title    + '</p>' +
			                            '</td>' +
			                            '<td> <p >'+data.data[i].content+'</p> </td>'+
			                             '<td> <p>'+data.data[i].date+'</p></td>'+
			                            
			                           // '<a href="' + data.data[i].htmlpath + '">查看详情</a>' +
			                             
			                            '</tr>';
			                        $('#noticeListBody').append(new_elem);
			                    }
						 }
						
						
						
						
						}
					});
	 
 }
 
  
 
 </script>
 
	
	
	<script>
	
	function checkUserName(){
		
		var oldName =$('#oldName').val();
		var userName=$('#userName').val();
		
		
	//	alert(oldName  +"   " +userName);
		
		var serverAddress= '<%=basePath %>'
		
		
		if(userName=='') {
			  $('#userNamefalg').html("用户名不能为空") ; 
			 
		  	  return ;
		}
		
		if(oldName==userName) {
			
			 $('#userNamefalg').attr("class","");
			 $('#userNamefalg').html("") ; 
			return ;
		}
		
		
		 
		$.ajax(
				{
		    url: serverAddress+"checkUserName" ,
		    method: 'POST' ,
		    data: "userName="+userName  ,
			success:function(data, status) {
				 
	            if (data.status == '200') {
	                console.log(data.data);
	                 
	                $('#userNamefalg').attr("class","glyphicon glyphicon-ok");
	                $("#submitButton").removeAttr("disabled");
	                return  ;
	            }else {
	            	 
	            	
	            	$('#userNamefalg').html(data.message);  
	            	$('#userNamefalg').attr("class","glyphicon glyphicon-remove");
	             	$("#submitButton").attr({"disabled":"disabled"});
	            	return  ;
	            }
	            }
					
					
		 });
		
		
		
	}
	
	
	// 更新个人信息 
	function updateInfo( ){
		
		var serverAddress= '<%=basePath %>'
		var id =$('#userId').val();
		var userName = $('#userName').val();
		var phone = $('#phone').val();
		var schoolName =$('#schoolName').val();
		var department =$('#department').val();
		var description =$('#description').val();
		
		if(userName=='') {
			alert("用户名不能为空");
			return ;
		}
		
		$.ajax({
			
			url: serverAddress+"updateInfo" ,
			method: 'POST' ,
			data : {"id":id , "userName" :userName ,"phone":phone , "schoolName" :schoolName ,"department" : department,"description" :description },
			success:function (data ,status){
				
				console.log(data);
				if(data.status=='200')
					{
					
					
					 //alert("")
					 
					  $('#updateInfo').text("更新成功");
					
					// 更新成功 关闭模态框
				//	$('#personInfo').modal('hide');
					}else{
						
						alert("更新失败!");
						return ;
					}
				
				
			}
			
		});
		
		 
		
	}
	
	
	function changeReadonly(){
		
		$('.change').removeAttr("disabled");
		$('#updateButton').css({ "display": "none" });
		$('#submitButton').css({ "display": "inline" })
		
		
	}
	
	$('#personInfo').on('show.bs.modal', function () {
		
		$('#userNamefalg').attr("class","");
		
	});
	
	
	// 加载个人信息
	function personInfo(){
		
		 $('#personInfo').modal({backdrop: 'static'});
		 $('#personInfo').modal('show');
		
		 var serverAddress= '<%=basePath %>';
		 
			 
			 $('.change').attr("disabled","true");
			 $('#submitButton').css({ "display": "none" });
			 $('#updateButton').css({ "display": "inline" });
			 $('#updateInfo').text('');
			 
			 $.ajax({
				
				 url:serverAddress+"getUserInfo",
				 method:'POST',
				 data:"id="+$('#userId').val(),
				 success: function(data,status){
					 
					 console.log(data.data);
	  
				     $('#userName').val(data.data.userName);
					 $('#email').val(data.data.email);
					 $('#phone').val(data.data.phone);
					 $('#schoolName').val(data.data.schoolName);
					 $('#deparment').val(data.data.department);
					 $('#description').val(data.data.description); 
					 $('#oldName').val(data.data.userName);
					 $('#user_picture').attr('src',data.data.pictureurl);
					 
					 
					 
					 return ;
				 }
				 
				 
			 });
			 
		 
		
	}
	
	
	// 加载个人信息
	 $('#personInfo').on('show.bs.modal', function () {
	 
	 });
 
	</script>


	<script type="text/javascript">
    $('.clockpicker').clockpicker()
        .find('input').change(function(){
            // TODO: time changed
            console.log(this.value);
        });
    $('#demo-input').clockpicker({
        autoclose: true
    });
 
</script>

	<script type="text/javascript"> 


 

</script>

</body>
</html>
 