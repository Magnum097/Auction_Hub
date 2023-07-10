<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>History of Bids</title>
</head>
<body align=center style = "background:#FAEBEFFF; font-size:15.5pt; font-family:optima; color:#00203FFF;">

	<button style="font-size:14pt; background-color:#90D5EC;" onclick="window.location.href='Success.jsp';">Return to Dashboard</button>

    
	<br>
	<form action="ViewBidHistory.jsp" method="POST">	
	<p style = "font-size:16pt;"><b>Enter the <i style="color:blue;">auctionID</i> to see the history of Bids for that auction</b></p>
	
		 <table align=center style="font-size:16pt;">
			<tr>    
			<td>Enter the auction ID: <input type="text" name="auctionID" placeholder="auctionID" required></td>
			</tr>
			
		 </table>
		
		<input style="font-size:14pt; background-color:#90D5EC; font-size:14pt;" type="submit" value="Submit Question">
	   
	</form>
	<br>

</body>
</html>