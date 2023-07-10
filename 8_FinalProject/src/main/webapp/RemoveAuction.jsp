<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Remove Auction</title>
</head>
<body align=center style="font-size:15pt; background-color:#FAEBEFFF; font-family:optima;">


	<button style="font-size:14pt; background-color:#90D5EC;" onclick="window.location.href='CustRepSuccess.jsp';">Return to Dashboard</button>

	<form action="RemoveAuctionCustRep.jsp" method="POST">
	<p style = "font-size:16pt;"><b>Remove an Auction (Seller)</b></p>
	<table align=center style="font-size:16pt;">
		 <tr>    
		 <td>Enter enduserID: <input type="text" name="enduserID" placeholder="enduserID" ></td>
		 </tr>
		 <tr>    
		 <td>Enter Auction ID: <input type="text" name="auctionID" placeholder="auctionID" ></td>
		 </tr>
		 </table>
		 <input type="submit" value="Delete Auction" style="font-size:14pt; background-color:#90D5EC; margin-top:1em;">
	 
	  </form>
	<br>

</body>
</html>