
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

<title>系统管理员登录</title>


<link rel='stylesheet' href='./css/bootstrap.min.css'>

	<script src='./js/jquery-3.1.1.min.js'></script>

	<script src='./js/bootstrap.min.js'></script>
</head>

<style>
 
.div {margin:0 auto;width:960px}


</style>
<body>

	<div class='container'>
	
  
 
		<table class="table" >
			<thead>
			<br><br><br><br><br><br><br><br><br>
				<h3 class=''>系统管理员登录</h3>
			</thead>
 
    <span style="color:red">${info }</span>

			<form role="form" class="form-horizontal" action="admin" id="loginForm" method="post">

				<div class="form-group">

					<label class="control-label col-sm-1"> 用户名：</label>

					<div class="col-sm-11">

						<input name="email"  id="loginEmain" type="text" clss="form-control"
							placeholder="请输入帐号"> </input>
					</div>
			</div>


			<div class="form-group">

				<label class="control-label col-sm-1"> 密码：</label>

				<div class="col-sm-11">

					<input name="password" id="loginPassword" type="password" clss="form-control"
						placeholder="请输入密码"> </input>

				</div>
                
                </div>
				
					<div class="form-group "> 
					<button type="button"   class="btn btn-primary"  onclick="testbutton()" >登录 
					<span class="glyphicon glyphicon-log-in">	</span> 
					 </button>
						 
					</div> 
 
		 
			</form>
		</table>
		</div>
	 
 
 

</body>



<script>
  
  
var serverAddress ='<%=basePath%>' 
  
  function testbutton(){
	  
	       
	 var email=$('#loginEmain').val();
	 var pass=$('#loginPassword').val();
	 
	 if(email=='' || pass=='')
		 {
		 alert("帐号或密码不能为空");
		 
		 return ;
		 
		 }else{
	 
			 
		 	 
	     $('#loginForm').submit();
	 }
  }
  
  
document.onkeydown=function(e){
	  var keycode=document.all?event.keyCode:e.which;
	  //按下Enter键 提交表单
	  if(keycode==13){
	         
		  // 执行登录
			 testbutton();
		  
	  }
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


// 注册模态框关闭时 清除里面的一些内容
$('#register').on('hide.bs.modal', function () {
	  // 执行一些动作...
	 
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
	  
	  //清理图标
	  
	  $('#repasswordcheck').attr("class","");
	  $('#emailfalg').attr("class" ,"");
	  $('#userNamefalg').attr("class","");
	  $('#userNamefalg').html("");
	})

 

function getCode( ){
	
	 
	var eamil=$('#email').val();// 邮箱帐号192.168.32.2
	 
	 
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
                   alert("防止邮件被网易拦截，验证码为："+data.data)
                   
                  $('#codeCheck').val(data.data);
             
             
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
					  alert("注册成功！");
 					
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