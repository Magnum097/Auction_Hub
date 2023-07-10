<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
	
</head>
<body style="background:#FAEBEFFF;">
	<div>
		<h1 style = "font-size:22.5pt; font-family:Andale Mono;" align = center> Welcome to BuyMe! <br> please login to your Account! </br></h1>
	</div>
	
	<br>

<form action="Login_Validate.jsp" method="POST">
       <table align=center bgcolor=#D3D3D3 style="border:3px; border-style:solid; border-color:#FFFFF; padding: 1em; position:relative;">
       
	       <tr>
	       <td style="font-size:16pt;font-family:Andale Mono;"><b>UserID: </b></td><td><input type="text" name="UserID" maxlength="100" size = "28" style="font-size:16pt;"/></td>
	       </tr>
	       <tr>
	       <td style="font-size:16pt;font-family:Andale Mono;"><b>Password: </b></td><td><input type="password" name="Password" maxlength="100" size = "28" style="font-size:16pt;"/></td>
	       </tr>
	       
	       <tr>
	       <td><input type="submit" value="Login" style="font-size:16pt;position:relative; left:200px; top:6px; background-color:#90D5EC"/></td>
	       </tr>
       
       </table>
     
</form>

 <a style="font-size:16pt;position:relative; font-family:Gill Sans; top:5px" href=Register.jsp ><center> Create An Account? </center> </a>
</body>
<br/>
</html>