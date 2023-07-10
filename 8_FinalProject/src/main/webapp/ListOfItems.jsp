<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
    
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Items</title>
</head>

<body style="font-size:15pt; background-color:#FAEBEFFF;">
	<button style="font-size:14pt; background-color:#90D5EC;" onclick="window.location.href='Success.jsp';">Return to Dashboard</button>
	
		<%@ page import ="java.sql.*" %>
	<%ApplicationDB database = new ApplicationDB();	
	Connection connection = database.getConnection();	
	Statement statement = connection.createStatement();
	
	ResultSet resultSet = statement.executeQuery("select a.itemID, s.name, a.auctionID from shoes s, auction a where s.shoeID = a.itemID"); %>
	<style>
	table, th, td {
	  border: 1px solid black;
	  border-collapse: collapse;
	}
	
	th{
		background: #F0E1B9FF;
	}

	</style>
	
	<h1>All Items</h1>
	<table style="width:100%">
	<thead>
	    <tr>
	        <th>Auction ID</th>
	        <th>Item ID</th>
	        <th>Item Name</th>
	        <th>See Status of Bidding</th>
	        <th>See Similar Items (by type) from the Preceding Month</th>
	        <th>Add Item to WishList</th>
	    </tr>
	</thead>
	<tbody>
	<%
	
	while(resultSet.next()){
		out.print("<tr>");
		out.print("<td>");
		out.print(resultSet.getInt("auctionID"));
		out.print("</td>");
		out.print("<td>");
		out.print(resultSet.getInt("itemID"));
		out.print("</td>");
		out.print("<td>");
		out.print(resultSet.getString("name"));
		out.print("</td>");
		out.print("<td>");
		out.print("<form action='StatusOfBidding.jsp' method='post'><button style=background-color:#90D5EC name='statusOfBidding' type='submit' value='"
				+ resultSet.getInt("itemID") + "'>See Current Status Of Bidding</button></form>");
		out.print("</td>");
		out.print("<td>");
		out.print("<form action='SimilarItems.jsp' method='post'><button style=background-color:#90D5EC name='similarItems' type='submit' value='"
				+ resultSet.getInt("itemID") + "'>See Similar Items</button></form>");
		out.print("</td>");
		out.print("<td>");
		out.print("<form action='AddToWishList.jsp' method='post'><button style=background-color:#90D5EC name='wishItem' type='submit' value='"
				+ resultSet.getInt("auctionID") + "'>Add Item To Wishlist</button></form>");
		out.print("</td>");
	}
	
	
	connection.close();
	%>
	
	</tbody>
	</table>



</body>
</html>