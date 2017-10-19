
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

System.out.println("basePath"+basePath);

%>

<html>
<metacontent="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no;" name="viewport" />

<head>

<title>管理员登录</title>


<link rel='stylesheet' href='./css/bootstrap.min.css'>

	<script src='./js/jquery-3.1.1.min.js'></script>

	<script src='./js/bootstrap.min.js'></script>
</head>

<style>
 
.div {margin:0 auto;width:960px}


</style>
<body>

	<div class='container'>
	
 
	 
 
	
	
	
	
	<div class="div"> 
	
	<div class="center-block">
		<table class="table" >
			<thead>
			<br><br><br><br><br><br><br><br><br>
				<h3 class=''>管理员登录</h3>
			</thead>
 
    <span style="color:red">${info }</span>

			<form role="form" class="form-horizontal" action="manager" id="loginForm" method="post">

				<div class="form-group">

					<label class="control-label col-sm-1"> 邮箱：</label>

					<div class="col-sm-11">

						<input name="email"  id="loginEmain" type="text" clss="form-control"
							placeholder="请输入帐号"> </input>
					</div>
			</div>


			<div class="form-group">

				<label class="control-label col-sm-1">  密码：</label>

				<div class="col-sm-11">

					<input name="password" id="loginPassword" type="password" clss="form-control"
						placeholder="请输入密码"> </input>

				</div>

				
					<div class="form-group "> 
					<button type="button"   class="btn btn-primary"  onclick="testbutton()" >登录 
					<span class="glyphicon glyphicon-log-in">	</span> 
					 </button>
		 
					</div> 
<!--  <div class='checkbox'>
<label>
<input type='checkbox' value='remember-me'> 记住登录状态
</label>
 -->
			</div>
			</form>
		</table>
		</div>
	</div>
</div>

	<div class="modal fade" id="register" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel"><p class="text-center">网站注册</p></h4>
				</div>


		<form role="form" class="form-horizontal" id="registerForm">

					<table class="table">

						<tr>
							<td><label class=""> 用户名 ： </label></td>
							<td>
								<div class="">
									<input type="text" id="userName"  name="userName" placeholder="请输入您的用户名"  onblur="checkUserName()"/>
									<span class="" id="userNamefalg" style="color:red"> </span>
								
									<span style="color:red">*必填 </span>
								</div>
							</td>
						</tr>
						<tr>
							<td><label class="">邮箱：</label></td>
							<td><input class="" type="text" id="email" name="email" onblur="checkMail()" /> &nbsp;
								<span class="" id="emailfalg"> </span><button type="button" class="btn btn-info btn-sm"
									onclick="getCode()">发送验证码</button></td>
						</tr>
						<tr>

							<td><label class=" ">验证码：</label></td>
							<td>
								<div>

									<input type="text" name="code"  id="code" onblur="checkCode()"  />
									<span class="" id="ok" style="color:red"> </span>
									<input type="hidden" id="codeCheck" value=""/>
								</div>
							</td>
						</tr>
						
						<tr>
						
						<td > 
						 <label>密码： </label>
						</td>
						<td><input type="password" id="password" name="password" />
						    <span class="" id="password" style="color:red">*必填</span>
						</td>
						</tr>
						
					 
					
					<tr>
						
						<td > 
						 <label>重新输入密码： </label>
						</td>
						<td><input type="password" id="repassword" name="repassword"  onblur="checkPassword()" />
						    <span class="" id="repasswordcheck" style="color:red" ></span>
						    <span class=""  style="color:red">*必填</span>  
						</td>
						</tr>
						
					<tr>
					
					
					 <td>
					 <label >学校名称：</label>
					 </td>
					<td> 
					<!-- 感觉这里可以做成动态获取 学校字典  先暂时自己填 -->
					 <input type="text" id="schoolName"  />
					 
					</td>
					
					
					</tr>	
					
					
					<tr>
					
					
					 <td>
					 <label >所属院系：</label>
					 </td>
					<td> 
					<!-- 感觉这里可以做成动态获取 学校字典  先暂时自己填 -->
					 <input type="text" id="department"  />
					</td>
					
					
					</tr>	
					
					
					
					
					<tr>
					
					<td><label>手机号码： </label></td>
					<td>
					 <input type="text" id="phone" name="phone" onblur="checkPhone()" />
					 <span class="" id="phoneflag" style="color:red"> </span>
					 <span style="color:gray"> *选填</span>
					</td>
					
					
					</tr>	
					
					
					<tr>
					
					<td><label>个人描述：</label></td>
					<td> <textarea rows="5" cols="50" id="description" name="description"></textarea>
					    <span style="color:gray">选填</span>
					 </td>
					
					
					</tr>	
					

					</table>
  
  <tr>  
  
   <td>
        
   </td>
  </tr>
    
				</form>

	 
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
					<button type="button" id="submitButton" class="btn btn-primary"  onclick="register()">提交</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>



</body>



<script>
  
  
var serverAddress ='<%=basePath%>' 
  
  function testbutton(){
	  
	    
	   $('#loginForm').submit();
  }
  
  
  
 
