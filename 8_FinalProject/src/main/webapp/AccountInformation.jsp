<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit account info</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF; font-family:optima;">
	
	<button style="font-size:14pt; background-color:#90D5EC;" onclick="window.location.href='CustRepSuccess.jsp';">Return to Dashboard</button>
	

	<form action="EditAccountInfo.jsp" method="POST">	
	<p style = "font-size:16pt;"><b>Edit the users account details</b></p>
		Note: Fields can only be updated one at a time. Return to this page to make the next change!
	<br>
	<br>
	 <table style="font-size:16pt;">
		<tr>    
			<td>Enter userID: <input type="text" name="userID" placeholder="userID" required ></td>
		</tr>
		   
		<tr>    
		   <td>Edit name: <input type="text" name="name" placeholder="name" ></td>
		</tr>
		
		<tr>    
		   <td>Edit password: <input type="text" name="password" placeholder="password" ></td>
		</tr>
		
		<tr>    
		   <td>Edit phone number: <input type="text" name="phonenumber" placeholder="phone #" ></td>
		</tr>
		
		<tr>    
		   <td>Edit email: <input type="text" name="email" placeholder="email" ></td>
		</tr>
		
		<tr>    
		   <td>Edit address: <input type="text" name="address" placeholder="address" ></td>
		</tr>
		
		<tr>    
		   <td>Delete Account: (Enter "delete" to confirm the deletion of the account) <input type="text" name="delete" placeholder = "delete"/></td>
		</tr>
		
	</table>
	
	<input type="submit" value="Submit" style="font-size:14pt; background-color:#90D5EC; margin-top:1em;">
	   
	</form>
	<br>
	
	
</body>
</html>