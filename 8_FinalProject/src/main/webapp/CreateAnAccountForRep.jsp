<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Acc for Cust Rep</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF; font-family:optima;">

	<div>
		<h1 align = center>
			Create An Account For The Customer Representative
		</h1>
	</div>
	
	<br>
	
	<form name="myForm" action="InsertInfoForCustRep.jsp" method="POST">
	       <table  align=center bgcolor=#D3D3D3 style="border:3px; border-style:solid; font-family:Andale Mono; border-color:#FFFFF; padding: 1em; position:relative;">
		       <tr>
		       <td style="font-size:16pt;"><b>Enter the UserID: </b></td><td><input type="text" name="UserID" maxlength="100" size = "50" style="font-size:16pt;"/></td>
		       <td style="font-size:16pt;"><b>(max 5 characters!)</b></td>
		       </tr>
		       <tr>
		       <td style="font-size:16pt;"><b>Enter the Name: </b></td><td><input type="text" name="Name" maxlength="100" size = "50" style="font-size:16pt;"/></td>
		        <td style="font-size:16pt;"><b>(max 100 characters!)</b></td>
		       </tr>
		       <tr>
			   <td style="font-size:16pt;"><b>Enter the Password: </b></td><td><input type="password" name="Password" maxlength="100" size = "50" style="font-size:16pt;"/></td>
			   <td style="font-size:16pt;"><b>(max 10 characters!)</b></td>
			   </tr>
			   <tr>
			   <td style="font-size:16pt;"><b>Enter the Email:</b></td><td><input type="text" name="Email" maxlength="100" size = "50" style="font-size:16pt;"></td>
			   <td style="font-size:16pt;"><b>(max 100 characters!)</b></td>
			   </tr>
			   <tr>
		       <td style="font-size:16pt;"><b>Enter the Phone Number: </b></td><td><input type="text" name="Phone" maxlength="100" size = "50" style="font-size:16pt;"/></td>
		       <td style="font-size:16pt;"><b>(max 11 characters!)</b></td>
		       </tr>
		       <tr>
		       <td style="font-size:16pt;"><b>Enter the Address: </b></td><td><input type="text" name="Address" maxlength="100" size = "50" style="font-size:16pt;"/></td>
		       <td style="font-size:16pt;"><b>(max 100 characters!)</b></td>
		       </tr>
		       <tr><td><input type="submit" value="Register" style="font-size:16pt; position:relative; left:380px; top:6px; background-color:#90D5EC;"/></td></tr>
	       </table>
	     </form>

</body>
</html>