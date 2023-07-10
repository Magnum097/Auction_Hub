<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Viewing Bid History </title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">

	<button style="font-size:14pt; background-color:#90D5EC; margin-bottom:1em;" onclick="window.location.href='Success.jsp';">Go Back</button>
	
	<%@ page import ="java.sql.*" %>
	
	<%
	try {
	
	ApplicationDB database = new ApplicationDB();
	Connection connection = database.getConnection();
	Statement statement = connection.createStatement();
	int auctionID = Integer.parseInt(request.getParameter("auctionID"));
	%>
	
	
	<style>
	table, th, td {
	  border: 1px solid black;
	  border-collapse: collapse;
	}
	th{
		background: #F0E1B9FF;
	}
	</style>
	<table style="width:100%">
	<thead>
	
	<tr>
	<th> Buyer ID </th>
	<th> Bid ID </th>
	<th> Bid Type</th>
	<th> Auction ID </th>
	<th> Current Bid Amount</th>
	<th> Upper Limit</th>
	<th> Time of Bid </th>
	
	<%ResultSet bidhistory = statement.executeQuery("select * from bid b where b.auctionID = '"+ auctionID + "'");%>
	
	
	</tr>
	
	<%while(bidhistory.next()){%>
	<tr>
	<td><%=bidhistory.getInt("b.buyerID")%></td>
	<td><%=bidhistory.getInt("b.bidID")%></td>
	<td><%=bidhistory.getString("b.type")%></td>
	<td><%=bidhistory.getInt("b.auctionID")%></td>
	<td><%=bidhistory.getInt("b.currentBidAmount")%></td>
	<td><%=bidhistory.getInt("b.upperLimit")%></td>
	<td><%=bidhistory.getTimestamp("b.placedDate")%></td>
	
	</tr>
	<%}%>
	
	
	<%
	database.closeConnection(connection);
	%>
	</table>
	
	
	<%} catch (Exception e) {
		out.print(e);
	}%>



</body>
</html>