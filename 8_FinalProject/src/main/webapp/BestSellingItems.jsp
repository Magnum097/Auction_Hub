<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Best Selling Item in the Auction</title>
</head>
<body style="font-size:15pt; background-color:#FAEBEFFF;">
<button onclick="window.location.href='AdminSuccess.jsp';">Return to dashboard</button>

		<%@ page import ="java.sql.*" %>
	<%ApplicationDB database = new ApplicationDB();	
	Connection connection = database.getConnection();	
	Statement statement = connection.createStatement();
	ResultSet resultSet = statement.executeQuery("select a.itemID, s.name, a.HighestBid from auction a, shoes s where a.itemID = s.shoeID and a.HighestBid >= a.hiddenMinimumPrice and a.closingDate < now() order by a.HighestBid DESC LIMIT 3");
	%>
	<style>
	table, th, td {
	  border: 1px solid black;
	  border-collapse: collapse;
	}
	</style>
	<h1>Top sold items</h1>
	<table style="width:100%">
	<thead>
	    <tr>
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