function checkPassword(){
	
	var password=$('#password').val();
	var repassword=$('#repassword').val();
	
 
	
	if(password=='' && repassword=='') {
		$('#repasswordcheck').html("");
		$('#repasswordcheck').attr("class","");
	 
	}else{
		
		if(password==repassword) {
			
			 
			$('#repasswordcheck').html("");
			$('#repasswordcheck').attr("class","glyphicon glyphicon glyphicon-ok");
			 $("#submitButton").removeAttr("disabled");
			return  ;
		}else{
		 
			$('#repasswordcheck').html("两次密码不一致！")
			$('#repasswordcheck').attr("class","glyphicon glyphicon-remove");
			$("#submitButton").attr({"disabled":"disabled"});
			 return ;
			 
		}
		
		
	}
	
}

function checkUserName(){
	
	 
	var userName=$('#userName').val();
	if(userName=='') return ;
	 
	$.ajax(
			{
	    url: serverAddress+'checkUserName' ,
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



function checkPhone(){
	
	if( $('#phone').val()=='') 
		{
		$('#phoneflag').attr("class","");
		$("#submitButton").removeAttr("disabled");
		 return ;
		}
	else{
		var reg=/[0-9]{11}/;
		var phone=$('#phone').val();
		if(!reg.test(phone))
			{
			
			$('#phoneflag').attr("class" ,"glyphicon glyphicon-remove");
			$("#submitButton").attr({"disabled":"disabled"});
			return   ;
			
			}else {
				$('#phoneflag').attr("class" ,"glyphicon glyphicon-ok");
				 $("#submitButton").removeAttr("disabled");
				return   ;
			}
		
	}
	
	
}


function checkCode() {
	
	var code=$('#code').val() ;// 输入的验证码
	var codeCheck=$('#codeCheck').val();// 后台生成的验证码
	
	 
	
	if(code!=codeCheck)
		{
		//alert("验证码不正确，请重新输入！")
		$('#ok').attr("class" ,"glyphicon glyphicon-remove");
		$("#submitButton").attr({"disabled":"disabled"});
		return   ;
		}
	else{
		if(codeCheck!=''){
	     $('#ok').attr("class","glyphicon glyphicon-ok");
	     $("#submitButton").removeAttr("disabled");
	     return   ;
		}
		 
	}
}



// 当用户 鼠标离开邮箱输入框时 触发检查邮箱格式事件
function checkMail(){
	
	// 此处是个 坑  单独用 js 或 jq 获取都是获取不到正确值  两个一起用就可以了
	var eamil=$("#email").val();// 邮箱帐号 
	 email=document.getElementById("email").value;
	
	var reg = /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;
	 
     
 
	
	if(!reg.test(email)){
		//alert("邮箱格式不对，请检查！");
		$('#emailfalg').attr("class" ,"glyphicon glyphicon-remove");
		$("#submitButton").attr({"disabled":"disabled"});
		return  ;
	}else{
		$('#emailfalg').attr("class" ,"");
		 $("#submitButton").removeAttr("disabled");
		return  ;
	}
}


$('#register').on('hide.bs.modal', function () {
	  // 执行一些动作...
	//alert("clear");
	 document.getElementById("email").value="";
	 document.getElementById("description").value="";
	 document.getElementById("phone").value="";
	  document.getElementById("userName").value="";
	  document.getElementById("schoolName").value="";
	  document.getElementById("code").value="";
	  document.getElementById("codeCheck").value="";
	  document.getElementById("password").value="";
	  document.getElementById("repassword").value="";
	  document.getElementById("department").value=""; 
	  
	  
	  
	})

 

function getCode( ){
	
	 
	var eamil=$('#email').val();// 邮箱帐号192.168.32.2
	 
	alert(eamil)
	 checkMail();// 再次做 邮箱格式检查
	 
    $.ajax({
    	 
        url: serverAddress+'getIndentifyCode', 
        method: 'POST',
       data:"email="+email,
       success: function(data, status) {
            if (data.status === '200') {
                console.log(data.data);
                
                if(data.data==null){
                	alert("该邮箱已经被注册过了！");
                    return ;	
                }
                
                   alert("验证码已发送，请注意查收！")
                alert(data.data);
                  $('#codeCheck').val(data.data);
               //   alert("验证码是 "+$('#codeCheck').val())
             
            }
           
        
        }
    });
	
	
	
	
	
}


</script>

 

<script>
 function register(){
 
	    var email=$('#email').val();// 邮箱帐号192.168.32.2
		var userName=$('#userName').val();
		var phone = $('#phone').val();
		var schoolName =$('#schoolName').val();
		var description =$('#description').val();
		var password=$('#password').val();
		var department=$('#department').val();
		
		if(userName=='') {
			 alert("用户名不能为空！");
			 return ;
		 }if(email==''){
			 alert("邮箱不能为空！");
			 return ;
		 }if(password=='' || repassword==''){
			 alret("密码不能为空！")
			 return ;
		 }
	    
	 
		
		$.ajax({
			
			url: serverAddress+'register' ,
			method: 'POST' ,
			data:{"email":email,"password":password,"userName":userName,"phone" : phone , "schoolName" :schoolName,"description" : description,"department":department},
			success:function (data ,status){
				
				if(data.status == '200') {
					
					console.log(data.data);
					// 在这里查询 用户须知 并 显示在页面上  
					// alert("注册成功！");
					alert("   "+data.data.title+"\n\n"+data.data.content+"\n\n"+"   发布者：  "+data.data.publisherName) 
					
					$('#register').modal('hide');
				}else {
					
					alert("注册失败，请检查！");
					return ;
					
				}
				
			}
			
			
		});
		
	 
		
	 //关闭模态框
	 $('#register').modal('hide');
	 
	 
 }
 
 </script>
</html>