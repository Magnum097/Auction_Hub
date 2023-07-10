<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Creating an Account for user</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">
	<div>
		<h1 style= "font-family:Andale Mono;" align= center>
			Create a new Account!
		</h1>
	</div>
	
<br>

<form name="myForm" action="InsertAccountInfo.jsp" method="POST">
       <table align=center bgcolor=#D3D3D3 style="border:3px; border-style:solid; font-family:Andale Mono; border-color:#FFFFF; padding: 1em; position:relative;">
	       <tr>
	       <td style="font-size:16pt;"><b>Enter your UserID: </b></td><td><input type="text" name="UserID" maxlength="100" size = "30" style="font-size:16pt;"/></td>
	       <td style="font-size:16pt;"><b>(max 5 characters)</b></td>
	       </tr>
	       <tr>
	       <td style="font-size:16pt;"><b>Enter your Name: </b></td><td><input type="text" name="Name" maxlength="100" size = "30" style="font-size:16pt;"/></td>
	        <td style="font-size:16pt;"><b>(max 100 characters)</b></td>
	       </tr>
	       <tr>
		   <td style="font-size:16pt;"><b>Enter your Password: </b></td><td><input type="password" name="Password" maxlength="100" size = "30" style="font-size:16pt;"/></td>
		   <td style="font-size:16pt;"><b>(max 10 characters)</b></td>
		   </tr>
		   <tr>
		   <td style="font-size:16pt;"><b>Enter your Email:</b></td><td><input type="text" name="Email" maxlength="100" size = "30" style="font-size:16pt;"></td>
		   <td style="font-size:16pt;"><b>(max 100 characters)</b></td>
		   </tr>
		   <tr>
	       <td style="font-size:16pt;"><b>Enter your Phone Number: </b></td><td><input type="text" name="Phone" maxlength="100" size = "30" style="font-size:16pt;"/></td>
	       <td style="font-size:16pt;"><b>(max 11 characters)</b></td>
	       </tr>
	       <tr>
	       <td style="font-size:16pt;"><b>Enter your Address: </b></td><td><input type="text" name="Address" maxlength="100" size = "30" style="font-size:16pt;"/></td>
	       <td style="font-size:16pt;"><b>(max 100 characters)</b></td>
	       </tr>
	       <tr><td><input type="submit" value="Register" style="font-size:16pt; position:relative; left:380px; top:6px; background-color:#90D5EC;"/></td></tr>
       </table>
     </form>
</br>
</body>
</html>