<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Info</title>
</head>
<body align=center style="font-size:15pt; background-color:#FAEBEFFF; font-family:optima;"> 
 
<button style="font-size:14pt; background-color:#90D5EC;" onclick="window.location.href='CustRepSuccess.jsp';">Return to Dashboard</button>


	<form action="RemoveBidCustRep.jsp" method="POST">
	<p style = "font-size:16pt;"><b>Remove a Bid (Buyer)</b></p>
	
		<table align=center style="font-size:16pt; text-align:left;	">
		  <tr>    
		  <td>Enter enduserID: <input type="text" name="enduserID" placeholder="enduserID" ></td>
		  </tr>
		  <tr>    
		  <td>Enter BidID <input type="text" name="bidID" placeholder="bidID" ></td>
		  </tr>
		  </table>
		  
	  <input type="submit" value="Delete Bid" style="font-size:14pt; background-color:#90D5EC; margin-top:1em;">
	 
	</form>
	<br>



</body>
</html>