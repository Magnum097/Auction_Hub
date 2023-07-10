<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Auctions</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">

<button onclick="window.location.href='AdminSuccess.jsp';">Return to dashboard</button>
	
	<%@ page import ="java.sql.*" %>
	
	<%ApplicationDB database = new ApplicationDB();	
	Connection connection = database.getConnection();	
	Statement statement = connection.createStatement();
	
	//MAKE SURE THE HIGHEST BID > HIDDEN MINIMUM PRICE
	
	ResultSet resultSet = statement.executeQuery("select a.itemID, s.name, a.highestBidderID, a.HighestBid, u.name nameOfUser from auction a, shoes s, user u where u.userID = a.highestBidderId and a.itemID = s.shoeID and a.HighestBid >= a.hiddenMinimumPrice and a.closingDate < now() order by a.HighestBid DESC LIMIT 3");
	%>
	
	<style>
	table, th, td {
	  border: 1px solid black;
	  border-collapse: collapse;
	}
	</style>
	
	<h1>Best Auction Buyers</h1>
	<table style="width:100%">
	<thead>
	    <tr>
	        <th>Name Of The Buyers</th>
	        <th>User IDs Of The Buyers</th>
	        <th>Item ID</th>
	        <th>Item Name</th>
	        <th>Final selling price of item</th>
	    </tr>
	</thead>
	<tbody>
	<%
	
	while(resultSet.next()){
		out.print("<tr>");
		out.print("<td>");
		out.print(resultSet.getString("nameOfUser"));
		out.print("</td>");
		out.print("<td>");
		out.print(resultSet.getInt("highestBidderID"));
		out.print("</td>");
		out.print("<td>");
		out.print(resultSet.getInt("itemID"));
		out.print("</td>");
		out.print("<td>");
		out.print(resultSet.getString("name"));
		out.print("</td>");
		out.print("<td>");
		out.print(resultSet.getDouble("HighestBid"));
		out.print("</td>");
	}
	%>
	
	</tbody>
	</table>
	
	<% connection.close();
	%>

</body>
</html>